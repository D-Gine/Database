CREATE SCHEMA IF NOT EXISTS games;

----------------------------------
------------- TABLES -------------
----------------------------------

CREATE TABLE IF NOT EXISTS games.rulesets (
    id          UUID			DEFAULT uuid_generate_v4()  NOT NULL UNIQUE,
    creator_id  UUID,
    name        VARCHAR(255)								NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (creator_id)	REFERENCES accounts.users(id)
);

CREATE TABLE IF NOT EXISTS games.tags (
    id          UUID            DEFAULT uuid_generate_v4() NOT NULL UNIQUE,
    ruleset_id  UUID					                   NOT NULL,
    name        VARCHAR(255)                               NOT NULL UNIQUE,
    FOREIGN KEY (ruleset_id)	REFERENCES games.rulesets(id)
);

CREATE TABLE IF NOT EXISTS games.entities (
    id          UUID	DEFAULT uuid_generate_v4()  NOT NULL UNIQUE,
    ruleset_id  UUID								NOT NULL,
    owner_id    UUID                                NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (ruleset_id)	REFERENCES games.rulesets(id),
    FOREIGN KEY (owner_id)	    REFERENCES accounts.users(id)
);

CREATE TYPE CMPT_TYPE AS ENUM('number','string','enum_tag', 'string_input', 'fixed_size_list');

CREATE TABLE IF NOT EXISTS games.components_types (
    id          UUID	DEFAULT uuid_generate_v4()  NOT NULL UNIQUE,
    ruleset_id  UUID								NOT NULL,
    name        VARCHAR(255),
    type        CMPT_TYPE,
    metadata    JSONB,
    PRIMARY KEY (id),
    FOREIGN KEY (ruleset_id)	REFERENCES games.rulesets(id)
);

CREATE TABLE IF NOT EXISTS games.components_templates (
    id          UUID			DEFAULT uuid_generate_v4()  NOT NULL UNIQUE,
    ruleset_id  UUID										NOT NULL,
    name        VARCHAR(255)								NOT NULL,
    type        UUID                                        NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (ruleset_id)	REFERENCES games.rulesets(id),
    FOREIGN KEY (type)	        REFERENCES games.components_types(id)
);

CREATE TABLE IF NOT EXISTS games.components_creations (
    id              UUID	    DEFAULT uuid_generate_v4()	NOT NULL UNIQUE,
    ruleset_id      UUID								    NOT NULL,
	condition       JSONB,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS games.components (
    id          UUID	DEFAULT uuid_generate_v4()	NOT NULL UNIQUE,
    ruleset_id  UUID								NOT NULL,
    template_id	UUID								NOT NULL,
    name        VARCHAR(255)						NOT NULL,
    value       JSONB,
    PRIMARY KEY (id),
    FOREIGN KEY (ruleset_id)	REFERENCES games.rulesets(id),
    FOREIGN KEY (template_id)	REFERENCES games.components_templates(id)
);

CREATE TABLE IF NOT EXISTS games.items (
    id          UUID	DEFAULT uuid_generate_v4()	NOT NULL UNIQUE,
    ruleset_id  UUID								NOT NULL,
    name        VARCHAR(255)						NOT NULL,
    description	TEXT,
	metadata 	JSONB,
    PRIMARY KEY (id),
    FOREIGN KEY (ruleset_id)	REFERENCES games.rulesets(id)
);

CREATE TABLE IF NOT EXISTS games.effects (
    id          UUID	DEFAULT uuid_generate_v4()	NOT NULL UNIQUE,
    ruleset_id  UUID								NOT NULL,
    trigger		VARCHAR(255)						NOT NULL,
    expression	TEXT,
    PRIMARY KEY (id),
    FOREIGN KEY (ruleset_id)	REFERENCES games.rulesets(id)
);

----------------------------------
------------- LINKS --------------
----------------------------------

CREATE TABLE IF NOT EXISTS games.components_entities (
	entity_id    UUID								NOT NULL,
	component_id UUID								NOT NULL,
	PRIMARY KEY (entity_id, component_id),
	FOREIGN KEY (entity_id)		REFERENCES games.entities(id) ON DELETE CASCADE,
	FOREIGN KEY (component_id)	REFERENCES games.components(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS games.components_types_templates (
	type_id     UUID								NOT NULL,
	template_id UUID								NOT NULL,
	PRIMARY KEY (type_id, template_id),
	FOREIGN KEY (type_id)		REFERENCES games.components_types(id) ON DELETE CASCADE,
	FOREIGN KEY (template_id)	REFERENCES games.components_templates(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS games.components_templates_links (
	component_id    UUID								NOT NULL,
	template_id     UUID								NOT NULL,
	PRIMARY KEY (component_id, template_id),
	FOREIGN KEY (component_id)	REFERENCES games.components(id) ON DELETE CASCADE,
	FOREIGN KEY (template_id)	REFERENCES games.components_templates(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS games.creations_templates (
	creation_id     UUID								NOT NULL,
	template_id     UUID								NOT NULL,
	PRIMARY KEY (creation_id, template_id),
	FOREIGN KEY (creation_id)	REFERENCES games.components_creations(id) ON DELETE CASCADE,
	FOREIGN KEY (template_id)	REFERENCES games.components_templates(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS games.entities_tags (
    entity_id   UUID    NOT NULL,
    tag_id      UUID    NOT NULL,
    PRIMARY KEY (entity_id, tag_id),
    FOREIGN KEY (entity_id) REFERENCES games.entities(id) ON DELETE CASCADE,
	FOREIGN KEY (tag_id)    REFERENCES games.tags(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS games.items_tags (
    item_id UUID    NOT NULL,
    tag_id  UUID    NOT NULL,
    PRIMARY KEY (item_id, tag_id),
    FOREIGN KEY (item_id)   REFERENCES games.items(id) ON DELETE CASCADE,
	FOREIGN KEY (tag_id)    REFERENCES games.tags(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS games.components_items (
	component_id	UUID	NOT NULL,
	item_id			UUID	NOT NULL,
	PRIMARY KEY (component_id, item_id),
	FOREIGN KEY (component_id)				REFERENCES games.components(id) ON DELETE CASCADE,
	FOREIGN KEY (item_id)					REFERENCES games.items(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS games.effects_items (
	effect_id	UUID	NOT NULL,
	item_id		UUID	NOT NULL,
	PRIMARY KEY (effect_id, item_id),
	FOREIGN KEY (effect_id)				REFERENCES games.effects(id) ON DELETE CASCADE,
	FOREIGN KEY (item_id)				REFERENCES games.items(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS games.creations_links (
	parent_id	UUID	        NOT NULL,
	node_id     UUID            NOT NULL,
	child_id	UUID	        NOT NULL,
	PRIMARY KEY (parent_id, node_id, child_id),
	FOREIGN KEY (parent_id)	    REFERENCES games.components_creations(id) ON DELETE CASCADE,
	FOREIGN KEY (node_id)	    REFERENCES games.components_creations(id) ON DELETE CASCADE,
	FOREIGN KEY (child_id)		REFERENCES games.components_creations(id) ON DELETE CASCADE
);
