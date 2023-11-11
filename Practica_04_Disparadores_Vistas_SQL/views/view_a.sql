CREATE VIEW total_rent_per_category A
SELECT category.name, SUM(payment.amount) AS total_sales
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN film ON film_category.film_id = film.film_id
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY total_sales DESC;

SELECT * FROM total_rent_per_category;