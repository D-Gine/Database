--
-- PostgreSQL database dump
--

\restrict yoTD3y3Qabb6FkEjOx3dWv32DWsM5V8n3c3ufsaUN5GSgVmPSVDmTqKeKBhMrxp

-- Dumped from database version 16.15
-- Dumped by pg_dump version 16.14

-- Started on 2026-09-07 05:49:38 UTC

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
-- TOC entry 3507 (class 0 OID 16470)
-- Dependencies: 227
-- Data for Name: types; Type: TABLE DATA; Schema: public; Owner: prout
--

INSERT INTO public.types (id, ruleset_id, base_type_id, name, restrictions) VALUES ('458b7c0a-6cc8-4108-ac23-850af12ed2b7', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', NULL, 'number', NULL);
INSERT INTO public.types (id, ruleset_id, base_type_id, name, restrictions) VALUES ('01858199-d256-4071-90da-c212704bd7da', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', NULL, 'string', NULL);
INSERT INTO public.types (id, ruleset_id, base_type_id, name, restrictions) VALUES ('f79c6225-baf0-45af-81c6-8eb45d1a961f', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', '458b7c0a-6cc8-4108-ac23-850af12ed2b7', 'stat', '{"max": 20, "min": 0}');
INSERT INTO public.types (id, ruleset_id, base_type_id, name, restrictions) VALUES ('517bf0f4-ec17-4f0b-aa9f-25d78d1468c9', '0e3196a0-f8d8-444f-a6b6-d5f6f81f6333', 'f79c6225-baf0-45af-81c6-8eb45d1a961f', 'better stat', '{"max": 22}');


-- Completed on 2026-09-07 05:49:38 UTC

--
-- PostgreSQL database dump complete
--

\unrestrict yoTD3y3Qabb6FkEjOx3dWv32DWsM5V8n3c3ufsaUN5GSgVmPSVDmTqKeKBhMrxp

