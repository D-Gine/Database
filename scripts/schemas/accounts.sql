CREATE SCHEMA IF NOT EXISTS accounts;

CREATE TABLE IF NOT EXISTS accounts.users (
    id          UUID            DEFAULT uuid_generate_v4() NOT NULL UNIQUE,
    image       UUID            DEFAULT uuid_generate_v4() NOT NULL UNIQUE,
    email       VARCHAR(255)    NOT NULL UNIQUE,
    name        VARCHAR(255)    NOT NULL,
    password    VARCHAR(255)    NOT NULL,
    role        VARCHAR(255)    DEFAULT 'member' NOT NULL,
    PRIMARY KEY (id)
);
