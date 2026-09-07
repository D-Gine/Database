CREATE OR REPLACE FUNCTION get_base_type_json(target_type_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
AS $$
DECLARE
    result JSONB;
BEGIN
    WITH RECURSIVE get_base AS (
        -- Anchor member: Start at the target type
        SELECT
            id,
            base_type_id,
            name,
            COALESCE(restrictions, '{}'::jsonb) AS restrictions
        FROM types
        WHERE id = target_type_id

        UNION ALL

        -- Recursive member: Traverse up the inheritance chain
        SELECT
            base.id AS id,
            base.base_type_id AS base_type_id,
            base.name AS name,
            COALESCE(base.restrictions, '{}'::jsonb) || current.restrictions AS restrictions
        FROM get_base AS current
        JOIN types base ON current.base_type_id = base.id
        WHERE current.base_type_id IS NOT NULL
    )
    SELECT
        jsonb_build_object(
            'id', id,
            'base', name,
            'restrictions', restrictions
        ) INTO result
    FROM get_base
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
