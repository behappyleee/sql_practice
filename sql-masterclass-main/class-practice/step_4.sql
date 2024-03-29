SELECT * FROM trading.transactions t;

-- Question 1
-- How many records are there in the trading.transactions table?
SELECT count(*) AS 'DataCount' FROM trading.transactions t;

-- Question 2
-- How many unique transactions are there?
SELECT DISTINCT count(*) FROM trading.transactions t;
-- ANSWER
SELECT COUNT(DISTINCT txn_id) FROM trading.transactions;

-- Question 3
-- How many buy and sell transactions are there for Bitcoin?
SELECT t.txn_type, count(*) FROM trading.transactions t GROUP BY t.txn_type;

-- Question 4
-- For each year, calculate the following buy and sell metrics for Bitcoin:
SELECT t.txn_type, YEAR(t.txn_time), COUNT(*), sum(t.quantity), avg(t.quantity)  
FROM trading.transactions t GROUP BY t.txn_type, YEAR(t.txn_time);

-- ANSWER
SELECT
  EXTRACT(YEAR FROM txn_date) AS txn_year,
  txn_type,
  COUNT(*) AS transaction_count,
  ROUND(SUM(quantity)::NUMERIC, 2) AS total_quantity,
  ROUND(AVG(quantity)::NUMERIC, 2) AS average_quantity
FROM trading.transactions
WHERE ticker = 'BTC'
GROUP BY txn_year, txn_type
ORDER BY txn_year, txn_type;

-- Question 5
-- What was the monthly total quantity purchased and sold for Ethereum in 2020?
    SELECT YEAR(t.txn_time)
         , MONTH(t.txn_time) AS 'month'
         , (
         	  SELECT count(*) FROM trading.transactions t2 WHERE t2.txn_type = 'BUY'
          ) AS 'Buy Count'
         , (
         	 SELECT count(*) FROM trading.transactions t2 WHERE t2.txn_type = 'SELL' 
           ) AS 'Sell Count'
      FROM trading.transactions t 
     WHERE YEAR(t.txn_time) = 2020
       AND t.ticker = 'ETH'
  GROUP BY MONTH(t.txn_time);

-- ANSWER
	SELECT
	  DATE_TRUNC('MON', txn_date)::DATE AS calendar_month,
	  SUM(CASE WHEN txn_type = 'BUY' THEN quantity ELSE 0 END) AS buy_quantity,
	  SUM(CASE WHEN txn_type = 'SELL' THEN quantity ELSE 0 END) AS sell_quantity
	FROM trading.transactions
	WHERE txn_date BETWEEN '2020-01-01' AND '2020-12-31'
	  AND ticker = 'ETH'
	GROUP BY calendar_month
	ORDER BY calendar_month;

-- Question 6
-- Summarise all buy and sell transactions for each member_id by generating 1 row for each member 
-- with the following additional columns: Bitcoin buy quantity, Bitcoin sell quantity, Ethereum buy quantity, Ethereum sell quantity
			SELECT t.member_id
			     , sum(CASE WHEN t.ticker ='BTC' AND t.txn_type = 'BUY'  THEN t.quantity END) AS 'BTC Buy Quantity'
			     , sum(CASE WHEN t.ticker ='ETH' AND t.txn_type = 'SELL' THEN t.quantity END) AS 'ETH Sell Quantity'
			     , sum(CASE WHEN t.ticker ='BTC' AND t.txn_type = 'BUY'  THEN t.quantity END) AS 'BTC Buy Quantity'
			     , sum(CASE WHEN t.ticker ='ETH' AND t.txn_type = 'SELL' THEN t.quantity END) AS 'ETH Sell Quantity'
		      FROM trading.transactions t 
		  GROUP BY t.member_id;

-- ANSWER
		 SELECT
  member_id,
  SUM(
    CASE
      WHEN ticker = 'BTC' AND txn_type = 'BUY' THEN quantity
      ELSE 0
    END
  ) AS btc_buy_qty,
  SUM(
    CASE
      WHEN ticker = 'BTC' AND txn_type = 'SELL' THEN quantity
      ELSE 0
    END
  ) AS btc_sell_qty,
  SUM(
    CASE
      WHEN ticker = 'ETH' AND txn_type = 'BUY' THEN quantity
      ELSE 0
    END
  ) AS eth_buy_qty,
  SUM(
    CASE
      WHEN ticker = 'BTC' AND txn_type = 'SELL' THEN quantity
      ELSE 0
    END
  ) AS eth_sell_qty
FROM trading.transactions
GROUP BY member_id;

-- Question 7
-- What was the final quantity holding of Bitcoin for each member? 
-- Sort the output from the highest BTC holding to lowest
			SELECT t.member_id  
				 , max(t.txn_time)
				 , t.quantity 
			  FROM trading.transactions t 
          GROUP BY t.member_id;

-- Question 8
-- Which members have sold less than 500 Bitcoin? Sort the output from the most BTC sold to least
			SELECT t.member_id 
			  FROM trading.transactions t 	
             WHERE t.ticker = 'BTC'
               AND t.quantity < 500
               AND t.txn_type = 'SELL';
         
              SELECT t.member_id 
                   , sum(t.quantity) AS 'SUM QUANTITY'
                FROM trading.transactions t 
               WHERE t.ticker = 'BTC'
                 AND t.txn_type = 'SELL'
                 AND 'SUM QUANTITY' < 500
            GROUP BY t.member_id; 
                 
                 
         	SELECT * FROM trading.transactions t WHERE t.txn_type = 'SELL';
				
			SELECT * 
			  FROM trading.transactions t
			 WHERE t.txn_type = 'SELL';
		
            SELECT * 
		      FROM trading.transactions t
		     WHERE t.txn_type = 'SELL'
		  GROUP BY t.member_id
		    HAVING sum(t.quantity) < 500;
	
		   SELECT * FROM trading.transactions t WHERE t.quantity < 500;

-- ANSWER
			SELECT member_id
			     , SUM(quantity) AS btc_sold_quantity
			  FROM trading.transactions
			 WHERE ticker = 'BTC'
			   AND txn_type = 'SELL'
		  GROUP BY member_id
			HAVING SUM(quantity) < 500
		  ORDER BY btc_sold_quantity DESC;
		  
		  WITH cte AS (
				SELECT
				  member_id,
				  SUM(quantity) AS btc_sold_quantity
				FROM trading.transactions
				WHERE ticker = 'BTC'
				  AND txn_type = 'SELL'
				GROUP BY member_id
				)
			SELECT * FROM cte
			WHERE btc_sold_quantity < 500
			ORDER BY btc_sold_quantity DESC;
		
		  SELECT * FROM (
			  SELECT
			    member_id,
			    SUM(quantity) AS btc_sold_quantity
			  FROM trading.transactions
			  WHERE ticker = 'BTC'
			    AND txn_type = 'SELL'
			  GROUP BY member_id
			) AS subquery
			WHERE btc_sold_quantity < 500
			ORDER BY btc_sold_quantity DESC;
		  
-- Question 9
-- What is the total Bitcoin quantity for each member_id owns after adding all of the BUY and SELL transactions 
-- from the transactions table? Sort the output by descending total quantity		  
		 SELECT * 
		   FROM trading.transactions t 
	   GROUP BY t.member_id; 
		  
-- Question 10
-- Which member_id has the highest buy to sell ratio by quantity?		  
   				SELECT * 
   		  		  FROM trading.transactions t
   		  		 WHERE t.txn_type = 'SELL'
   		  	  GROUP BY t.member_id;  
		   
		  
-- Question 11
-- For each member_id - which month had the highest total Ethereum quantity sold`?		  
					SELECT  t.member_id 
					      , MONTH(t.txn_time) AS 'MONTH'
					      , t.txn_time 
					      , max(t.quantity)  
				      FROM trading.transactions t 
				     WHERE t.ticker = 'ETH'
				       AND t.txn_type = 'SELL'
				  GROUP BY t.member_id , MONTH(t.txn_time); 

-- ANSWER
	WITH cte_ranked AS (
			SELECT
			  member_id,
			  DATE_TRUNC('MON', txn_date)::DATE AS calendar_month,
			  SUM(quantity) AS sold_eth_quantity,
		  	RANK() OVER (PARTITION BY member_id ORDER BY SUM(quantity) DESC) AS month_rank
			FROM trading.transactions
			WHERE ticker = 'ETH' AND txn_type = 'SELL'
			GROUP BY member_id, calendar_month
		)
	SELECT
	  member_id,
	  calendar_month,
	  sold_eth_quantity
	FROM cte_ranked
	WHERE month_rank = 1
	ORDER BY sold_eth_quantity DESC;				 










