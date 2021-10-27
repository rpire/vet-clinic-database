/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight)
VAlUES ('Agumon', 'Feb 3, 2020', 0, TRUE, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight)
VAlUES ('Gabumon', 'Nov 15, 2018', 2, TRUE, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight)
VAlUES ('Pikachu', 'Jan 7, 2021', 1, FALSE, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight)
VAlUES ('Devimon', 'May 12, 2017', 5, TRUE, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight)
VAlUES ('Charmander', 'Feb 8, 2020', 0, FALSE, -11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight)
VAlUES ('Plantmon', 'Nov 15, 2022', 2, TRUE, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight)
VAlUES ('Squirtle', 'Apr 2, 1993', 3, FALSE, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight)
VAlUES ('Angemon', 'Jun 12, 2005', 1, TRUE, -45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight)
VAlUES ('Boarmon', 'Jun 7, 2005', 7, TRUE, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight)
VAlUES ('Blossom', 'Oct 13, 1998', 3, TRUE, 17);

INSERT INTO owners (full_name, age)
VAlUES ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

INSERT INTO species (name)
VAlUES ('Pokemon'),
  ('Digimon');

UPDATE animals
SET species_id = (
  SELECT
    id
  FROM
    species
  WHERE
    name = 'Digimon' AND animals.name LIKE '%mon'
);

UPDATE animals
SET species_id = (
  SELECT
    id
  FROM
    species
  WHERE
    name = 'Pokemon' AND animals.name NOT LIKE '%mon'
  OR
    name = 'Digimon' AND animals.name LIKE '%mon'
);

UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE name = 'Agumon' AND owners.full_name = 'Sam Smith';

UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE name IN ('Gabumon', 'Pikachu') AND owners.full_name = 'Jennifer Orwell';

UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE name = 'Devimon' AND owners.full_name = 'Bob';

UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE name IN ('Charmander', 'Squirtle', 'Blossom') AND owners.full_name = 'Melody Pond';

UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE name IN ('Angemon', 'Boarmon') AND owners.full_name = 'Dean Winchester';
