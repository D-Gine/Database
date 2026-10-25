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
