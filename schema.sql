/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(30) NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY (id)
);

ALTER TABLE animals
ADD species VARCHAR(15);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(50),
    age INT,
    PRIMARY KEY (id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(15),
    PRIMARY KEY (id)
);

ALTER TABLE animals
DROP species,
ADD species_id INT,
ADD owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(id);

ALTER TABLE animals
ADD CONSTRAINT fk_owners
FOREIGN KEY (owner_id)
REFERENCES owners(id);

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

CREATE TABLE specializations (
    vet_id INT,
    species_id INT
);

ALTER TABLE specializations
ADD CONSTRAINT fk_vets
FOREIGN KEY (vet_id)
REFERENCES vets(id);

ALTER TABLE specializations
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(id);

CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    date_of_visit DATE
);

ALTER TABLE visits
ADD CONSTRAINT fk_animals
FOREIGN KEY (animal_id)
REFERENCES animals(id);

ALTER TABLE visits
ADD CONSTRAINT fk_vets
FOREIGN KEY (vet_id)
REFERENCES vets(id);

-- Performance Audit

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX animal_id_desc ON visits (animal_id DESC);

CREATE INDEX vet_id_desc ON visits (vet_id DESC);

CREATE INDEX email_desc ON owners (email DESC);