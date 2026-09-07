ALTER TABLE "static_components_templates"
ADD FOREIGN KEY("ruleset_id") REFERENCES "rulesets"("id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "static_components_templates"
ADD FOREIGN KEY("type_id") REFERENCES "types"("id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "dynamic_components_templates"
ADD FOREIGN KEY("ruleset_id") REFERENCES "rulesets"("id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "dynamic_components_templates"
ADD FOREIGN KEY("type_id") REFERENCES "types"("id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "component_dependency"
ADD FOREIGN KEY("static_id") REFERENCES "static_components_templates"("id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "component_dependency"
ADD FOREIGN KEY("dynamic_id") REFERENCES "dynamic_components_templates"("id")
ON UPDATE NO ACTION ON DELETE CASCADE;
