-- Comments in SQL Start with dash-dash --



--Part 4: Google Play Store Querying

--1. Find the app with an ID of 1880
select * from analytics where ID = 1880

--2. Find the ID and app name for all apps that were last updated on August 01, 2018.
select ID, app_name from analytics where last_updated = '2018-08-01'

--3. Count the number of apps in each category, e.g. “Family | 1972”.
select category, count(*) as App_count from analytics Group By category

--4. Find the top 5 most-reviewed apps and the number of reviews for each.
SELECT *
FROM analytics
GROUP BY app_name  
ORDER BY reviews DESC
LIMIT 5;

--5. Find the app that has the most reviews with a rating greater than equal to 4.8.
SELECT *
FROM analytics
where rating > 4.8
ORDER BY reviews DESC
LIMIT 1;

--6. Find the average rating for each category ordered by the highest rated to lowest rated.
select category, AVG(rating) as AVG_Rating 
from analytics 
Group By category ORDER BY AVG(rating) DESC

--7. Find the name, price, and rating of the most expensive app with a rating that’s less than 3.
SELECT app_name, price, rating,

FROM analytics 
WHERE rating < 3
Order By price DESC
limit 1


--8. Find all apps with a min install not exceeding 50, that have a rating. Order your results by highest rated first.
SELECT * FROM analytics 
WHERE min_installs <= 50 
AND rating IS NOT NULL 
ORDER BY rating DESC;

--9. Find the names of all apps that are rated less than 3 with at least 10000 reviews.
SELECT app_name, SUM(reviews) as REVIEWS, rating
FROM analytics 
WHERE rating < 3 
Group By app_name, rating
Having Sum(reviews)>= 10000


--10. Find the top 10 most-reviewed apps that cost between 10 cents and a dollar.
SELECT app_name, SUM(reviews) as REVIEWS, price,
RANK () OVER ( 
		ORDER BY  SUM(reviews) DESC
	) 
FROM analytics 
WHERE price >= .10 AND price <= 1.0
Group By app_name, price
limit 10

--11. Find the most out of date app. Hint: You don’t need to do it this way, but it’s possible to do with a subquery: http://www.postgresqltutorial.com/postgresql-max-function/


SELECT * FROM analytics 
WHERE Order By last_updated
Limit 1

--12. Find the most expensive app (the query is very similar to #11).
SELECT app_name, price
FROM analytics
ORDER BY price DESC
LIMIT 1

--13. Count all the reviews in the Google Play Store.
SELECT Sum(reviews) as Total_Review_Count
FROM analytics


--14. Find all the categories that have more than 300 apps in them.
SELECT category
FROM analytics
Group By category
Having Count(app_name)> 300


--15. Find the app that has the highest proportion of min_installs to reviews, among apps that have been installed at least 100,000 times. Display the name of the app along with the number of reviews, the min_installs, and the proportion.
SELECT app_name, reviews, min_installs,  min_installs / reviews AS proportion
FROM analytics
WHERE min_installs >= 100000
ORDER BY proportion DESC
LIMIT 1;

--FS1. Find the name and rating of the top rated apps in each category, among apps that have been installed at least 50,000 times.
SELECT app_name, category,  min_installs, rating
FROM analytics
where rating IS NOT NULL and rating >= 4.7
Group By app_name, category,  rating, min_installs
Having min_installs >= 50000
Order By rating, category ASC


--FS2. Find all the apps that have a name similar to “facebook”.
SELECT * FROM analytics 
WHERE app_name ILIKE '%facebook%';


--FS3. Find all the apps that have more than 1 genre.
SELECT app_name
FROM analytics
where  ARRAY_LENGTH(genres, 1) > 1

--FS4. Find all the apps that have education as one of their genres.
SELECT app_name
FROM analytics
where 'Education' = Any(genres)