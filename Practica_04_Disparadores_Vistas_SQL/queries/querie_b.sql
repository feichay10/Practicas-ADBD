SELECT CONCAT(city.city, ', ', country.country) AS city_country,
CONCAT(staff.first_name, ' ', staff.last_name) AS manager,
SUM(payment.amount) AS total_sales
FROM store
INNER JOIN staff ON store.manager_staff_id = staff.staff_id
INNER JOIN address ON store.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
INNER JOIN inventory ON store.store_id = inventory.store_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY city_country, manager
ORDER BY total_sales DESC;