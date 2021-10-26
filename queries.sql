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
  species, AVG(escape_attempts)
FROM
 animals
WHERE
  date_of_birth
BETWEEN 'Jan 1, 1990' AND 'Dec 31, 2000'
GROUP BY species;
