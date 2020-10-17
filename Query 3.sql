/*Create a query that lists each actor's full name, film release year and number of year wise released film. (join, aggregrate function, visualisation)
*/
SELECT CONCAT(a.first_name,' ',a.last_name) actor_name,
	COUNT(f.release_year) year_wise_film
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film f ON f.film_id = fa.film_id
GROUP BY actor_name
ORDER BY COUNT(f.release_year);