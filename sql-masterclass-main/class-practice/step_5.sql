-- Question 1
-- What is the earliest and latest date of transactions for all members?
SELECT * FROM trading.transactions t; 
SELECT * FROM trading.members m;
SELECT * FROM trading.prices p;

       SELECT t.member_id
            , t.txn_type 
            , t.quantity 
            , m.first_name 
            , m.region
            , t.txn_time 
         FROM trading.members m 
   INNER JOIN trading.transactions t 
           ON m.member_id = t.member_id
        WHERE t.txn_time IN (
       			SELECT t2.txn_time
                  FROM trading.transactions t2
        		HAVING t2.txn_time = MIN(t2.txn_time)
        		    OR t2.txn_time = MAX(t2.txn_time)
              );    
           
   	SELECT * 
      FROM trading.transactions t 
     WHERE t.txn_time IN (
    		SELECT MIN(t2.txn_time) 
    		  FROM trading.transactions t2 
     );
         
       -- ANSWER
       SELECT
		  MIN(txn_date) AS earliest_date,
		  MAX(txn_date) AS latest_date
		FROM trading.transactions;  
         
-- Question 2
-- What is the range of market_date values available in the prices data?        
         	SELECT min(p.market_date) FROM trading.prices p;
			SELECT min(t.txn_time) FROM trading.transactions t;
			
			SELECT min(p.market_date) AS 'MIN-DATE', 
			       max(p.market_date) AS 'MAX-DATE' 
		      FROM trading.prices p;
	
		-- ANSWER 
		SELECT
		       MIN(market_date) AS earliest_date,
		       MAX(market_date) AS latest_date
		  FROM trading.prices;     

-- Question 3
-- Which top 3 mentors have the most Bitcoin quantity as of the 29th of August?		 
SELECT * FROM trading.members m;	

						SELECT t.ticker 
						     , t.member_id 
						     , sum(t.quantity) AS BUYQ
					      FROM trading.transactions t
					     WHERE t.txn_type = 'BUY'
					       AND t.ticker = 'BTC'
					  GROUP BY t.member_id
					  ORDER BY BUYQ DESC
					     LIMIT 3;
	

						SELECT t.member_id 
						     , sum(t.quantity) AS 'BUY QUAN' 
					      FROM trading.transactions t
					     WHERE t.txn_type = 'BUY'
					  GROUP BY t.member_id
					  ORDER BY 'ASD' DESC
					     LIMIT 3;		 
		 
				SELECT m.member_id 
				     , m.first_name 
				     , SUM(
				     	CASE  
				     		WHEN t.txn_type = 'BUY'  THEN t.quantity
				     		WHEN t.txn_type = 'SELL' THEN -t.quantity
				     	END
				     ) AS total_q
				  FROM trading.members m 
		    INNER JOIN trading.transactions t 
				    ON m.member_id = t.member_id
				 WHERE t.ticker = 'BTC'  
		      GROUP BY m.first_name 		 
			  ORDER BY total_q DESC
			     LIMIT 3;		    
					    
		 -- ANSWER
			    SELECT
				  members.first_name,
				  SUM(
				    CASE
				      WHEN transactions.txn_type = 'BUY'  THEN transactions.quantity
				      WHEN transactions.txn_type = 'SELL' THEN -transactions.quantity
				    END
				  ) AS total_quantity
				FROM trading.transactions
				INNER JOIN trading.members
				  ON transactions.member_id = members.member_id
				WHERE ticker = 'BTC'
				GROUP BY members.first_name
				ORDER BY total_quantity DESC
				LIMIT 3;
		 
-- TODO Question 4 5 번 이해 안됨 조금더 확인하여 보기 !!!!
			
			
			
-- Question 4
-- What is total value of all Ethereum portfolios for each region at the end date of our analysis? 
-- Order the output by descending portfolio value
		WITH 	
			
			
			
			
		SELECT sum(t.quantity) 
	      FROM trading.transactions t
	     WHERE t.ticker = 'ETH'; 
			 
	     SELECT * FROM trading.members m;
		 SELECT * FROM trading.prices p;
		 SELECT * FROM trading.transactions t;
		
		
		SELECT  m.region
		      , sum(
				CASE 
					WHEN t.txn_type = 'BUY'  THEN t.quantity
					WHEN t.txn_type = 'SELL' THEN -t.quantity
				END
			) AS total_q
			, t.txn_time 
		  FROM trading.members m
	INNER JOIN trading.transactions t	  
		    ON m.member_id = t.member_id
		 WHERE t.ticker ='ETH' 
		   AND t.txn_time IN (SELECT MAX(t2.txn_time) FROM trading.transactions t2 INNER JOIN trading.members m2 WHERE t2.member_id = m2.member_id GROUP BY m2.region)
	  GROUP BY m.region
	  ORDER BY total_q DESC; 
		
		-- ANSWER
	 WITH cte_latest_price AS (
		  SELECT
		    ticker,
		    price
		  FROM trading.prices
		  WHERE ticker = 'ETH'
		  AND market_date = '2021-08-29'
		)
		SELECT
		  members.region,
		  SUM(
		    CASE
		      WHEN transactions.txn_type = 'BUY'  THEN transactions.quantity
		      WHEN transactions.txn_type = 'SELL' THEN -transactions.quantity
		    END
		  ) * cte_latest_price.price AS ethereum_value,
		  AVG(
		    CASE
		      WHEN transactions.txn_type = 'BUY'  THEN transactions.quantity
		      WHEN transactions.txn_type = 'SELL' THEN -transactions.quantity
		    END
		  ) * cte_latest_price.price AS avg_ethereum_value
		FROM trading.transactions
		INNER JOIN cte_latest_price
		  ON transactions.ticker = cte_latest_price.ticker
		INNER JOIN trading.members
		  ON transactions.member_id = members.member_id
		WHERE transactions.ticker = 'ETH'
		GROUP BY members.region, cte_latest_price.price
		ORDER BY avg_ethereum_value DESC;
		
		
-- Question 5
-- What is the average value of each Ethereum portfolio in each region? Sort this output in descending order
SELECT * FROM trading.transactions t;
SELECT * FROM trading.members m;

				SELECT m.region 
				     , avg(t.quantity) AS avg_qu
				  FROM trading.members m
			INNER JOIN trading.transactions t	
					ON m.member_id = t.member_id 
				 WHERE t.ticker = 'ETH'
			  GROUP BY m.region
			  ORDER BY avg_qu DESC; 

-- ANSWER
			 
		 	SELECT * FROM trading.prices p WHERE p.market_date = '2021-08-29';
			 
			WITH cte_latest_price AS (
				  SELECT
				    ticker,
				    price
				  FROM trading.prices
				  WHERE ticker = 'ETH'
				  AND market_date = '2021-08-29'
			)
			SELECT
			  members.region,
			  AVG(
			    CASE
			      WHEN transactions.txn_type = 'BUY'  THEN transactions.quantity
			      WHEN transactions.txn_type = 'SELL' THEN -transactions.quantity
			    END
			  ) * cte_latest_price.price AS avg_ethereum_value
			FROM trading.transactions
			INNER JOIN cte_latest_price
			  ON transactions.ticker = cte_latest_price.ticker
			INNER JOIN trading.members
			  ON transactions.member_id = members.member_id
			WHERE transactions.ticker = 'ETH'
			GROUP BY members.region, cte_latest_price.price
			ORDER BY avg_ethereum_value DESC;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		