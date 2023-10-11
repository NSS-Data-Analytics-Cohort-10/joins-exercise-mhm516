-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT revenue.worldwide_gross, specs.movie_id, specs.film_title, specs.release_year
FROM revenue
LEFT JOIN specs
ON revenue.movie_id = specs.movie_id
WHERE revenue.worldwide_gross IS NOT NULL
ORDER BY revenue DESC;
--Semi-Tough 1977 37187139
-- 2. What year has the highest average imdb rating?
SELECT AVG(rating.imdb_rating), specs.release_year
FROM rating
LEFT JOIN specs
ON rating.movie_id = specs.movie_id
GROUP BY specs.release_year
ORDER BY AVG(rating.imdb_rating) DESC;
--1991
-- 3. What is the highest grossing G-rated movie? Which company distributed it?
SELECT *
FROM specs
INNER JOIN revenue
	ON specs.movie_id = revenue.movie_id
	INNER JOIN distributors
	ON specs.domestic_distributor_id = distributors.distributor_id
	WHERE specs.mpaa_rating = 'G'
	ORDER BY revenue.worldwide_gross DESC
limit 1;
--Toy Story 4 Walt Disney

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
-- table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.
SELECT distributors.company_name, COUNT(specs.film_title)
FROM distributors
FULL JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
GROUP BY distributors.company_name
ORDER BY COUNT(specs.film_title) DESC;
-- 5. Write a query that returns the five distributors with the highest average movie budget.
SELECT distributors.company_name, AVG(revenue.film_budget)
FROM specs
INNER JOIN revenue
	ON specs.movie_id = revenue.movie_id
	INNER JOIN distributors
	ON specs.domestic_distributor_id = distributors.distributor_id
	GROUP BY distributors.company_name
	ORDER BY AVG(revenue.film_budget) DESC
limit 5;
-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
SELECT *
FROM specs
INNER JOIN rating
	ON specs.movie_id = rating.movie_id
	INNER JOIN distributors
	ON specs.domestic_distributor_id = distributors.distributor_id
	WHERE distributors.headquarters NOT LIKE '%CA%';
-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

SELECT
	CASE WHEN length_in_min >120 THEN 'over_2_hrs'
	ELSE 'under_2_hrs'
	END AS category, ROUND(AVG(imdb_rating),1)
FROM specs
INNER JOIN rating
ON specs.movie_id=rating.movie_id
GROUP BY category;
