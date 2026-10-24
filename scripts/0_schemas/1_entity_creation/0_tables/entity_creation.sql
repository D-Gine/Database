CREATE TABLE IF NOT EXISTS "nodes" (
	"id" UUID NOT NULL DEFAULT gen_random_uuid(),
	"ruleset_id" UUID NOT NULL,
	"template_id" UUID NOT NULL,
	"next_script_id" UUID,
	"next_script_params" JSONB NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "next_scripts" (
	"id" UUID NOT NULL DEFAULT gen_random_uuid(),
	"script" TEXT NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "first_nodes" (
	"node_id" UUID NOT NULL,
	"ruleset_id" UUID NOT NULL,
	PRIMARY KEY("node_id", "ruleset_id")
);
