-- solution 1
SELECT 
    tweet_count_per_user AS tweet_bucket,
    COUNT(user_id) AS user_num
FROM
    (SELECT 
        user_id, COUNT(tweet_id) AS tweet_count_per_user
    FROM
        tweets
    WHERE
        tweet_date BETWEEN '2022-01-01' AND '2022-12-31'
    GROUP BY user_id) AS total_tweets
GROUP BY tweet_count_per_user;


-- Solution 2
WITH user_details AS(
  SELECT
    user_id,
    COUNT(user_id) AS user_num
  FROM tweets
    WHERE EXTRACT(YEAR FROM tweet_date) = 2022
  GROUP BY user_id
)
SELECT
  COUNT(user_id) AS tweet_bucket,
  user_num
FROM user_details
GROUP BY 2
ORDER BY 1;