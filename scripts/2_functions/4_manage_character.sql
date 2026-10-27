CREATE OR REPLACE FUNCTION save_character(entity_id UUID, node_map JSONB)
RETURNS void
LANGUAGE sql
AS $$
    WITH new_values AS (
		INSERT INTO static_components (entity_id, template_id, value)
		SELECT
			$1 AS entity_id,
			nodes.template_id as template_id,
			map.value
		FROM (SELECT m.n::UUID as node_id, m.v::JSONB as value FROM jsonb_each(node_map) AS m(n, v)) map
		JOIN nodes ON nodes.id = map.node_id
		ON CONFLICT (entity_id, template_id)
		DO UPDATE SET value = EXCLUDED.value
		RETURNING template_id
	)

	DELETE FROM static_components
	WHERE
		entity_id = $1 AND
	 	template_id NOT in (SELECT * FROM new_values)
$$;

CREATE OR REPLACE FUNCTION update_dynamic_components(entity_id UUID, component_map JSONB)
RETURNS void
LANGUAGE sql
AS $$
    WITH new_values AS (
        INSERT INTO dynamic_components (entity_id, template_id, value)
        SELECT
            entity_id AS entity_id,
            m.n::UUID AS template_id,
            m.v AS value
        FROM jsonb_each(component_map) AS m(n, v)
        ON CONFLICT (entity_id, template_id)
        DO UPDATE SET value = EXCLUDED.value
        RETURNING template_id
    )
    DELETE FROM dynamic_components
    WHERE
        entity_id = entity_id
        AND template_id NOT IN (SELECT template_id FROM new_values);
$$;

CREATE OR REPLACE FUNCTION get_static_components(entity_id UUID)
RETURNS TABLE (
    template_id UUID,
    value JSONB
)
LANGUAGE sql
AS $$
SELECT
    template_id,
    value
FROM static_components sc
WHERE sc.entity_id = entity_id
$$;
