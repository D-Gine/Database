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
-- EXEMPLE OF USAGE
--
-- SELECT * FROM get_verifications(
--     ARRAY['c1a87c0a-6cc8-4108-ac23-850af12ed2b1'::uuid, 'c2a87c0a-6cc8-4108-ac23-850af12ed2b2'::uuid]
-- );
--
-- and you will get
--
-- |target_type_id              |base_name          |restrictions           |scripts                    |
-- |"c1a87c0a-6cc8-4108-..."    |"number"           |{"min": 1, "max": 20}  |["script 1", "script 2"]   |
-- |"c2a87c0a-6cc8-4108-..."    |"string"           |{"max_length": 255}    |["script 1"]               |
--
-- Description:
-- This function processes an array of target type IDs by traversing their type arborescence,
-- extracting root base names, aggregating accumulated restrictions from the inheritance tree,
-- and collecting verification scripts ordered by depth to provide comprehensive validation metadata.
-- it is mostly used as a code factorisation to avoid code duplication.


CREATE OR REPLACE FUNCTION get_nodes_verifications(node_ids UUID[], target_ruleset_id UUID)
RETURNS TABLE (
    component_id UUID,
    base_name VARCHAR(255),
    scripts TEXT[],
    restrictions JSONB
)
LANGUAGE SQL
STABLE
AS $$
SELECT
    sct.id as component_id,
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
--
-- SELECT * FROM get_nodes_verifications(
--     ARRAY['458b7c0a-6cc8-4108-ac23-850af12ed2b7'::uuid, '789b7c0a-6cc8-4108-ac23-850af12ed2b8'::uuid],
--     '123b7c0a-6cc8-4108-ac23-850af12ed2b9'::uuid
-- );
--
-- and you will get
--
-- |component_id                |base_name          |scripts                    |restrictions           |
-- |"0000-38473-73434-39754"    |"number"           |["script 1", "script 2"]   |{"min": 1, "max": 20}  |
-- |"0000-38473-73434-98433"    |"string"           |["script 1"]               |{"max_length": 255}    |
--
-- Description:
-- This function retrieves the necessary verification details (base names, execution scripts, and validation restrictions)
-- for a specific array of node IDs filtered by a target ruleset, enabling the API to validate node-associated values correctly.
-- WARNING: the scripts still only accepts the component id as key for the data you will pass them.

CREATE OR REPLACE FUNCTION get_entity_verifications(entity_id UUID)
RETURNS TABLE (
    component_id UUID,
    base_name VARCHAR(255),
    scripts TEXT[],
    restrictions JSONB
)
LANGUAGE SQL
STABLE
AS $$
SELECT
    sct.id as component_id,
    gv.base_name as base_name,
    gv.scripts as scripts,
    gv.restrictions as restrictions
FROM static_components sc
JOIN static_components_templates sct ON sct.id = sc.template_id
JOIN get_verifications(ARRAY[sct.type_id]) gv ON 1 = 1
WHERE
    sc.entity_id = entity_id
$$;
-- EXEMPLE OF USAGE
--
-- SELECT * FROM get_entity_verifications('458b7c0a-6cc8-4108-ac23-850af12ed2b7'::uuid);
--
-- and you will get
--
-- |component_id                |base_name          |scripts                    |restrictions           |
-- |"0000-38473-73434-39754"    |"number"           |["script 1", "script 2"]   |{"min": 1, "max": 20}  |
-- |"0000-38473-73434-98433"    |"string"           |["script 1"]               |{"max_length": 255}    |
--
-- Description:
-- This function helps the developer getting the necessary informations for the api to verify the validity
-- of the values entered in the associated components.
