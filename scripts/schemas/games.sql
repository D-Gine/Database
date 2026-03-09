CREATE SCHEMA IF NOT EXISTS games;

----------------------------------
------------- TABLES -------------
----------------------------------

CREATE TABLE IF NOT EXISTS games.rulesets (
    id          UUID			DEFAULT uuid_generate_v4()  NOT NULL UNIQUE,
    creator_id  UUID										NOT NULL,
    name        VARCHAR(255)								NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (creator_id)	REFERENCES accounts.users(id)
);

CREATE TABLE IF NOT EXISTS games.tags (
    id          UUID            DEFAULT uuid_generate_v4() NOT NULL UNIQUE,
    ruleset_id  UUID					                   NOT NULL,
    name        VARCHAR(255)                               NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS games.entities (
    id          UUID	DEFAULT uuid_generate_v4()  NOT NULL UNIQUE,
    ruleset_id  UUID								NOT NULL,
    owner_id    UUID                                NOT NULL,
    tags        UUID,
    PRIMARY KEY (id),
    FOREIGN KEY (ruleset_id)	REFERENCES games.rulesets(id),
    FOREIGN KEY (owner_id)	    REFERENCES accounts.users(id)
);

CREATE TYPE component_type AS ENUM('int', 'float', 'enum', 'string');

CREATE TABLE IF NOT EXISTS games.components_templates (
    id          UUID			DEFAULT uuid_generate_v4()  NOT NULL UNIQUE,
    ruleset_id  UUID										NOT NULL,
    name        VARCHAR(255)								NOT NULL,
    type        COMPONENT_TYPE,
    expression  TEXT,
    PRIMARY KEY (id),
    FOREIGN KEY (ruleset_id)	REFERENCES games.rulesets(id)
);

CREATE TABLE IF NOT EXISTS games.components (
    id          UUID	DEFAULT uuid_generate_v4()	NOT NULL UNIQUE,
    ruleset_id  UUID								NOT NULL,
    template_id	UUID								NOT NULL,
    name        VARCHAR(255)						NOT NULL,
    value       TEXT,
    PRIMARY KEY (id),
    FOREIGN KEY (ruleset_id)	REFERENCES games.rulesets(id),
    FOREIGN KEY (template_id)	REFERENCES games.components_templates(id)
);

CREATE TABLE IF NOT EXISTS games.characters_templates (
    id          UUID	DEFAULT uuid_generate_v4()	NOT NULL UNIQUE,
    ruleset_id  UUID								NOT NULL,
    name        VARCHAR(255)						NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (ruleset_id)	REFERENCES games.rulesets(id)
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

CREATE TABLE IF NOT EXISTS games.entities_tags (
    entity_id UUID NOT NULL,
    tag_id UUID NOT NULL,
    PRIMARY KEY (entity_id, tag_id),
    FOREIGN KEY (entity_id) REFERENCES games.entities(id) ON DELETE CASCADE,
	FOREIGN KEY (tag_id) REFERENCES games.tags(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS games.characters_components (
	component_template_id	UUID	NOT NULL,
	character_template_id	UUID	NOT NULL,
	PRIMARY KEY (component_template_id, character_template_id),
	FOREIGN KEY (component_template_id)		REFERENCES games.components_templates(id) ON DELETE CASCADE,
	FOREIGN KEY (character_template_id)	    REFERENCES games.characters_templates(id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS games.items_tags (
    item_id UUID NOT NULL,
    tag_id UUID NOT NULL,
    PRIMARY KEY (item_id, tag_id),
    FOREIGN KEY (item_id) REFERENCES games.items(id) ON DELETE CASCADE,
	FOREIGN KEY (tag_id) REFERENCES games.tags(id) ON DELETE CASCADE
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
	item_id			UUID	NOT NULL,
	PRIMARY KEY (effect_id, item_id),
	FOREIGN KEY (effect_id)				REFERENCES games.effects(id) ON DELETE CASCADE,
	FOREIGN KEY (item_id)					REFERENCES games.items(id) ON DELETE CASCADE
);
