-- Borra el trigger si existe
DROP TRIGGER IF EXISTS insert_deleted_film_rows ON film;

-- Borra la funcion si existe
DROP FUNCTION IF EXISTS insert_deleted_film_rows();

-- Crea la tabla deleted_film_rows
CREATE TABLE deleted_film_rows (
id_deleted_film_rows SERIAL PRIMARY KEY,
film_id INTEGER NOT NULL,
last_update TIMESTAMP NOT NULL
);

-- Crea la funcion insert_deleted_film_rows
CREATE OR REPLACE FUNCTION insert_deleted_film_rows()
RETURNS TRIGGER AS $$
BEGIN
INSERT INTO deleted_film_rows (film_id, last_update) VALUES (OLD.film_id, NOW());
RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Crea el trigger insert_deleted_film_rows
CREATE TRIGGER insert_deleted_film_rows
AFTER DELETE ON film
FOR EACH ROW
EXECUTE PROCEDURE insert_deleted_film_rows();

-- Para comprobar que funciona, borramos una fila de la tabla film
DELETE FROM film 
WHERE title = 'Independe Day';

-- Comprobamos que se ha insertado una fila en la tabla deleted_film_rows
SELECT * FROM deleted_film_rows;