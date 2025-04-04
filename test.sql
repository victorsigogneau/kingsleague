-- Créer la table equipe si elle n'existe pas
CREATE TABLE IF NOT EXISTS equipe (
    equipe_id INTEGER PRIMARY KEY,
    nom VARCHAR NOT NULL
);
CREATE SEQUENCE IF NOT EXISTS seq_equipe_id START 1;

-- Créer la table match si elle n'existe pas
CREATE TABLE IF NOT EXISTS match (
    match_id INTEGER PRIMARY KEY,
    equipe_dom_id INTEGER,
    equipe_ext_id INTEGER,
    date_match TIMESTAMP NOT NULL,
    FOREIGN KEY (equipe_dom_id) REFERENCES equipe (equipe_id),
    FOREIGN KEY (equipe_ext_id) REFERENCES equipe (equipe_id)
);
CREATE SEQUENCE IF NOT EXISTS seq_match_id START 1;

-- Créer la table joueur si elle n'existe pas
CREATE TABLE IF NOT EXISTS joueur (
    joueur_id INTEGER PRIMARY KEY,
    nom VARCHAR NOT NULL,
    equipe_id INTEGER,
    poste VARCHAR,
    note INTEGER,
    wildcard BOOLEAN,
    FOREIGN KEY (equipe_id) REFERENCES equipe (equipe_id)
);
CREATE SEQUENCE IF NOT EXISTS seq_joueur_id START 1;

-- Créer la table president si elle n'existe pas
CREATE TABLE IF NOT EXISTS president (
    president_id INTEGER PRIMARY KEY,
    nom VARCHAR NOT NULL,
    equipe_id INTEGER NOT NULL,
    FOREIGN KEY (equipe_id) REFERENCES equipe (equipe_id)
);
CREATE SEQUENCE IF NOT EXISTS seq_president_id START 1;

-- Créer la table type_evenement si elle n'existe pas
CREATE TABLE IF NOT EXISTS type_evenement (
    type_evenement_id INTEGER PRIMARY KEY,
    nom VARCHAR NOT NULL
);
CREATE SEQUENCE IF NOT EXISTS seq_type_evenement_id START 1;

-- Créer la table evenement_match si elle n'existe pas
CREATE TABLE IF NOT EXISTS evenement_match (
    evenement_id INTEGER PRIMARY KEY,
    match_id INTEGER,
    joueur_id INTEGER,
    type_evenement_id INTEGER,
    minute INTEGER,
    temps_additionnel BOOLEAN,
    description VARCHAR,
    via_penalty BOOLEAN,
    gardien_id INTEGER,
    FOREIGN KEY (match_id) REFERENCES match (match_id),
    FOREIGN KEY (joueur_id) REFERENCES joueur (joueur_id),
    FOREIGN KEY (type_evenement_id) REFERENCES type_evenement (type_evenement_id),
    FOREIGN KEY (gardien_id) REFERENCES joueur (joueur_id)
);
CREATE SEQUENCE IF NOT EXISTS seq_evenement_id START 1;

-- Créer la table penalty si elle n'existe pas
CREATE TABLE IF NOT EXISTS penalty (
    evenement_id INTEGER PRIMARY KEY,
    joueur_id INTEGER,
    president_id INTEGER,
    gardien_id INTEGER,
    cote VARCHAR,
    plongeon VARCHAR,
    transforme BOOLEAN,
    FOREIGN KEY (evenement_id) REFERENCES evenement_match (evenement_id),
    FOREIGN KEY (joueur_id) REFERENCES joueur (joueur_id),
    FOREIGN KEY (president_id) REFERENCES president (president_id),
    FOREIGN KEY (gardien_id) REFERENCES joueur (joueur_id)
);
-- Note: La clé primaire evenement_id de la table penalty référence déjà evenement_match.
-- Il n'est généralement pas nécessaire d'avoir une séquence séparée pour une clé étrangère
-- qui est aussi la clé primaire d'une autre table (relation un-à-un ou zéro-ou-un).
-- Si tu souhaites une séquence séparée pour penalty_id (par exemple), il faudrait modifier la structure.