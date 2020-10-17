/*Create a query that lists each customer's full name, total payment he has done and category of customer he has been as per payment(Bronze, Silver, Bronze and Platinum) (join, aggregrate function, case, visualisation)
*/
SELECT CONCAT(c.first_name,' ',c.last_name) customer_full_name,
	SUM(p.amount) as total_amount,
	CASE 
		WHEN SUM(p.amount)<50 THEN 'Bronze Customer'
		WHEN SUM(p.amount)>50 and SUM(p.amount)<=100 THEN 'Silver Customer'
		WHEN SUM(p.amount)>100 and SUM(p.amount)<=150  THEN 'Gold Customer'
		ELSE 'Platinum Customer'
	END as amount_section
FROM payment p
JOIN customer c ON c.customer_id = p.customer_id
GROUP BY 1
ORDER BY SUM(p.amount);