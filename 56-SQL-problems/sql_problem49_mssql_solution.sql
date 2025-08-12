/*
Goldman Sachs (Medium Level)
You work for a multinational company that wants to calculate total sales across all their countries they do business in.
You have 2 tables, one is a record of sales for all countries and currencies the company deals with, and the other holds currency exchange rate information. 
Calculate the total sales, per quarter, for the first 2 quarters in 2020, and report the sales in USD currency.
*/
USE sqlpractice;

DROP TABLE IF EXISTS sf_exchange_rate;
CREATE TABLE sf_exchange_rate (
	date DATE, 
	exchange_rate FLOAT, 
	source_currency VARCHAR(10), 
	target_currency VARCHAR(10)
);

INSERT INTO sf_exchange_rate (date, exchange_rate, source_currency, target_currency) 
VALUES ('2020-01-15', 1.1, 'EUR', 'USD'), ('2020-01-15', 1.3, 'GBP', 'USD'), ('2020-02-05', 1.2, 'EUR', 'USD'), ('2020-02-05', 1.35, 'GBP', 'USD'), ('2020-03-25', 1.15, 'EUR', 'USD'), ('2020-03-25', 1.4, 'GBP', 'USD'), ('2020-04-15', 1.2, 'EUR', 'USD'), ('2020-04-15', 1.45, 'GBP', 'USD'), ('2020-05-10', 1.1, 'EUR', 'USD'), ('2020-05-10', 1.3, 'GBP', 'USD'), ('2020-06-05', 1.05, 'EUR', 'USD'), ('2020-06-05', 1.25, 'GBP', 'USD');

DROP TABLE IF EXISTS sf_sales_amount;
CREATE TABLE sf_sales_amount (
	currency VARCHAR(10), 
	sales_amount BIGINT, 
	sales_date DATE
);

INSERT INTO sf_sales_amount (currency, sales_amount, sales_date) VALUES ('USD', 1000, '2020-01-15'), ('EUR', 2000, '2020-01-20'), ('GBP', 1500, '2020-02-05'), ('USD', 2500, '2020-02-10'), ('EUR', 1800, '2020-03-25'), ('GBP', 2200, '2020-03-30'), ('USD', 3000, '2020-04-15'), ('EUR', 1700, '2020-04-20'), ('GBP', 2000, '2020-05-10'), ('USD', 3500, '2020-05-25'), ('EUR', 1900, '2020-06-05'), ('GBP', 2100, '2020-06-10');

SELECT * FROM sf_exchange_rate;
SELECT * FROM sf_sales_amount;

-- solution
SELECT 
	DATEPART(QUARTER, sa.sales_date) AS sales_quarter,
	SUM(sa.sales_amount * er.exchange_rate) AS total_sales_usd
FROM
	sf_exchange_rate er
		JOIN
	sf_sales_amount	sa ON er.source_currency = sa.currency
		AND CAST(sa.sales_date AS DATE) = CAST(er.date AS DATE)
WHERE
	sa.sales_date >= '2020-01-01' AND sa.sales_date <= '2020-07-01'
		AND er.target_currency = 'USD'
GROUP BY DATEPART(QUARTER, sa.sales_date);