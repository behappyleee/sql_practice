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
				 , t.txn_time
				 , t.quantity 
			  FROM trading.transactions t 
          GROUP BY t.member_id;

-- Question 8
-- Which members have sold less than 500 Bitcoin? Sort the output from the most BTC sold to least
















