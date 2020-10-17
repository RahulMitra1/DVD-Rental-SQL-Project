/*Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out. (subquery, join, window function, visualisation)
*/
SELECT DISTINCT film_title, category_name,
	COUNT(rental_id) OVER(PARTITION BY  film_title) AS rental_count

FROM
	(SELECT f.title film_title, c.name category_name, r.rental_id rental_id
	FROM film f 
	JOIN film_category fc ON fc.film_id = f.film_id
	JOIN category c ON c.category_id = fc.category_id
	JOIN inventory i ON i.film_id = f.film_id
	JOIN rental r ON r.inventory_id = i.inventory_id) t1

ORDER BY category_name,film_title;
