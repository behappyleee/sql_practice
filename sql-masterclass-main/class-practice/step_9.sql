SELECT * FROM trading.transactions t;
SELECT * FROM trading.members m;
SELECT * FROM trading.prices p;

-- 임시 테이블 생성 
SELECT * FROM trading.transactions t 
WHERE t.member_id = 'c20ad4' AND date_format(t.txn_time, '%Y-%m-%d') = '2017-01-01';

SELECT date_format('2021-2-3 13:35:00', '%Y-%m-%d') FROM DUAL;

SELECT * FROM trading.transactions t WHERE t.member_id = 'c20ad4';
SELECT * FROM trading.transactions t WHERE t.member_id = 'c20ad4' AND date_format(t.txn_time, '%Y-%m-%d')  = '2017-01-01';
SELECT * FROM trading.transactions t WHERE t.member_id = 'c20ad4' AND t.txn_type = 'BUY' AND t.quantity = 1372;
				SELECT * 
				  FROM trading.transactions t 

SELECT * 
	  FROM trading.transactions t 
	 WHERE t.member_id = 'c20ad4' 
	AND date_format(t.txn_time, '%Y-%m-%d') = '2017-01-01' AND t.quantity = 50;

CREATE TEMP TABLE leah_hodl_strategy AS (
	SELECT * 
	  FROM trading.transactions t 
	 WHERE t.member_id = 'c20ad4'	
       AND date_format(t.txn_time, '%Y-%m-%d')  = '2017-01-01'
       AND t.quantity = 50
 );


