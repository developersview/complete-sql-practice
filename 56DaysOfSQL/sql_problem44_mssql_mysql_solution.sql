/*
Amazon (Hard Level)
You are given the table with titles of recipes from a cookbook and their page numbers.
You are asked to represent how the recipes will be distributed in the book.
Produce a table consisting of three columns: left_page_number, left_title and right_title. 
The k-th row (counting from 0), should contain the number and the title of the page with the number 2×k in the first and second columns respectively, 
and the title of the page with the number 2×k+1 in the third column.
*/
USE sqlpractice;

DROP TABLE IF EXISTS cookbook_titles;
CREATE TABLE cookbook_titles (
	page_number INT PRIMARY KEY,
	title VARCHAR(255)
);

INSERT INTO cookbook_titles (page_number, title) VALUES 
(1, 'Scrambled eggs'), (2, 'Fondue'), (3, 'Sandwich'), (4, 'Tomato soup'), 
(6, 'Liver'), (11, 'Fried duck'), (12, 'Boiled duck'), (15, 'Baked chicken');

SELECT * FROM cookbook_titles;

-- solution
WITH LeftPage AS(
	SELECT
		page_number,
		title
	FROM
		cookbook_titles
	WHERE page_number % 2 = 0
),
RightPage AS(
	SELECT
		page_number,
		title
	FROM
		cookbook_titles
	WHERE page_number % 2 = 1
)
SELECT
	lp.page_number,
	lp.title AS left_page_title,
	rp.title AS right_page_title
FROM
	LeftPage lp
		LEFT JOIN
	RightPage rp ON lp.page_number + 1 = rp.page_number
ORDER BY lp.page_number;