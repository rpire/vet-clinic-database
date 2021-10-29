/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN 'Jan 1, 2016' AND 'Dec 31, 2019';
SELECT name FROM animals WHERE neutered AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight > 10.5;
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight BETWEEN 10.4 AND 17.3;

BEGIN;
  UPDATE animals
  SET species = 'Unespecified';
ROLLBACK;

BEGIN;
  UPDATE animals
  SET species = 'Digimon'
  WHERE name LIKE '%mon';

  UPDATE animals
  SET species = 'Pokemon'
  WHERE name NOT LIKE '%mon';
COMMIT;
SELECT * FROM animals;

BEGIN;
  DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
  DELETE FROM animals
  WHERE date_of_birth > 'Jan 1, 2022';
  SAVEPOINT sp1;
    UPDATE animals
    SET weight = weight * -1;
  ROLLBACK TO sp1;
  UPDATE animals
  SET weight = weight * -1
  WHERE weight < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts <= 0;
SELECT AVG(weight) FROM animals;

SELECT
  neutered, AVG(escape_attempts)
FROM
  animals
GROUP BY neutered;

SELECT
  species, MIN(weight), MAX(weight)
FROM
  animals
GROUP BY species;

SELECT
  species,
  AVG(escape_attempts)
FROM
 animals
WHERE
  date_of_birth
BETWEEN 'Jan 1, 1990' AND 'Dec 31, 2000'
GROUP BY species;

SELECT
  full_name AS owner,
  name
FROM
  animals
INNER JOIN owners
  ON owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT
  species.name AS species,
  animals.name
FROM
  species
INNER JOIN animals
  ON species.id = animals.species_id
WHERE species.name = 'Pokemon';

SELECT
  full_name AS owner,
  name AS animal
FROM
  owners
LEFT JOIN animals
  ON owners.id = owner_id;

SELECT
  species.name AS species,
  COUNT(animals.name)
FROM animals
INNER JOIN species
  ON species_id = species.id
GROUP BY species.name;

SELECT
  full_name,
  name
FROM
  animals
INNER JOIN owners
  ON owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell' AND species_id = 2;

SELECT
  full_name,
  name
FROM
  animals
INNER JOIN owners
  ON owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

SELECT
  owner,
  owned
FROM (
  SELECT
    full_name AS owner,
    COUNT(*) AS owned
  FROM
    animals
  INNER JOIN owners
    ON owner_id = owners.id
  GROUP BY owners.full_name
) AS max_owners
WHERE max_owners.owned = (SELECT MAX(owned) FROM(
  SELECT
    full_name AS owner,
    COUNT(*) AS owned
  FROM
    animals
  INNER JOIN owners
    ON owner_id = owners.id
  GROUP BY owners.full_name
) AS max_owners);

SELECT
  animals.name AS animal,
  date_of_visit AS date
FROM visits
INNER JOIN animals
  ON animal_id = animals.id
WHERE
date_of_visit = (
  SELECT
    MAX(date_of_visit)
  FROM visits
  INNER JOIN vets
    ON vet_id = vets.id
  WHERE vets.name = 'William Thatcher'
);

SELECT
  animals.name AS animal,
  COUNT(animal_id) AS visits
FROM visits
INNER JOIN vets
 ON vet_id = vets.id
INNER JOIN animals
  ON animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY animals.name;

SELECT
  vets.name AS vet,
  species.name AS specialty
FROM  specializations
RIGHT JOIN vets
  ON vet_id = vets.id
LEFT JOIN species
  ON species_id = species.id;

SELECT
  animals.name,
  visits.date_of_visit
FROM
  visits
INNER JOIN animals
  ON animals.id = animal_id
INNER JOIN vets
  ON visits.vet_id = vets.id
WHERE date_of_visit BETWEEN 'Apr 1, 2020' AND 'Aug 30, 2020'
AND vets.name = 'Stephanie Mendez';

SELECT
  animals.name AS animal,
  COUNT(animal_id) AS visits
FROM visits
INNER JOIN animals
  ON animal_id = animals.id
GROUP BY animals.name
ORDER BY visits DESC;

SELECT
  animals.name AS animal,
  date_of_visit AS date
FROM visits
INNER JOIN animals
  ON animal_id = animals.id
WHERE
date_of_visit = (
  SELECT
    MIN(date_of_visit)
  FROM visits
  INNER JOIN vets
    ON vet_id = vets.id
  WHERE vets.name = 'Maisy Smith'
);

SELECT
  a.id,
  a.name,
  a.date_of_birth,
  a.escape_attempts,
  a.neutered,
  a.weight,
  s.name AS species,
  o.full_name AS owner,
  o.age AS owner_age,
  v.name AS vet,
  v.age AS vet_age,
  v.date_of_graduation AS vet_graduation_date,
  date_of_visit
FROM visits
INNER JOIN animals a
  ON animal_id = a.id
INNER JOIN vets v
  ON vet_id = v.id
INNER JOIN owners o
  ON a.owner_id = o.id
INNER JOIN species s
  ON a.species_id = s.id
WHERE
date_of_visit = (
  SELECT
    MAX(date_of_visit)
  FROM visits
  INNER JOIN vets
    ON vet_id = vets.id
);

SELECT
  COUNT(*)
FROM
  vets ve
INNER JOIN visits vi
  ON vi.vet_id = ve.id
INNER JOIN animals an
  ON an.id = vi.animal_id
LEFT JOIN specializations sp
  ON sp.vet_id = ve.id
WHERE
an.species_id != sp.species_id
AND ve.name != 'Stephanie Mendez'
OR ve.name = 'Maisy Smith';

SELECT
  species.name AS species,
  COUNT(date_of_visit) AS visits
FROM visits
INNER JOIN animals
  ON  visits.animal_id = animals.id
INNER JOIN species
  ON animals.species_id = species.id
INNER JOIN vets
  ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name;

/*
  Result--> From a total of 9 visits: Pokemon = 3 & Digimon = 6
  Maisy Smith should specialize in Digimon.
*/
