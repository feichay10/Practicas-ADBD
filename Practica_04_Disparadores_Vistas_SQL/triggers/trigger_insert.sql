-- Borra el trigger si existe
DROP TRIGGER IF EXISTS insert_date_updated_table_film ON film;

-- Borra la funcion si existe
DROP FUNCTION IF EXISTS insert_date_updated_table_film();

CREATE TABLE updated_table_film (
id_updated_table_film SERIAL PRIMARY KEY,
last_update TIMESTAMP NOT NULL
);

CREATE OR REPLACE FUNCTION insert_date_updated_table_film()
RETURNS TRIGGER AS $$
BEGIN
INSERT INTO updated_table_film (last_update) VALUES (NOW());
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_date_updated_table_film
AFTER INSERT ON film
FOR EACH ROW
EXECUTE PROCEDURE insert_date_updated_table_film();

INSERT INTO film (title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features, fulltext)
              VALUES ('Independe Day', 
              'Epic film about an alien invasion of Earth', 
              1996, 1, 3, 4.99, 145, 19.99, 'PG-13', 
              '{Behind the Scenes, Deleted Scenes}', 
              'Aliens invade Earth and destroy everything');

SELECT * FROM updated_table_film;
