CREATE TABLE IF NOT EXISTS "types" (
	"id" UUID NOT NULL DEFAULT gen_random_uuid(),
	"ruleset_id" UUID NOT NULL,
	"base_type_id" UUID,
	"name" VARCHAR(255) NOT NULL,
	"restrictions" JSONB,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "enums" (
	"id" UUID NOT NULL DEFAULT gen_random_uuid(),
	"ruleset_id" UUID NOT NULL,
	"name" VARCHAR(255),
	"description" TEXT,
	"metadata" JSONB,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "tags" (
	"id" UUID NOT NULL DEFAULT gen_random_uuid(),
	"ruleset_id" UUID NOT NULL,
	"tag" VARCHAR(255) NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "link_enums_tags" (
	"enum_id" UUID NOT NULL,
	"tag_id" UUID NOT NULL,
	PRIMARY KEY("enum_id", "tag_id")
);

CREATE TABLE IF NOT EXISTS "type_generation_scripts" (
	"id" UUID NOT NULL DEFAULT gen_random_uuid(),
	"type_id" UUID NOT NULL,
	"script" TEXT NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "type_verification_scripts" (
	"id" UUID NOT NULL DEFAULT gen_random_uuid(),
	"argument_type" UUID NOT NULL UNIQUE,
	"script" TEXT NOT NULL,
	PRIMARY KEY("id")
);
