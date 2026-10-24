

ALTER TABLE "entities"
ADD FOREIGN KEY("ruleset_id") REFERENCES "rulesets"("id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "static_components"
ADD FOREIGN KEY("entity_id") REFERENCES "entities"("id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "static_components"
ADD FOREIGN KEY("template_id") REFERENCES "static_components_templates"("id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "dynamic_components"
ADD FOREIGN KEY("entity_id") REFERENCES "entities"("id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "dynamic_components"
ADD FOREIGN KEY("template_id") REFERENCES "dynamic_components_templates"("id")
ON UPDATE NO ACTION ON DELETE CASCADE;
