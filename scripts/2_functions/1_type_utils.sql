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
--
-- SELECT * FROM get_type_arborescence('c1a87c0a-6cc8-4108-ac23-850af12ed2b1'::uuid);
--
-- and you will get
--
-- |id                          |base_type_id                |name       |restrictions           |depth  |
-- |"c1a87c0a-6cc8-4108-..."    |"b1a87c0a-6cc8-4108-..."    |"positive" |{"min": 1}             |0      |
-- |"b1a87c0a-6cc8-4108-..."    |null                        |"number"   |{"min": 1, "max": 20}  |1      |
--
-- Description:
-- This function uses a recursive common table expression (CTE) to traverse up the type inheritance
-- chain starting from a given target type ID, returning the arborescence of types, accumulated
-- restrictions along the chain, and the depth of each inheritance level.
-- this function is used to get the base type of a type with his uuid, and also to fetch the verification
-- scripts in the correct order with the correct restrictions
