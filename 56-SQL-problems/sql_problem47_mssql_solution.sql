/*
Expedia, Airbnb, Tripadvisor (Medium Level)
Find the top two hotels with the most negative reviews.
Output the hotel name along with the corresponding number of negative reviews. 
Negative reviews are all the reviews with text under negative review different than "No Negative". 
Sort records based on the number of negative reviews in descending order.
*/
USE sqlpractice;

DROP TABLE IF EXISTS airbnb_hotel_reviews;
CREATE TABLE airbnb_hotel_reviews (
	additional_number_of_scoring BIGINT, 
	average_score FLOAT, 
	days_since_review NVARCHAR(255), 
	hotel_address NVARCHAR(255), 
	hotel_name NVARCHAR(255), 
	lat FLOAT, 
	lng FLOAT, 
	negative_review NVARCHAR(MAX), 
	positive_review NVARCHAR(MAX), 
	review_date DATETIME, 
	review_total_negative_word_counts BIGINT, 
	review_total_positive_word_counts BIGINT, 
	reviewer_nationality NVARCHAR(255), 
	reviewer_score FLOAT, 
	tags NVARCHAR(MAX), 
	total_number_of_reviews BIGINT, 
	total_number_of_reviews_reviewer_has_given BIGINT
);

INSERT INTO airbnb_hotel_reviews VALUES
(25, 8.7, '15 days ago', '123 Street, City A', 'Hotel Alpha', 12.3456, 98.7654, 'Too noisy at night', 'Great staff and clean rooms', '2024-12-01', 5, 15, 'USA', 8.5, '["Couple"]', 200, 10), 
(30, 9.1, '20 days ago', '456 Avenue, City B', 'Hotel Beta', 34.5678, 76.5432, 'Old furniture', 'Excellent location', '2024-12-02', 4, 12, 'UK', 9.0, '["Solo traveler"]', 150, 8), 
(12, 8.3, '10 days ago', '789 Boulevard, City C', 'Hotel Gamma', 23.4567, 67.8901, 'No Negative', 'Friendly staff', '2024-12-03', 0, 10, 'India', 8.3, '["Family"]', 100, 5), 
(15, 8.0, '5 days ago', '321 Lane, City D', 'Hotel Delta', 45.6789, 54.3210, 'Uncomfortable bed', 'Affordable price', '2024-12-04', 6, 8, 'Germany', 7.8, '["Couple"]', 120, 7),
(20, 7.9, '8 days ago', '654 Road, City E', 'Hotel Alpha', 67.8901, 12.3456, 'Poor room service', 'Good breakfast', '2024-12-05', 7, 9, 'France', 7.5, '["Solo traveler"]', 180, 6), 
(18, 9.3, '18 days ago', '987 Highway, City F', 'Hotel Beta', 34.5678, 76.5432, 'No Negative', 'Amazing facilities', '2024-12-06', 0, 20, 'USA', 9.2, '["Couple"]', 250, 15);

SELECT * FROM airbnb_hotel_reviews;

-- solution
SELECT TOP 2
	hotel_name,
	COUNT(negative_review) AS count_of_negative_reviews
FROM
	airbnb_hotel_reviews
WHERE 
	negative_review != 'No Negative'
GROUP BY hotel_name
ORDER BY count_of_negative_reviews DESC;
