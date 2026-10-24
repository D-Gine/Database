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
('909b06d4-8b46-4b31-af1f-f61f51b35277', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'ClassChooser', 'enum_tag', '{"tags":["class"]}'),
('e7cef725-3d28-4dc1-bc7f-7baa63a5eafe', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'SpellChooserLevel1', 'enum_tag', '{"tags":["spell", "level1"]}'),
('963709a4-b7d6-490c-8a95-e060834db54f', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'SpellChooserLevel2', 'enum_tag', '{"tags":["spell", "level2"]}');

INSERT INTO games.components_templates (id, ruleset_id, name, type)
VALUES
('c91e2727-811b-4ca6-a6b8-9a3395840947', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Strength', '0fcc9e1b-ad9a-414d-b245-a809b9c194c3'),
('5b2aa49c-317d-4521-b78d-0d1fcfa5b3e6', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Dexterity', '0fcc9e1b-ad9a-414d-b245-a809b9c194c3'),
('9acb6bf0-1da5-454f-8467-8f1eb3634ac8', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Constitution', '0fcc9e1b-ad9a-414d-b245-a809b9c194c3'),
('f00751ab-21f0-4d6c-ab37-2eec68756a36', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Intelligence', '0fcc9e1b-ad9a-414d-b245-a809b9c194c3'),
('0975cf90-82ab-4126-89f3-60ab3a30897e', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Wisdom', '0fcc9e1b-ad9a-414d-b245-a809b9c194c3'),
('0e6a0677-15ab-4374-83f1-df28cfa944f9', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Charisma', '0fcc9e1b-ad9a-414d-b245-a809b9c194c3'),
('2e73eeba-3d3c-4a77-a9a2-69a73bec5b88', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Level 1 Spells', 'e7cef725-3d28-4dc1-bc7f-7baa63a5eafe'),
('98d5a6d3-629e-4096-8c1c-e76d5332179d', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Level 2 Spells', '963709a4-b7d6-490c-8a95-e060834db54f'),
('1cc5b258-d87a-4e84-9828-86fefe5d5ec4', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Class', '909b06d4-8b46-4b31-af1f-f61f51b35277');

-- Creation nodes
-- Note: We use multiple nodes for spell selection paths to handle different class conditions
INSERT INTO games.components_creations (id, ruleset_id, condition)
VALUES
('0c0292e2-c725-4a4d-88f3-fcf9e117bff3', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', '{}'),                                                    -- Class chooser (root, no condition)
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', '{"operator":"==","value":"04ba4eeb-322c-4641-ad74-50c2d6a00e72"}'),  -- Stats (Barbarian condition)
('f0de5164-232b-4ab1-9207-dca2845c4024', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', '{"operator":"==","value":"f7ac51b2-b561-49b2-8945-596a3b1a26ee"}'),  -- Level 1 spells (Sorcerer condition)
('aa111111-1111-1111-1111-111111111111', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', '{"operator":"==","value":"03bea715-5aee-4f2d-8785-860a9a686be5"}'),  -- Level 1 spells (Cleric condition) - duplicate node for Cleric
('59ed9841-84d2-4e13-b549-d2be05e7b3e8', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', '{}'),                                                    -- Level 2 spells (no condition, comes after level 1)
('bb222222-2222-2222-2222-222222222222', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', '{}');                                                    -- Stats (no condition, comes after spell selection)

INSERT INTO games.items (id, ruleset_id, name, description, metadata)
VALUES
('04ba4eeb-322c-4641-ad74-50c2d6a00e72', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Barbarian', 'WRAAAAAAAAA', '{}'),
('f7ac51b2-b561-49b2-8945-596a3b1a26ee', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Sorcerer', 'Spell caster class', '{}'),
('03bea715-5aee-4f2d-8785-860a9a686be5', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Cleric', 'Spell caster class but with good melee', '{}'),
('f9446912-dde1-4831-8cde-475710dcd9fd', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Long Sword', 'This is a sword that sweep like in minecraft', '{"weight": 1.5}'),
('c975dcb9-2d98-46fa-9c09-3edc44874cb4', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Fireball', 'Big boom', '{"range": 45,"components":["V", "S", "M"],"materials":["tiny ball of bat guano","sulfur"]}'),
('552f2201-77b7-4ade-8355-35f73cdd4653', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Magic Missile', 'You create three glowing darts of magical force.', '{"range": 120,"components":["V", "S"]}'),
('5e411b0e-9bca-45ff-9f4c-4d4238b1aa8a', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'Armor of Agathys', 'A protective magical force surrounds you.', '{"range": -1,"components":["V", "S", "M"],"materials":["a cup of water"]}');

INSERT INTO games.effects (id, ruleset_id, trigger, expression)
VALUES
('02dc8368-13aa-4745-a0dd-044daa9b3d39', '58e6aaee-5bd0-4b3d-b6db-b5c6c390b3ce', 'on_hit', 'target.health -= strength.roll(1d8)');

-- LINKS: Assign templates to creation nodes

INSERT INTO games.creations_templates (creation_id, template_id)
VALUES
-- Class chooser
('0c0292e2-c725-4a4d-88f3-fcf9e117bff3', '1cc5b258-d87a-4e84-9828-86fefe5d5ec4'),

-- Stats chooser (for Barbarian - direct path)
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', 'c91e2727-811b-4ca6-a6b8-9a3395840947'),
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', '5b2aa49c-317d-4521-b78d-0d1fcfa5b3e6'),
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', '9acb6bf0-1da5-454f-8467-8f1eb3634ac8'),
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', 'f00751ab-21f0-4d6c-ab37-2eec68756a36'),
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', '0975cf90-82ab-4126-89f3-60ab3a30897e'),
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', '0e6a0677-15ab-4374-83f1-df28cfa944f9'),

-- Level 1 spells (Sorcerer path)
('f0de5164-232b-4ab1-9207-dca2845c4024', '2e73eeba-3d3c-4a77-a9a2-69a73bec5b88'),

-- Level 1 spells (Cleric path - same templates, different node)
('aa111111-1111-1111-1111-111111111111', '2e73eeba-3d3c-4a77-a9a2-69a73bec5b88'),

-- Level 2 spells
('59ed9841-84d2-4e13-b549-d2be05e7b3e8', '98d5a6d3-629e-4096-8c1c-e76d5332179d'),

-- Stats chooser (for spell casters - after spell selection)
('bb222222-2222-2222-2222-222222222222', 'c91e2727-811b-4ca6-a6b8-9a3395840947'),
('bb222222-2222-2222-2222-222222222222', '5b2aa49c-317d-4521-b78d-0d1fcfa5b3e6'),
('bb222222-2222-2222-2222-222222222222', '9acb6bf0-1da5-454f-8467-8f1eb3634ac8'),
('bb222222-2222-2222-2222-222222222222', 'f00751ab-21f0-4d6c-ab37-2eec68756a36'),
('bb222222-2222-2222-2222-222222222222', '0975cf90-82ab-4126-89f3-60ab3a30897e'),
('bb222222-2222-2222-2222-222222222222', '0e6a0677-15ab-4374-83f1-df28cfa944f9');

-- TREE STRUCTURE
-- Root: Class chooser (0c0292e2) with 3 children based on class selection

INSERT INTO games.creations_links (node_id, parent_id, child_id)
VALUES
-- From Class chooser to either Stats (Barbarian) or Level 1 Spells (Sorcerer/Cleric)
('33153cff-6c40-4cce-85e5-aabfb63d6cc8', '0c0292e2-c725-4a4d-88f3-fcf9e117bff3', NULL),  -- Barbarian → Stats (last node)
('f0de5164-232b-4ab1-9207-dca2845c4024', '0c0292e2-c725-4a4d-88f3-fcf9e117bff3', '59ed9841-84d2-4e13-b549-d2be05e7b3e8'),  -- Sorcerer → Level 1 → Level 2
('aa111111-1111-1111-1111-111111111111', '0c0292e2-c725-4a4d-88f3-fcf9e117bff3', '59ed9841-84d2-4e13-b549-d2be05e7b3e8'),  -- Cleric → Level 1 → Level 2

-- From Level 2 Spells to Stats
('59ed9841-84d2-4e13-b549-d2be05e7b3e8', 'f0de5164-232b-4ab1-9207-dca2845c4024', 'bb222222-2222-2222-2222-222222222222'),  -- Sorcerer: Level 2 → Stats
('59ed9841-84d2-4e13-b549-d2be05e7b3e8', 'aa111111-1111-1111-1111-111111111111', 'bb222222-2222-2222-2222-222222222222'),  -- Cleric: Level 2 → Stats

-- Stats chooser as final node (no child)
('bb222222-2222-2222-2222-222222222222', '59ed9841-84d2-4e13-b549-d2be05e7b3e8', NULL);

INSERT INTO games.creations_links (node_id, child_id)
VALUES
-- Class chooser has 3 possible children
('0c0292e2-c725-4a4d-88f3-fcf9e117bff3', '33153cff-6c40-4cce-85e5-aabfb63d6cc8'),  -- Barbarian path
('0c0292e2-c725-4a4d-88f3-fcf9e117bff3', 'f0de5164-232b-4ab1-9207-dca2845c4024'),  -- Sorcerer path
('0c0292e2-c725-4a4d-88f3-fcf9e117bff3', 'aa111111-1111-1111-1111-111111111111');  -- Cleric path

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
('5e411b0e-9bca-45ff-9f4c-4d4238b1aa8a', 'ed31e93d-fcf0-4275-8451-59a1b30615aa'),
('552f2201-77b7-4ade-8355-35f73cdd4653', 'ed31e93d-fcf0-4275-8451-59a1b30615aa'),
('c975dcb9-2d98-46fa-9c09-3edc44874cb4', '9f326a68-0d8f-44d4-862f-b73e2f62a359');

INSERT INTO games.effects_items (effect_id, item_id)
VALUES
('02dc8368-13aa-4745-a0dd-044daa9b3d39', 'f9446912-dde1-4831-8cde-475710dcd9fd');
