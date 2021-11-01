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

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Thatcher', 45, 'Apr 23, 2000'),
  ('Maisy Smith', 26, 'Jan 17, 2019'),
  ('Stephanie Mendez', 64, 'May 4, 1981'),
  ('Jack Harkness', 38, 'Jun 8, 2008');

INSERT INTO specializations (vet_id, species_id)
SELECT
  vets.id,
  species.id
FROM
  vets,
  species
WHERE
  vets.name = 'William Thatcher'
AND
  species.name = 'Pokemon';

INSERT INTO specializations (vet_id, species_id)
SELECT
  vets.id,
  species.id
FROM
  vets,
  species
WHERE
  vets.name = 'Stephanie Mendez'
AND
  species.name IN ('Pokemon', 'Digimon');

INSERT INTO specializations (vet_id, species_id)
SELECT
  vets.id,
  species.id
FROM
  vets,
  species
WHERE
  vets.name = 'Jack Harkness'
AND
  species.name = 'Digimon';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'May 24, 2020'
FROM
  animals, vets
WHERE
  animals.name = 'Agumon'
AND
  vets.name = 'William Thatcher';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'Jul 22, 2020'
FROM
  animals, vets
WHERE
  animals.name = 'Agumon'
AND
  vets.name = 'Stephanie Mendez';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'Feb 2, 2021'
FROM
  animals, vets
WHERE
  animals.name = 'Gabumon'
AND
  vets.name = 'Jack Harkness';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'Jan 5, 2020'
FROM
  animals, vets
WHERE
  animals.name = 'Pikachu'
AND
  vets.name = 'Maisy Smith';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'Mar 8, 2020'
FROM
  animals, vets
WHERE
  animals.name = 'Pikachu'
AND
  vets.name = 'Maisy Smith';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'May 14, 2020'
FROM
  animals, vets
WHERE
  animals.name = 'Pikachu'
AND
  vets.name = 'Maisy Smith';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'May 4, 2021'
FROM
  animals, vets
WHERE
  animals.name = 'Devimon'
AND
  vets.name = 'Stephanie Mendez';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'Feb 24, 2021'
FROM
  animals, vets
WHERE
  animals.name = 'Charmander'
AND
  vets.name = 'Jack Harkness';

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight, species_id, owner_id)
VAlUES ('Plantmon', 'Nov 15, 2022', 2, TRUE, 5.7, 2, 3);
  
INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'Dec 21, 2019'
FROM
  animals, vets
WHERE
  animals.name = 'Plantmon'
AND
  vets.name = 'Maisy Smith';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'Aug 10, 2020'
FROM
  animals, vets
WHERE
  animals.name = 'Plantmon'
AND
  vets.name = 'William Thatcher';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'Apr 7, 2021'
FROM
  animals, vets
WHERE
  animals.name = 'Plantmon'
AND
  vets.name = 'Maisy Smith';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'Sep 29, 2019'
FROM
  animals, vets
WHERE
  animals.name = 'Squirtle'
AND
  vets.name = 'Stephanie Mendez';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'Oct 3, 2020'
FROM
  animals, vets
WHERE
  animals.name = 'Angemon'
AND
  vets.name = 'Jack Harkness';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'Nov 4, 2020'
FROM
  animals, vets
WHERE
  animals.name = 'Angemon'
AND
  vets.name = 'Jack Harkness';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'Jan 24, 2019'
FROM
  animals, vets
WHERE
  animals.name = 'Boarmon'
AND
  vets.name = 'Maisy Smith';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'May 15, 2019'
FROM
  animals, vets
WHERE
  animals.name = 'Boarmon'
AND
  vets.name = 'Maisy Smith';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'Feb 27, 2020'
FROM
  animals, vets
WHERE
  animals.name = 'Boarmon'
AND
  vets.name = 'Maisy Smith';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'Aug 3, 2020'
FROM
  animals, vets
WHERE
  animals.name = 'Boarmon'
AND
  vets.name = 'Maisy Smith';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'May 24, 2020'
FROM
  animals, vets
WHERE
  animals.name = 'Blossom'
AND
  vets.name = 'Stephanie Mendez';

INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  animals.id,
  vets.id,
  'Jan 11, 2021'
FROM
  animals, vets
WHERE
  animals.name = 'Blossom'
AND
  vets.name = 'William Thatcher';

-- This part of the code was repeated 4 times to ensure the queries were taking more than 1s to execute.

INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

-- // --
