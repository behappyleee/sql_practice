-- 제공 Tutorial Query
	DROP TABLE IF EXISTS temp_portfolio_base;
	CREATE TEMPORARY TABLE temp_portfolio_base (
		SELECT m.first_name 
		     , m.region 
		     , t.txn_time
		     , t.ticker 
		     , CASE 
		     		WHEN t.txn_type = 'SELL' THEN -t.quantity
		     		ELSE t.quantity 
		       END AS adjusted_quantity
		  FROM trading.members m 
  	INNER JOIN trading.transactions t 
	        ON m.member_id = t.member_id
	     WHERE t.txn_time < '2021-12-31'  
	);
	
	SELECT * FROM temp_portfolio_base;

	SELECT
	  first_name,
	  region,
--	  (date_format('YEAR', txn_date) + INTERVAL '12 MONTHS' - INTERVAL '1 DAY') ::DATE AS year_end,
	  (DATE_TRUNC('YEAR', txn_date) + INTERVAL '12 MONTHS' - INTERVAL '1 DAY')::DATE AS year_end,
	  ticker,
	  SUM(adjusted_quantity) AS yearly_quantity
	FROM temp_portfolio_base
	GROUP BY first_name, region, year_end, ticker;

DROP TABLE IF EXISTS temp_cumulative_portfolio_base;

CREATE TEMPORARY TABLE temp_cumulative_portfolio_base AS
	SELECT
	  first_name,
	  region,
	  year_end,
	  ticker,
	  yearly_quantity,
	  SUM(yearly_quantity) OVER (
	    PARTITION BY first_name, ticker
	    ORDER BY year_end
	    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	  ) AS cumulative_quantity
	FROM temp_portfolio_base;
	

-- Question 1
-- What is the total portfolio value for each mentor at the end of 2020? 
-- We can now inner join our trading.prices table 
-- (I hope you haven't forgot about this one yet!) to our new temp table temp_cumulative_portfolio_base
-- Let's also order our results by highest portfolio value to lowest rounded to 2 decimal places.
				SELECT * FROM trading.prices p; 

				SELECT m.member_id 
				     , m.first_name 
				     , round(sum(t.quantity), 2)
				  FROM trading.members m 
			INNER JOIN trading.transactions t 
			        ON m.member_id = t.member_id
			INNER JOIN trading.prices p 
			        ON t.ticker = p.ticker 
			     WHERE YEAR(t.txn_time) = 2020      
 			  GROUP BY m.member_id;	
				
				-- ANSWER
 			 SELECT
				  base.first_name,
				  ROUND(
				    SUM(base.cumulative_quantity * prices.price),
				    2
				  ) AS portfolio_value
				FROM temp_cumulative_portfolio_base AS base
				INNER JOIN trading.prices
				  ON base.ticker = prices.ticker
				  AND base.year_end = prices.market_date
				WHERE base.year_end = '2020-12-31'
				GROUP BY base.first_name
				ORDER BY portfolio_value DESC;
			
-- !!!!!!!!!!!!!!!!!!!!	2 번 부터 문제 풀기 !!!!!!!!!!!!!!!!!!!!
			
			
