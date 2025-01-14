/*
Find the genre of the person with the most number of oscar winnings.
If there are more than one person with the same number of oscar wins, 
return the first one in alphabetic order based on their name. Use the names as keys when joining the tables.
*/
USE sqlpractice;

DROP TABLE IF EXISTS nominee_information;
CREATE TABLE nominee_information(
	name varchar(20), 
	amg_person_id varchar(10), 
	top_genre varchar(10), 
	birthday datetime, 
	id int
);
INSERT INTO nominee_information VALUES('Jennifer Lawrence','P562566','Drama','1990-08-15',755),
('Jonah Hill','P418718','Comedy','1983-12-20',747),('Anne Hathaway', 'P292630','Drama', '1982-11-12',744),
('Jennifer Hudson','P454405','Drama', '1981-09-12',742),('Rinko Kikuchi', 'P475244','Drama', '1981-01-06', 739);

DROP TABLE IF EXISTS oscar_nominees;
CREATE TABLE oscar_nominees(
	year int, 
	category varchar(30), 
	nominee varchar(20), 
	movie varchar(30), 
	winner int, 
	id int
);
INSERT INTO oscar_nominees VALUES
(2008,'actress in a leading role','Anne Hathaway','Rachel Getting Married',0,77),
(2012,'actress in a supporting role','Anne HathawayLes','Mis_rables',1,78),
(2006,'actress in a supporting role','Jennifer Hudson','Dreamgirls',1,711),
(2010,'actress in a leading role','Jennifer Lawrence','Winters Bone',1,717),
(2012,'actress in a leading role','Jennifer Lawrence','Silver Linings Playbook',1,718),
(2011,'actor in a supporting role','Jonah Hill','Moneyball',0,799),
(2006,'actress in a supporting role','Rinko Kikuchi','Babel',0,1253);

SELECT * FROM nominee_information;
SELECT * FROM oscar_nominees;

-- solution
WITH winner_count AS(
SELECT 
    nominee, COUNT(*) AS total_wins
FROM
    oscar_nominees
WHERE
    winner = 1
GROUP BY nominee
)
SELECT 
    ni.top_genre
FROM
    winner_count wc
        JOIN
    nominee_information ni ON wc.nominee = ni.name
ORDER BY wc.total_wins DESC , ni.name ASC
LIMIT 1;
