INSERT INTO accounts.users (id, email, name, password, role)
VALUES
('ebeb6c5b-1f6f-4ec6-a634-4c0b7c17a480', 'srd5.ruleset@dengine.fr', 'srd5_owner', 'pushpushpush', 'admin');

INSERT INTO games.rulesets (id, creator_id, name)
VALUES
('58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'ebeb6c5b-1f6f-4ec6-a634-4c0b7c17a480', 'SRD5');

INSERT INTO games.tags (id, ruleset_id, name)
VALUES
('9f326a68-0d8f-44d4-862f-b73e2f62a359', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'spell'),
('5dc19972-f34b-4a44-93b1-7155d0581ac1', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'playable'),
('7bc2defc-760c-4c72-a798-7fe1c89dde80', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'weapon'),
('27820178-43fd-4eb0-b308-8b2e49b53f34', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'class'),
('ed31e93d-fcf0-4275-8451-59a1b30615aa', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'level1'),
('63a2a819-1cb9-4e14-b9e9-cc724c5b69c2', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'level2');

INSERT INTO games.entities (id, ruleset_id, owner_id, name)
VALUES
('c9b52124-d768-4bea-a29b-90604517dfb4', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'ebeb6c5b-1f6f-4ec6-a634-4c0b7c17a480', 'Bob le bricoleur');

INSERT INTO games.components_types (id, ruleset_id, name, type, metadata)
VALUES
('0fcc9e1b-ad9a-414d-b245-a809b9c194c3', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'BaseStat', 'number', '{"number":"int","min":0,"max":20}'),
('05a6e8a2-8fab-4f6d-81c1-0b2e81a43882', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Number', 'number', '{"number":"int"}'),
('909b06d4-8b46-4b31-af1f-f61f51b35277', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'ClassChooser', 'enum_tag', '{"tags":["class"]}');

INSERT INTO games.components_templates (id, ruleset_id, name, type)
VALUES
('cce43266-0ef0-4f62-868e-8ccddc7db472', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'TestNumber', '05a6e8a2-8fab-4f6d-81c1-0b2e81a43882'),
('c91e2727-811b-4ca6-a6b8-9a3395840947', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Strength', '0fcc9e1b-ad9a-414d-b245-a809b9c194c3'),
('5b2aa49c-317d-4521-b78d-0d1fcfa5b3e6', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Dexterity', '0fcc9e1b-ad9a-414d-b245-a809b9c194c3'),
('9acb6bf0-1da5-454f-8467-8f1eb3634ac8', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Constitution', '0fcc9e1b-ad9a-414d-b245-a809b9c194c3'),
('f00751ab-21f0-4d6c-ab37-2eec68756a36', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Intelligence', '0fcc9e1b-ad9a-414d-b245-a809b9c194c3'),
('0975cf90-82ab-4126-89f3-60ab3a30897e', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Wisdom', '0fcc9e1b-ad9a-414d-b245-a809b9c194c3'),
('0e6a0677-15ab-4374-83f1-df28cfa944f9', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Charisma', '0fcc9e1b-ad9a-414d-b245-a809b9c194c3'),
('1cc5b258-d87a-4e84-9828-86fefe5d5ec4', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Class', '909b06d4-8b46-4b31-af1f-f61f51b35277');

INSERT INTO games.components_creations (id, ruleset_id, condition)
VALUES
('008dbe54-2343-45e0-b8f3-496a36972338', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', '{"operator":"==","value":"04ba4eeb-322c-4641-ad74-50c2d6a00e72"}'),
('a8b960a3-f915-427e-bfb5-d0929191cb83', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', '{"operator":"==","value":"f7ac51b2-b561-49b2-8945-596a3b1a26ee"}'),
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', '{}'),
('0c0292e2-c725-4a4d-88f3-fcf9e117bff3', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', '{}');

INSERT INTO games.items (id, ruleset_id, name, description, metadata)
VALUES
('04ba4eeb-322c-4641-ad74-50c2d6a00e72', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Barbarian', 'WRAAAAAAAAA', '{}'),
('f7ac51b2-b561-49b2-8945-596a3b1a26ee', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Sorcerer', 'Spell catser class', '{}'),
('03bea715-5aee-4f2d-8785-860a9a686be5', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Cleric', 'Spell catser class but with good mele', '{}'),
('f9446912-dde1-4831-8cde-475710dcd9fd', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Long Sword', 'This is a sword that sweep like in minecraft', '{"weight": 1.5}'),
('c975dcb9-2d98-46fa-9c09-3edc44874cb4', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Fireball', 'Big boom', '{"range": 45,"components":["V", "S", "M"],"materials":["tiny ball of bat guano","sulfur"]}');

INSERT INTO games.effects (id, ruleset_id, trigger, expression)
VALUES
('02dc8368-13aa-4745-a0dd-044daa9b3d39', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'on_hit', 'target.health -= strength.roll(1d8)');

-- LINKS

INSERT INTO games.creations_templates (creation_id, template_id)
VALUES
('0c0292e2-c725-4a4d-88f3-fcf9e117bff3', '1cc5b258-d87a-4e84-9828-86fefe5d5ec4'),
('008dbe54-2343-45e0-b8f3-496a36972338', 'cce43266-0ef0-4f62-868e-8ccddc7db472'),
('a8b960a3-f915-427e-bfb5-d0929191cb83', 'cce43266-0ef0-4f62-868e-8ccddc7db472'),
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', 'c91e2727-811b-4ca6-a6b8-9a3395840947'),
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', '5b2aa49c-317d-4521-b78d-0d1fcfa5b3e6'),
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', '9acb6bf0-1da5-454f-8467-8f1eb3634ac8'),
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', 'f00751ab-21f0-4d6c-ab37-2eec68756a36'),
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', '0975cf90-82ab-4126-89f3-60ab3a30897e'),
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', '0e6a0677-15ab-4374-83f1-df28cfa944f9');

INSERT INTO games.creations_links (node_id, parent_id, child_id)
VALUES
('008dbe54-2343-45e0-b8f3-496a36972338', '0c0292e2-c725-4a4d-88f3-fcf9e117bff3', '33153cff-6c40-4cce-85e5-aabfb63d6cc8'),
('a8b960a3-f915-427e-bfb5-d0929191cb83', '0c0292e2-c725-4a4d-88f3-fcf9e117bff3', '33153cff-6c40-4cce-85e5-aabfb63d6cc8');

INSERT INTO games.creations_links (node_id, parent_id)
VALUES
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', '008dbe54-2343-45e0-b8f3-496a36972338'),
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', 'a8b960a3-f915-427e-bfb5-d0929191cb83');

INSERT INTO games.creations_links (node_id, child_id)
VALUES
('0c0292e2-c725-4a4d-88f3-fcf9e117bff3', '008dbe54-2343-45e0-b8f3-496a36972338'),
('0c0292e2-c725-4a4d-88f3-fcf9e117bff3', 'a8b960a3-f915-427e-bfb5-d0929191cb83');

INSERT INTO games.entities_tags (entity_id, tag_id)
VALUES
('c9b52124-d768-4bea-a29b-90604517dfb4', '5dc19972-f34b-4a44-93b1-7155d0581ac1');

INSERT INTO games.items_tags (item_id, tag_id)
VALUES
('04ba4eeb-322c-4641-ad74-50c2d6a00e72', '27820178-43fd-4eb0-b308-8b2e49b53f34'),
('f7ac51b2-b561-49b2-8945-596a3b1a26ee', '27820178-43fd-4eb0-b308-8b2e49b53f34'),
('03bea715-5aee-4f2d-8785-860a9a686be5', '27820178-43fd-4eb0-b308-8b2e49b53f34'),
('f9446912-dde1-4831-8cde-475710dcd9fd', '7bc2defc-760c-4c72-a798-7fe1c89dde80'),
('c975dcb9-2d98-46fa-9c09-3edc44874cb4', '63a2a819-1cb9-4e14-b9e9-cc724c5b69c2'),
('c975dcb9-2d98-46fa-9c09-3edc44874cb4', '9f326a68-0d8f-44d4-862f-b73e2f62a359');

INSERT INTO games.effects_items (effect_id, item_id)
VALUES
('02dc8368-13aa-4745-a0dd-044daa9b3d39', 'f9446912-dde1-4831-8cde-475710dcd9fd');
