

-- Providing  an overview of the customer distribution in the top 10 performing countries 
-- and the distribution of the top 5 customers in spending using CTEs



WITH TopCountries AS (					
    -- Top 10 countries based on the number of customers					
    SELECT 					
        co.country,					
        COUNT(c.customer_id) AS customer_count					
    FROM customer c					
    JOIN address a ON c.address_id = a.address_id					
    JOIN city ci ON a.city_id = ci.city_id					
    JOIN country co ON ci.country_id = co.country_id					
    GROUP BY co.country					
    ORDER BY customer_count DESC					
    LIMIT 10					
),					
TopCities AS (					
    -- Top 10 cities in the top 10 countries					
    SELECT 					
        ci.city,					
        co.country,					
        COUNT(c.customer_id) AS customer_count					
    FROM customer c					
    JOIN address a ON c.address_id = a.address_id					
    JOIN city ci ON a.city_id = ci.city_id					
    JOIN country co ON ci.country_id = co.country_id					
    WHERE co.country IN (SELECT country FROM TopCountries)					
    GROUP BY ci.city, co.country					
    ORDER BY customer_count DESC					
    LIMIT 10					
),					
TopCustomers AS (					
    -- Top 5 paying customers in the top 10 cities and top 10 countries					
    SELECT 					
        c.customer_id, 					
        c.first_name, 					
        c.last_name, 					
        co.country, 					
        ci.city, 					
        SUM(p.amount) AS amount_paid					
    FROM payment p					
    JOIN customer c ON p.customer_id = c.customer_id					
    JOIN address a ON c.address_id = a.address_id					
    JOIN city ci ON a.city_id = ci.city_id					
    JOIN country co ON ci.country_id = co.country_id					
    WHERE ci.city IN (SELECT city FROM TopCities)					
    GROUP BY c.customer_id, c.first_name, c.last_name, co.country, ci.city					
    ORDER BY amount_paid DESC					
    LIMIT 5					
)					
SELECT 					
    co.country, 					
    COUNT(DISTINCT c.customer_id) AS all_customer_count,					
    COUNT(DISTINCT top_5.customer_id) AS top_customer_count					
FROM customer c					
JOIN address a ON c.address_id = a.address_id					
JOIN city ci ON a.city_id = ci.city_id					
JOIN country co ON ci.country_id = co.country_id					
LEFT JOIN TopCustomers AS top_5 ON co.country = top_5.country					
GROUP BY co.country					
ORDER BY all_customer_count DESC, top_customer_count DESC					
LIMIT 10;					