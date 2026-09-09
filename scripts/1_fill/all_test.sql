--
-- PostgreSQL database dump
--

\restrict ssW2dNIaeyDgdKEBOZChtboaMhdeXj1mPw1Tt3fFlL5Na07sgnrRzbJgYcFzZ4a

-- Dumped from database version 16.15
-- Dumped by pg_dump version 16.14

-- Started on 2026-09-09 15:14:06 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3597 (class 0 OID 16626)
-- Dependencies: 233
-- Data for Name: users; Type: TABLE DATA; Schema: accounts; Owner: prout
--



--
-- TOC entry 3587 (class 0 OID 16441)
-- Dependencies: 223
-- Data for Name: rulesets; Type: TABLE DATA; Schema: public; Owner: prout
--

INSERT INTO public.rulesets VALUES ('0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'test', 'test');


--
-- TOC entry 3591 (class 0 OID 16470)
-- Dependencies: 227
-- Data for Name: types; Type: TABLE DATA; Schema: public; Owner: prout
--

INSERT INTO public.types VALUES ('458b7c0a-6cc8-4108-ac23-850af12ed2b7', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', NULL, 'number', NULL);
INSERT INTO public.types VALUES ('01858199-d256-4071-90da-c212704bd7da', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', NULL, 'string', NULL);
INSERT INTO public.types VALUES ('f79c6225-baf0-45af-81c6-8eb45d1a961f', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', '458b7c0a-6cc8-4108-ac23-850af12ed2b7', 'stat', '{"max": 20, "min": 0}');
INSERT INTO public.types VALUES ('517bf0f4-ec17-4f0b-aa9f-25d78d1468c9', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'f79c6225-baf0-45af-81c6-8eb45d1a961f', 'better stat', '{"max": 22}');
INSERT INTO public.types VALUES ('46f3fe59-7eca-4529-b290-ed315e302e12', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', NULL, 'dictionary', NULL);
INSERT INTO public.types VALUES ('21ecaea4-696d-4e7c-8a31-20522674552f', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', NULL, 'list', NULL);
INSERT INTO public.types VALUES ('b4258b56-81d6-4a03-84a1-0edab70281f4', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', NULL, 'enum', NULL);
INSERT INTO public.types VALUES ('6109eca7-5b21-4c5f-906c-ae882ceb353c', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', '01858199-d256-4071-90da-c212704bd7da', 'email', NULL);


--
-- TOC entry 3589 (class 0 OID 16457)
-- Dependencies: 225
-- Data for Name: dynamic_components_templates; Type: TABLE DATA; Schema: public; Owner: prout
--



--
-- TOC entry 3588 (class 0 OID 16449)
-- Dependencies: 224
-- Data for Name: static_components_templates; Type: TABLE DATA; Schema: public; Owner: prout
--



--
-- TOC entry 3590 (class 0 OID 16465)
-- Dependencies: 226
-- Data for Name: component_dependency; Type: TABLE DATA; Schema: public; Owner: prout
--



--
-- TOC entry 3581 (class 0 OID 16396)
-- Dependencies: 217
-- Data for Name: entities; Type: TABLE DATA; Schema: public; Owner: prout
--



--
-- TOC entry 3583 (class 0 OID 16412)
-- Dependencies: 219
-- Data for Name: dynamic_components; Type: TABLE DATA; Schema: public; Owner: prout
--



--
-- TOC entry 3592 (class 0 OID 16478)
-- Dependencies: 228
-- Data for Name: enums; Type: TABLE DATA; Schema: public; Owner: prout
--

INSERT INTO public.enums VALUES ('5c93ce27-c2d0-4924-916c-abefabc0ccfd', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'Sorcerer', 'Casting spells', '{}');
INSERT INTO public.enums VALUES ('33d4255f-f405-4bb5-add5-f85e0ff43e5b', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'Barbarian', 'Hitting things', '{}');
INSERT INTO public.enums VALUES ('a87fa8f3-d56a-49ec-8bd2-d62b7f07c367', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'Bard', 'Play music', '{}');
INSERT INTO public.enums VALUES ('e87084a9-f3ba-40aa-ac4a-501fd27facb8', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'longsword', 'nice weapon', '{"type": "two_handed_weapon", "range": 3, "damage": 5, "weight": 10, "damage_type": "slashing"}');
INSERT INTO public.enums VALUES ('8dc8d9aa-98b6-475c-a5fb-c377f888c888', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'bow', 'nice bow', '{"type": "two_handed_weapon", "range": 30, "damage": 4, "weight": 4, "damage_type": "piercing"}');
INSERT INTO public.enums VALUES ('650d303e-fa01-499d-ac3b-319d7317496e', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'Cum in mouth', 'cum', '{}');
INSERT INTO public.enums VALUES ('d82a1464-7b0c-4d2a-83e7-77b659164fec', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'Fireball', 'alcohol', '{}');
INSERT INTO public.enums VALUES ('191583ba-a789-42c6-970e-df3af32c1dfc', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'Hypnose', 'Do you... Libe alon ?', '{}');
INSERT INTO public.enums VALUES ('277ef939-9bd4-49d4-9b93-243c474c2cbc', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'Charm person', 'Are you... Open mind ?', '{}');
INSERT INTO public.enums VALUES ('f1377e6b-c821-4585-9b51-ee653f7bbbe6', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'Giant', 'charlie kirk forehead', '{}');
INSERT INTO public.enums VALUES ('f552b243-81fb-4901-9b09-a140de4660f4', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'Berserker', 'mad scientist', '{}');


--
-- TOC entry 3585 (class 0 OID 16428)
-- Dependencies: 221
-- Data for Name: next_scripts; Type: TABLE DATA; Schema: public; Owner: prout
--



--
-- TOC entry 3584 (class 0 OID 16420)
-- Dependencies: 220
-- Data for Name: nodes; Type: TABLE DATA; Schema: public; Owner: prout
--



--
-- TOC entry 3586 (class 0 OID 16436)
-- Dependencies: 222
-- Data for Name: first_nodes; Type: TABLE DATA; Schema: public; Owner: prout
--



--
-- TOC entry 3593 (class 0 OID 16486)
-- Dependencies: 229
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: prout
--

INSERT INTO public.tags VALUES ('64f73b11-5699-46a2-9f63-4db41f18e472', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'class');
INSERT INTO public.tags VALUES ('0e8ef112-a906-4c50-8c68-26501212eaa0', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'object');
INSERT INTO public.tags VALUES ('2a9bf94f-1db4-48c2-9a60-63a0f65d3493', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'bard');
INSERT INTO public.tags VALUES ('110ee2a7-d94a-416f-b66d-4d26927fc268', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'sorcerer');
INSERT INTO public.tags VALUES ('080bae99-829d-4fc9-91c7-6b43b06b24b0', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'spell');
INSERT INTO public.tags VALUES ('e5a7d58f-7842-4bac-ae72-0c344883303f', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'path');
INSERT INTO public.tags VALUES ('dcc6c81e-d887-4df0-ab1f-76d0df97e63d', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'barbarian');


--
-- TOC entry 3594 (class 0 OID 16492)
-- Dependencies: 230
-- Data for Name: link_enums_tags; Type: TABLE DATA; Schema: public; Owner: prout
--

INSERT INTO public.link_enums_tags VALUES ('8dc8d9aa-98b6-475c-a5fb-c377f888c888', '0e8ef112-a906-4c50-8c68-26501212eaa0');
INSERT INTO public.link_enums_tags VALUES ('e87084a9-f3ba-40aa-ac4a-501fd27facb8', '0e8ef112-a906-4c50-8c68-26501212eaa0');
INSERT INTO public.link_enums_tags VALUES ('a87fa8f3-d56a-49ec-8bd2-d62b7f07c367', '64f73b11-5699-46a2-9f63-4db41f18e472');
INSERT INTO public.link_enums_tags VALUES ('5c93ce27-c2d0-4924-916c-abefabc0ccfd', '64f73b11-5699-46a2-9f63-4db41f18e472');
INSERT INTO public.link_enums_tags VALUES ('33d4255f-f405-4bb5-add5-f85e0ff43e5b', '64f73b11-5699-46a2-9f63-4db41f18e472');
INSERT INTO public.link_enums_tags VALUES ('650d303e-fa01-499d-ac3b-319d7317496e', '080bae99-829d-4fc9-91c7-6b43b06b24b0');
INSERT INTO public.link_enums_tags VALUES ('d82a1464-7b0c-4d2a-83e7-77b659164fec', '080bae99-829d-4fc9-91c7-6b43b06b24b0');
INSERT INTO public.link_enums_tags VALUES ('191583ba-a789-42c6-970e-df3af32c1dfc', '080bae99-829d-4fc9-91c7-6b43b06b24b0');
INSERT INTO public.link_enums_tags VALUES ('277ef939-9bd4-49d4-9b93-243c474c2cbc', '080bae99-829d-4fc9-91c7-6b43b06b24b0');
INSERT INTO public.link_enums_tags VALUES ('191583ba-a789-42c6-970e-df3af32c1dfc', '2a9bf94f-1db4-48c2-9a60-63a0f65d3493');
INSERT INTO public.link_enums_tags VALUES ('277ef939-9bd4-49d4-9b93-243c474c2cbc', '2a9bf94f-1db4-48c2-9a60-63a0f65d3493');
INSERT INTO public.link_enums_tags VALUES ('a87fa8f3-d56a-49ec-8bd2-d62b7f07c367', '2a9bf94f-1db4-48c2-9a60-63a0f65d3493');
INSERT INTO public.link_enums_tags VALUES ('d82a1464-7b0c-4d2a-83e7-77b659164fec', '110ee2a7-d94a-416f-b66d-4d26927fc268');
INSERT INTO public.link_enums_tags VALUES ('650d303e-fa01-499d-ac3b-319d7317496e', '110ee2a7-d94a-416f-b66d-4d26927fc268');
INSERT INTO public.link_enums_tags VALUES ('5c93ce27-c2d0-4924-916c-abefabc0ccfd', '110ee2a7-d94a-416f-b66d-4d26927fc268');
INSERT INTO public.link_enums_tags VALUES ('f552b243-81fb-4901-9b09-a140de4660f4', 'e5a7d58f-7842-4bac-ae72-0c344883303f');
INSERT INTO public.link_enums_tags VALUES ('f1377e6b-c821-4585-9b51-ee653f7bbbe6', 'e5a7d58f-7842-4bac-ae72-0c344883303f');
INSERT INTO public.link_enums_tags VALUES ('f552b243-81fb-4901-9b09-a140de4660f4', 'dcc6c81e-d887-4df0-ab1f-76d0df97e63d');
INSERT INTO public.link_enums_tags VALUES ('f1377e6b-c821-4585-9b51-ee653f7bbbe6', 'dcc6c81e-d887-4df0-ab1f-76d0df97e63d');
INSERT INTO public.link_enums_tags VALUES ('33d4255f-f405-4bb5-add5-f85e0ff43e5b', 'dcc6c81e-d887-4df0-ab1f-76d0df97e63d');


--
-- TOC entry 3582 (class 0 OID 16404)
-- Dependencies: 218
-- Data for Name: static_components; Type: TABLE DATA; Schema: public; Owner: prout
--



--
-- TOC entry 3595 (class 0 OID 16497)
-- Dependencies: 231
-- Data for Name: type_generation_scripts; Type: TABLE DATA; Schema: public; Owner: prout
--



--
-- TOC entry 3596 (class 0 OID 16505)
-- Dependencies: 232
-- Data for Name: type_verification_scripts; Type: TABLE DATA; Schema: public; Owner: prout
--

INSERT INTO public.type_verification_scripts VALUES ('675cc168-7659-46c4-815d-805b4f172c61', 'b4258b56-81d6-4a03-84a1-0edab70281f4', 'result = true');
INSERT INTO public.type_verification_scripts VALUES ('55f1e88d-674a-47fe-bd88-399ccb80c2eb', '21ecaea4-696d-4e7c-8a31-20522674552f', 'result = true');
INSERT INTO public.type_verification_scripts VALUES ('33444d31-6bf9-4441-97c8-19ed2548b4d5', '46f3fe59-7eca-4529-b290-ed315e302e12', 'result = true');
INSERT INTO public.type_verification_scripts VALUES ('79e18e0a-3ac8-4bd4-a020-2c364378baa4', '01858199-d256-4071-90da-c212704bd7da', 'result = true');
INSERT INTO public.type_verification_scripts VALUES ('c3856f83-a2b9-41ef-bd0f-211fe2cff984', '6109eca7-5b21-4c5f-906c-ae882ceb353c', 'result = arg.is_email() // exemple');
INSERT INTO public.type_verification_scripts VALUES ('8d9a969e-2c23-4465-b7f8-fa279bf6ae28', '458b7c0a-6cc8-4108-ac23-850af12ed2b7', 'result = true //number');
INSERT INTO public.type_verification_scripts VALUES ('090ad3e7-9cfa-4839-b1de-c8ca15213f7b', '517bf0f4-ec17-4f0b-aa9f-25d78d1468c9', 'result = true //better stat');
INSERT INTO public.type_verification_scripts VALUES ('c7093e07-cc89-4f4d-aac0-cc78c1e1dc45', 'f79c6225-baf0-45af-81c6-8eb45d1a961f', 'result = true // stat');


-- Completed on 2026-09-09 15:14:06 UTC

--
-- PostgreSQL database dump complete
--

\unrestrict ssW2dNIaeyDgdKEBOZChtboaMhdeXj1mPw1Tt3fFlL5Na07sgnrRzbJgYcFzZ4a

