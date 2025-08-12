-- solution 1
WITH unique_location AS (
    SELECT
        lat, lon, COUNT(*)
    FROM
        Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
),
tiv_2015_counts AS (
    SELECT 
        tiv_2015, COUNT(*)
    FROM
        Insurance 
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
)
SELECT
    ROUND(SUM(tiv_2016)::numeric, 2) AS tiv_2016
FROM
    Insurance
WHERE
    (lat, lon) IN (SELECT lat, lon FROM unique_location)
        AND
    tiv_2015 IN (SELECT tiv_2015 FROM tiv_2015_counts);

-- solution 2
WITH tiv_location AS (
    SELECT
        tiv_2016,
        COUNT(*) OVER(PARTITION BY tiv_2015) AS tiv_2015_count,
        COUNT(*) OVER(PARTITION BY lat, lon) AS location_count
    FROM
        Insurance
)
SELECT
    ROUND(SUM(tiv_2016)::numeric, 2) AS tiv_2016
FROM
    tiv_location
WHERE tiv_2015_count > 1 AND location_count = 1;