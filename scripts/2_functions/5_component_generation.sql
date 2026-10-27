CREATE OR REPLACE FUNCTION get_component_dependencies(static_component_ids UUID[])
RETURNS TABLE (
    dynamic_id UUID
)
LANGUAGE sql
AS $$
    SELECT
        dynamic_id
    FROM component_dependency
    WHERE static_id = ANY(static_component_ids)
$$;



CREATE OR REPLACE FUNCTION get_dynamic_generation_infos(entity_id UUID)
RETURNS JSONB
LANGUAGE sql
AS $$
    SELECT
        jsonb_build_object(
            'static_values', jsonb_object_agg(
                sc.template_id, sc.value
            ),
            'to_generate', COALESCE((
                SELECT jsonb_object_agg(
                    cd.dynamic_id, (
                        SELECT
                        jsonb_build_object(
                            'script', tg.script,
                            'type_name', tg.type_name,
                            'restrictions', tg.restrictions
                        )
                        FROM type_generation(dct.type_id) tg
                    )
                )
                FROM get_component_dependencies(ARRAY_AGG(sc.template_id)) cd
                JOIN dynamic_components_templates dct ON dct.id = cd.dynamic_id
            ), '{}'::JSONB)
        )
    FROM get_static_components(entity_id) sc
$$;


--
-- |template_id                 |base_name          |script?                    |restrictions           |
-- |"0000-38473-73434-39754"    |"number"           |"script 1"                 |{"min": 1, "max": 20}  |
-- |"0000-38473-73434-98433"    |"string"           |NULL                       |{"max_length": 255}    |


-->
-- {
-- 	nodes: {
-- 	    to_generate: {
-- 		    "id": {
-- 		    	script?: "",
--              base: "",
-- 		    	restrictions: {}
-- 		    }
-- 	    }
-- }
