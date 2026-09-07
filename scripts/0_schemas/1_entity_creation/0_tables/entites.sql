CREATE TABLE IF NOT EXISTS "entities" (
	"id" UUID NOT NULL DEFAULT gen_random_uuid(),
	"ruleset_id" UUID NOT NULL,
	"name" VARCHAR(255),
	"description" TEXT,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "static_components" (
	"id" UUID NOT NULL DEFAULT gen_random_uuid(),
	"entity_id" UUID NOT NULL,
	"template_id" UUID NOT NULL,
	"value" JSONB NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "dynamic_components" (
	"id" UUID NOT NULL DEFAULT gen_random_uuid(),
	"entity_id" UUID NOT NULL,
	"template_id" UUID NOT NULL,
	"value" JSONB NOT NULL,
	PRIMARY KEY("id")
);
