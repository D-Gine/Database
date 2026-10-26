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
--
-- SELECT get_base_type_json('c1a87c0a-6cc8-4108-ac23-850af12ed2b1'::uuid);
--
-- and you will get
--  {
--      "id": "0000-38473-73434-39754",
--      "base": "number",
--      "restrictions": {
--          "min": 1
--      }
--  }
--
-- Description:
-- This function fetches the root base type details (including ID, base name, and restrictions)
-- for a given target type ID by evaluating its type arborescence, and returns the result as a structured JSONB object.


CREATE OR REPLACE FUNCTION type_generation(type UUID)
RETURNS TABLE (
    id UUID,
    type_name VARCHAR(255),
    restrictions JSONB,
    script TEXT
)
LANGUAGE sql
AS $$
    SELECT
        ta.id AS id,
        ta.name AS type_name,
        ta.restrictions AS restrictions,
        tgs.script as script
    FROM get_type_arborescence(type) ta
    LEFT JOIN type_generation_scripts tgs ON tgs.type_id = ta.id
    ORDER BY
        (tgs.script IS NOT NULL) DESC,
        CASE WHEN tgs.script IS NOT NULL THEN ta.depth END ASC,
        CASE WHEN tgs.script IS NULL THEN (ta.base_type_id IS NULL) END DESC
    LIMIT 1
$$;
