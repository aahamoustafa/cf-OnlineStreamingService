-- which movies contributed the most/least to revenue gain?

SELECT film_id, title, release_year, SUM(amount) as revenue_gain
FROM payment 
JOIN rental 
USING(rental_id)
JOIN inventory
USING(inventory_id)
JOIN film 
USING (film_id)
GROUP BY film_id, title, release_year
ORDER BY revenue_gain DESC;



-- average rental duration for all movies? 

SELECT ROUND(AVG(rental_duration),3) as avg_rental_duration
FROM film;

-- top countries rockbuster customers are based in?

 SELECT co.country, COUNT(c.customer_id) AS customer_count					
    FROM customer c					
    JOIN address a ON c.address_id = a.address_id					
    JOIN city ci ON a.city_id = ci.city_id					
    JOIN country co ON ci.country_id = co.country_id					
    GROUP BY co.country					
    ORDER BY customer_count DESC	


-- revenue data per geographic regions? 

 SELECT Country, SUM(amount) as total_revenue		
    FROM payment p 
	JOIN customer c 
	USING(customer_id)
	JOIN address 
	USING(address_id)
	JOIN city 
	USING(city_id)
	JOIN country
	USING(country_id)
	GROUP BY country 
	ORDER BY total_revenue DESC;






	