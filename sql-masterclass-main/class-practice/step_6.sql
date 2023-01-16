-- Questions 1-4
-- What is the total portfolio value for each mentor at the end of 2020?
-- What is the total portfolio value for each region at the end of 2019?
-- What percentage of regional portfolio values does each mentor contribute at the end of 2018?
-- Does this region contribution percentage change when we look across both Bitcoin and Ethereum portfolios independently at the end of 2017?

-- Step 1
-- Create a base table that has each mentor's name, region and end of year total quantity for each ticker
			
SELECT * FROM trading.members m GROUP BY m.member_id;
			
			DROP TEMPORARY TABLE temp_mentor_name;

			CREATE TEMPORARY TABLE temp_mentor_name (
				SELECT m.first_name
				     , t.ticker 
				     , m.region
				     , sum(t.quantity)
				  FROM trading.members m 
		    INNER JOIN trading.transactions t 
		            ON m.member_id = t.member_id 
			  GROUP BY m.member_id, t.ticker, YEAR(t.txn_time) 	
	      );
		  
	     SELECT m.first_name
	          , t.ticker
	          , t.txn_time 
	     	  , m.region
	          , sum(t.quantity)
	       FROM trading.members m 
	 INNER JOIN trading.transactions t 
	         ON m.member_id = t.member_id 
	   GROUP BY m.member_id, t.ticker 
	   ORDER BY t.ticker; 
	   
	   SELECT * FROM temp_mentor_name;
	  
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
	     

-- Step 2
-- Let's take a look at our base table now to see what data we have to play with 
-- to keep things simple, 
-- let's take a look at Abe's data from our new temp table temp_portfolio_base
-- Inspect the year_end, ticker and yearly_quantity values from our 
-- new temp table temp_portfolio_base 
-- for Mentor Abe only. Sort the output with ordered BTC values followed by ETH values
	DROP TEMPORARY TABLE temp_portfolio_base;
	CREATE TEMPORARY TABLE temp_portfolio_base (
		SELECT t.ticker 
		     , YEAR(t.txn_time)	AS 'Year' 	 
		     , sum(t.quantity)
		  FROM trading.members m 
	INNER JOIN trading.transactions t	
	        ON m.member_id = t.member_id 
		 WHERE m.first_name = 'Abe'
	  GROUP BY t.ticker, YEAR(t.txn_time)	
	);
	-- ANSWER
		SELECT
		  year_end,
		  ticker,
		  yearly_quantity
		FROM temp_portfolio_base
		WHERE first_name = 'Abe'
		ORDER BY ticker, year_end;
	SELECT * FROM temp_portfolio_base;
			
-- Step 3
-- To create the cumulative sum - we'll need to apply a window function!
-- Although we will only touch on this briefly in this course - the complete Data With Danny Serious 
-- SQL course covers this topic and many other SQL concepts in a lot of depth!
-- Create a cumulative sum for Abe which has an independent value for each ticker
	
		SELECT m.first_name
		     , m.member_id
		     , t.txn_time 
		     , t.ticker
		     , sum(t.quantity) AS year_sum
		     , SUM(t.quantity) OVER(PARTITION BY t.txn_time ORDER BY t.txn_time) AS sum_sal	  
		  FROM trading.members m 
	INNER JOIN trading.transactions t 
	        ON m.member_id = t.member_id 
	   	 WHERE m.first_name = 'Abe'
	  GROUP BY t.ticker, YEAR(t.txn_time);      
 
	 -- ANSWER
	 	SELECT
		  year_end,
		  ticker,
		  yearly_quantity,
		  /* this is a multi-line comment!
		     for this case we don't actually need first_name
		     but we include it anyway to prepare for the next query! */
		  SUM(yearly_quantity) OVER (
		    PARTITION BY first_name, ticker
		    ORDER BY year_end
		    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		  ) AS cumulative_quantity
		FROM temp_portfolio_base
		WHERE first_name = 'Abe'
		ORDER BY ticker, year_end;
	 
-- Step 4
-- Now let's apply our same window function to the entire temporary dataset and start 
-- answering our questions.
-- We can actually ALTER and UPDATE our temp table to add in an extra column with our new calculation
-- Generate an additional cumulative_quantity column for the temp_portfolio_base temp table
		ALTER TABLE temp_portfolio_base ADD cumulative_quantity NUMERIC;
		
	
		UPDATE temp_portfolio_base SET cumulative_quantity = (
					
		
		
		);
	
	
		DROP TEMPORARY TABLE temp_portfolio_base;
		CREATE TEMPORARY TABLE temp_portfolio_base (
			SELECT t.ticker 
			     , YEAR(t.txn_time)	AS 'Year' 	 
			     , sum(t.quantity)
			  FROM trading.members m 
		INNER JOIN trading.transactions t	
		        ON m.member_id = t.member_id 
			 WHERE m.first_name = 'Abe'
		  GROUP BY t.ticker, YEAR(t.txn_time)	
		);
		
		SELECT * FROM temp_portfolio_base;
	
	
	
	
	
	
	
	
    
