CREATE TABLE IF NOT EXISTS "rulesets" (
	"id" UUID NOT NULL DEFAULT gen_random_uuid(),
	"name" VARCHAR(255) NOT NULL,
	"description" TEXT,
	PRIMARY KEY("id")
);
