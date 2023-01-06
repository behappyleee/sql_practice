SELECT * FROM trading.prices p WHERE ticker = 'BTC' LIMIT 3;
SELECT * FROM trading.prices p WHERE ticker = 'ETH' LIMIT 5;

-- Question 1
-- How many total records do we have in the trading.prices table?
SELECT count(*) FROM trading.prices p;

-- Question 2
-- How many records are there per ticker value?
SELECT t.ticker, count(*) AS 'ticker value' FROM trading.prices t GROUP BY t.ticker;   

-- Question 3
-- What is the minimum and maximum market_date values?
SELECT min(p.market_date), max(p.market_date) FROM trading.prices p;

-- Question 4
-- Are there differences in the minimum and maximum market_date values for each ticker?
SELECT p.ticker, min(p.market_date), max(p.market_date), datediff(max(p.market_date), min(p.market_date)) AS 'DAYS DIFF' FROM trading.prices p GROUP BY p.ticker;
-- ANSWER
SELECT ticker, MIN(market_date) AS min_date, MAX(market_date) AS max_date FROM trading.prices GROUP BY ticker;

-- Question 5
-- What is the average of the price column for Bitcoin records during the year 2020?
SELECT avg(p.price) FROM trading.prices p WHERE YEAR(p.market_date) = 2020 AND p.ticker ='BTC'; 

-- Question 6
-- What is the monthly average of the price column for Ethereum in 2020? Sort the 
-- output in chronological order and also round the average price value to 2 decimal places
SELECT * FROM trading.prices p LIMIT 5;
       SELECT   p.ticker  
       		  ,	MONTH(p.market_date) AS 'MONTH'
       		  ,	ROUND(avg(p.price),2) AS 'AVG PRICE'
         FROM trading.prices p 
		WHERE p.ticker = 'ETH' 
		  AND YEAR(p.market_date) = 2020 
     GROUP BY MONTH(p.market_date);

-- ANSWER
--   SELECT
--   DATE_TRUNC('MON', market_date) AS month_start,
--   -- need to cast approx. floats to exact numeric types for round!
--   ROUND(AVG(price)::NUMERIC, 2) AS average_eth_price
-- FROM trading.prices
-- WHERE EXTRACT(YEAR FROM market_date) = 2020
--   AND ticker = 'ETH'
-- GROUP BY month_start
-- ORDER BY month_start;    

-- Question 7
-- Are there any duplicate market_date values for any ticker value in our table?
SELECT * FROM trading.prices p;
    
SELECT p.market_date, 
count(*) AS 'Count' FROM trading.prices p 
GROUP BY p.market_date 
HAVING 'Count' > 2;
-- ANSWER 
SELECT
  ticker,
  COUNT(market_date) AS total_count,
  COUNT(DISTINCT market_date) AS unique_count
FROM trading.prices
GROUP BY ticker;


