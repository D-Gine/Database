CREATE TABLE IF NOT EXISTS "static_components_templates" (
	"id" UUID NOT NULL DEFAULT gen_random_uuid(),
	"ruleset_id" UUID NOT NULL,
	"name" VARCHAR(255) NOT NULL,
	"description" TEXT NOT NULL,
	"type_id" UUID NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "dynamic_components_templates" (
	"id" UUID NOT NULL DEFAULT gen_random_uuid(),
	"ruleset_id" UUID NOT NULL,
	"name" VARCHAR(255) NOT NULL,
	"description" TEXT NOT NULL,
	"type_id" UUID NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "component_dependency" (
	"static_id" UUID NOT NULL,
	"dynamic_id" UUID NOT NULL,
	PRIMARY KEY("static_id", "dynamic_id")
);
