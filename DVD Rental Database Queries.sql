/* DVD Rental Database (Link : https://www.postgresqltutorial.com/postgresql-sample-database/ ) */

/*Let's start with creating a table that provides the following details: actor's first and last name combined as full_name, film title, film description and length of the movie.
How many rows are there in the table? (ans : 5462 rows)
*/
SELECT CONCAT(a.first_name,' ',a.last_name) as full_name,
f.title, f.description, f.length
FROM actor a
JOIN film_actor fa ON a.actor_id=fa.actor_id
JOIN film f ON f.film_id=fa.film_id;


/*
Write a query that creates a list of actors and movies where the movie length was more than 60 minutes. How many rows are there in this query result? 
ans : 4900
*/
SELECT CONCAT(a.first_name,' ',a.last_name) as actor_name,
f.title movie_name
FROM actor a
JOIN film_actor fa ON a.actor_id=fa.actor_id
JOIN film f ON f.film_id=fa.film_id
WHERE f.length>60;


/*Write a query that captures the actor id, full name of the actor, and counts the number of movies each actor has made. (HINT: Think about whether you should group by actor id or the full name of the actor.) Identify the actor who has made the maximum number movies.
Gina Degeneres
*/
SELECT a.actor_id, CONCAT(a.first_name,' ',a.last_name) as actor_name,
COUNT(*) movie_count
FROM actor a
JOIN film_actor fa ON a.actor_id=fa.actor_id
JOIN film f ON f.film_id=fa.film_id
GROUP BY 1,2
ORDER BY COUNT(*)DESC;


/* Write a query that displays a table with 4 columns: actor's full name, film title, length of movie, and a column name "filmlen_groups" that classifies movies based on their length. Filmlen_groups should include 4 categories: 1 hour or less, Between 1-2 hours, Between 2-3 hours, More than 3 hours.
*/
SELECT CONCAT(a.first_name,' ',a.last_name) as actor_name,
f.title, f.length,
CASE
	WHEN f.length<60 THEN 'Group 1'
    WHEN f.length>60 and f.length<120 THEN 'Group 2'
    WHEN f.length>120 and f.length<180 THEN 'Group 3'
    WHEN f.length>180 THEN 'Group 4'
END as filmlen_groups
FROM actor a
JOIN film_actor fa ON a.actor_id=fa.actor_id
JOIN film f ON f.film_id=fa.film_id;


/* Question 2: Write a query you to create a count of movies in each of the 4 filmlen_groups: 1 hour or less, Between 1-2 hours, Between 2-3 hours, More than 3 hours.

filmlen_groups		filmcount_bylencat
1 hour or less			104
Between 1-2 hours		439
Between 2-3 hours		418
More than 3 hours		39
*/
SELECT DISTINCT(filmlen_groups),
      COUNT(title) OVER (PARTITION BY filmlen_groups) AS filmcount_bylencat
FROM  
     (SELECT title,length,
      CASE WHEN length <= 60 THEN '1 hour or less'
      WHEN length > 60 AND length <= 120 THEN 'Between 1-2 hours'
      WHEN length > 120 AND length <= 180 THEN 'Between 2-3 hours'
      ELSE 'More than 3 hours' END AS filmlen_groups
      FROM film ) t1
ORDER BY  filmlen_groups