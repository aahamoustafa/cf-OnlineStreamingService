-- Data cleaning measures to make sure the data is ready for analysis 


-- 1. first we will check for any duplicates for critical columns in the film/customer tables

SELECT film_id, Count(*)
FROM film 
GROUP BY film_id
HAVING(count(*) > 1 ) -- no films with duplicate film ids found

SELECT first_name, last_name, Count(*)
FROM customer
GROUP BY first_name, last_name
HAVING(count(*) > 1 ) -- no duplicate entries for the same person found



-- 2. Checking for incorrect data & missing data in the rating column, can also be done for other categorical columns 

SELECT DISTINCT Rating 
FROM film 
GROUP BY rating -- no incorrect data 


SELECT film_id, rating 
FROM film 
WHERE rating = NULL -- no missing values 


-- no duplicate, missing, or non uniform data found in both the customer and film tables. If i was to find duplicate values 
-- i would either filter using groupby/DISTINCT or delete the records if i am permitted to do so 


-- For the missing values, if there is a high percentage missing then column can be filtered out of the select statement
-- If it's needed for analysis we can impute using the avg of the column for example

-- Non uniform/missing data can be found using DISTINCT on categorical data and can be changed using the UPDATE command 