CREATE TABLE IF NOT EXISTS "character_sheet" (
	"id" UUID NOT NULL DEFAULT gen_random_uuid(),
	"ruleset_id" UUID NOT NULL UNIQUE,
	"config" JSONB NOT NULL,
	PRIMARY KEY("id")
);
