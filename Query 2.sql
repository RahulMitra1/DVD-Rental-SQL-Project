/*Create a query that lists each film category and the number of films made in that category. (subquery, join, window function, visualisation)
*/
SELECT DISTINCT category_name,
	COUNT(film_title) OVER(PARTITION BY  category_name) AS category_count

FROM
	(SELECT f.title film_title, c.name category_name
	FROM film f 
	JOIN film_category fc ON fc.film_id = f.film_id
	JOIN category c ON c.category_id = fc.category_id) t1

ORDER BY category_count;
