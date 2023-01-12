-- Questions 1-4
-- What is the total portfolio value for each mentor at the end of 2020?


SELECT * FROM trading.transactions t;
SELECT * FROM trading.prices p;
SELECT * FROM trading.members m;

-- What is the total portfolio value for each region at the end of 2019?

-- What percentage of regional portfolio values does each mentor contribute at the end of 2018?

-- Does this region contribution percentage change when we look across both Bitcoin and Ethereum portfolios independently at the end of 2017?

-- Step 1
-- Create a base table that has each mentor's name, region and end of year total quantity for each ticker

SELECT * FROM trading.transactions t;
SELECT 1 FROM DUAL;
SELECT LAST_DAY('2022-01-20') FROM DUAL;

SELECT * FROM trading.transactions t GROUP BY t.ticker;


SELECT * FROM trading.transactions t WHERE t.txn_time IN (
	SELECT LAST_DAY
	  FROM trading.transactions t2;
);

SELECT DISTINCT LAST_DAY(t.txn_time) FROM trading.transactions t WHERE MONTH(t.txn_time) = 12;


WITH temp_table AS (


)


CREATE TABLE #TEMP (
	SELECT m.first_name 
	     , m.region 
	  FROM trading.members m  
INNER JOIN trading.transactions t 
        ON m.member_id = t.member_id
     WHERE t.txn_time IN (
     	SELECT DISTINCT LAST_DAY()
          FROM trading.transactions t2 
         WHERE MONTH(t2.txn_time) = 12
     )   
);

WITH temp_table AS (
     SELECT  m.first_name 
	       , m.region
	       , sum(t.quantity)
	   FROM trading.members m  
 INNER JOIN trading.transactions t 
         ON m.member_id = t.member_id
      WHERE DATE_FORMAT(t.txn_time,'%Y-%m-%d') IN (
     SELECT DISTINCT LAST_DAY(t2.txn_time)
       FROM trading.transactions t2 
      WHERE MONTH(t2.txn_time) = 12
    ) 
   GROUP BY t.ticker   
)
    
SELECT * FROM temp_table;

 SELECT DISTINCT DATE_FORMAT(t.txn_time,'%Y-%m-%d') FROM trading.transactions t ; 
    
	 SELECT  m.first_name 
	       , m.region
	       , t.ticker 
	       , sum(t.quantity)
	   FROM trading.members m  
 INNER JOIN trading.transactions t 
         ON m.member_id = t.member_id
      WHERE DATE_FORMAT(t.txn_time,'%Y-%m-%d') IN (
    		SELECT DISTINCT LAST_DAY(t2.txn_time)
       		  FROM trading.transactions t2 
             WHERE MONTH(t2.txn_time) = 12
    ) 
   GROUP BY t.ticker; 
    
 -- ANSWER
DROP TABLE IF EXISTS temp_portfolio_base;
CREATE TEMP TABLE temp_portfolio_base AS
	WITH cte_joined_data AS (
	  SELECT
	    members.first_name,
	    members.region,
	    transactions.txn_date,
	    transactions.ticker,
	    CASE
	      WHEN transactions.txn_type = 'SELL' THEN -transactions.quantity
	      ELSE transactions.quantity
	    END AS adjusted_quantity
	  FROM trading.transactions
	  INNER JOIN trading.members
	    ON transactions.member_id = members.member_id
	  WHERE transactions.txn_date <= '2020-12-31'
	)
	SELECT
	  first_name,
	  region,
	  (DATE_TRUNC('YEAR', txn_date) + INTERVAL '12 MONTHS' - INTERVAL '1 DAY')::DATE AS year_end,
	  ticker,
	  SUM(adjusted_quantity) AS yearly_quantity
	FROM cte_joined_data
	GROUP BY first_name, region, year_end, ticker;

SELECT * FROM trading.transactions t;

WITH recursive temptest AS (
	SELECT txn_id  
	  FROM transactions 
     WHERE member_id = '45c48c'	  	  
);


WITH cte AS
(
  SELECT 3 FROM DUAL
)

SELECT 3 FROM DUAL;

-- Step 2
-- Let's take a look at our base table now to see what data we have to play with - to keep things simple, 
-- let's take a look at Abe's data from our new temp table temp_portfolio_base
-- Inspect the year_end, ticker and yearly_quantity values from our new temp table temp_portfolio_base 
-- for Mentor Abe only. Sort the output with ordered BTC values followed by ETH values








  
  
    
