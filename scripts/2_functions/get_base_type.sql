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

-- EXEMPLE OF USAGE
--  SELECT * FROM get_type_arborescence('517bf0f4-ec17-4f0b-aa9f-25d78d1468c9')

-- and you will get
-- id                                       base_type_id                            name            restrictions                depth
-- "517bf0f4-ec17-4f0b-aa9f-25d78d1468c9"	"f79c6225-baf0-45af-81c6-8eb45d1a961f"	"better stat"	"{""max"": 22}"         	0
-- "f79c6225-baf0-45af-81c6-8eb45d1a961f"	"458b7c0a-6cc8-4108-ac23-850af12ed2b7"	"stat"	        "{""max"": 22, ""min"": 0}"	1
-- "458b7c0a-6cc8-4108-ac23-850af12ed2b7"	NULL                                   	"number"        "{""max"": 22, ""min"": 0}"	2


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

CREATE OR REPLACE FUNCTION get_verifications(target_type_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
AS $$
DECLARE
    result JSONB;
BEGIN
    WITH type_data AS (
        SELECT * FROM get_type_arborescence(target_type_id)
    ),
    -- Grab the final accumulated restrictions from the target type (depth = 0)
    final_restrictions AS (
        SELECT restrictions
        FROM type_data
        ORDER BY depth DESC
        LIMIT 1
    ),
    -- Fetch scripts for all matching types in the tree
    ordered_scripts AS (
        SELECT
            tvs.script,
            td.depth
        FROM type_data td
        INNER JOIN type_verification_scripts tvs ON tvs.argument_type = td.id
        ORDER BY td.depth DESC  -- Runs base type scripts first, then child overrides
    )
    SELECT
        jsonb_build_object(
            'restrictions', COALESCE((SELECT restrictions FROM final_restrictions), '{}'::jsonb),
            'scripts', COALESCE((
                SELECT jsonb_agg(script ORDER BY depth DESC)
                FROM ordered_scripts
            ), '[]'::jsonb)
        ) INTO result;

    RETURN result;
END;
$$;
