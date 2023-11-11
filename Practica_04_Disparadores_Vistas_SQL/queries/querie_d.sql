SELECT actor.first_name || ' ' || actor.last_name AS actor_name,
string_agg(DISTINCT category.name, ':') AS categories,
string_agg(DISTINCT film.title, ':') AS films
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film_category ON film_actor.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
INNER JOIN film ON film_category.film_id = film.film_id
GROUP BY actor_name;