CREATE OR REPLACE FUNCTION get_type_arborescence(target_type_id UUID)
RETURNS TABLE (
    id UUID,
    base_type_id UUID,
    name VARCHAR(255),
    restrictions JSONB,
    depth INT
)
LANGUAGE sql
AS $$
    WITH RECURSIVE get_base AS (
        -- Anchor member: Start at the target type (depth = 0)
        SELECT
            t.id,
            t.base_type_id,
            t.name,
            COALESCE(t.restrictions, '{}'::jsonb) AS restrictions,
            0 AS depth
        FROM types t
        WHERE t.id = target_type_id

        UNION ALL

        -- Recursive member: Traverse up the inheritance chain
        SELECT
            base.id,
            base.base_type_id,
            base.name,
            COALESCE(base.restrictions, '{}'::jsonb) || current.restrictions AS restrictions,
            current.depth + 1 AS depth
        FROM get_base AS current
        JOIN types base ON current.base_type_id = base.id
        WHERE current.base_type_id IS NOT NULL
    )
    SELECT
        gb.id,
        gb.base_type_id,
        gb.name,
        gb.restrictions,
        gb.depth
    FROM get_base gb;
$$;

CREATE OR REPLACE FUNCTION get_base_type_json(target_type_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
AS $$
DECLARE
    result JSONB;
BEGIN
    SELECT
        jsonb_build_object(
            'id', id,
            'base', name,
            'restrictions', restrictions
        ) INTO result
    FROM get_type_arborescence(target_type_id)
    WHERE base_type_id IS NULL;
    RETURN result;
END;
$$;

CREATE OR REPLACE FUNCTION get_verifications(target_type_ids UUID[])
RETURNS TABLE (
    target_type_id UUID,
    base_name VARCHAR(255),
    restrictions JSONB,
    scripts TEXT[]
)
LANGUAGE sql
STABLE
AS $$
WITH input_types AS (
    SELECT unnest(target_type_ids) AS target_type_id
),
type_data AS (
    SELECT
        it.target_type_id,
        tree.id AS type_id,
        tree.base_type_id,
        tree.name,
        tree.restrictions,
        tree.depth
    FROM input_types it
    CROSS JOIN LATERAL get_type_arborescence(it.target_type_id) tree
),
root_types AS (
    SELECT
        target_type_id,
        name AS base_name
    FROM type_data
    WHERE base_type_id IS NULL
),
final_restrictions AS (
    SELECT DISTINCT ON (target_type_id)
        target_type_id,
        restrictions
    FROM type_data
    ORDER BY target_type_id, depth DESC
),
ordered_scripts AS (
    SELECT
        td.target_type_id,
        array_agg(tvs.script ORDER BY td.depth DESC) AS scripts
    FROM type_data td
    INNER JOIN type_verification_scripts tvs ON tvs.argument_type = td.type_id
    GROUP BY td.target_type_id
)
SELECT
    it.target_type_id,
    rt.base_name,
    COALESCE(fr.restrictions, '{}'::jsonb) AS restrictions,
    COALESCE(os.scripts, ARRAY[]::TEXT[]) AS scripts
FROM input_types it
LEFT JOIN root_types rt ON rt.target_type_id = it.target_type_id
LEFT JOIN final_restrictions fr ON fr.target_type_id = it.target_type_id
LEFT JOIN ordered_scripts os ON os.target_type_id = it.target_type_id;
$$;

CREATE OR REPLACE FUNCTION get_nodes_verifications(node_ids UUID[], target_ruleset_id UUID)
RETURNS TABLE (
    node_id UUID,
    base_name VARCHAR(255),
    scripts TEXT[],
    restrictions JSONB
)
LANGUAGE SQL
STABLE
AS $$
SELECT
    n.id as node_id,
    gv.base_name as base_name,
    gv.scripts as scripts,
    gv.restrictions as restrictions
FROM nodes n
JOIN static_components_templates sct ON sct.id = n.template_id
JOIN get_verifications(ARRAY[sct.type_id]) gv ON 1 = 1
WHERE
    n.id = ANY(node_ids) AND
	n.ruleset_id = target_ruleset_id;
$$;



-- EXEMPLE OF USAGE
-- SELECT jsonb_build_object(
--     'node_id', 'a1b2c3d4-0000-0000-0000-000000000000'::uuid,
--     'final', true,
--     -- put the id of the top level type
--     'type', get_base_type_json('458b7c0a-6cc8-4108-ac23-850af12ed2b7')
-- );
-- and you will get
--
-- {
--   "type": {
--     "id": "458b7c0a-6cc8-4108-ac23-850af12ed2b7",
--     "base": "number",
--     "restrictions": {
--       "max": 22,
--       "min": 0
--     }
--   },
--   "final": true,
--   "node_id": "a1b2c3d4-0000-0000-0000-000000000000"
-- }
