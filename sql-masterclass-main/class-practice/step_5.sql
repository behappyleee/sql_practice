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
         
         