CREATE SCHEMA IF NOT EXISTS games;

CREATE TABLE IF NOT EXISTS games.characters (
    id UUID DEFAULT uuid_generate_v4() NOT NULL UNIQUE,
    player_id UUID NOT NULL REFERENCES accounts.users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);
