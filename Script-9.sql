-- SQL Programming
-- SQL������ �Ϲ����� �ڵ��� ����
-- �Ϲ����� �� ���ٴ� �������� �ݺ���, ���ǹ��� ����


-- Stored Precedure
-- ���� DELIMETER $$ CREATE PROCEDURE ���ν��� �̸� BEGIN ���ν��� ���� END $$ DELIMTER;
-- ���ν��� ȣ�� CALL ���ν��� �̸�

-- IF �� (���ǹ�)
-- ���� : IF <���ǽ�> THEN SQL ����� END IF;

USE market_db;

DROP PROCEDURE IF EXISTS ifProc1; -- ������ ���� ���ν����� ����

DELIMITER $$
CREATE PROCEDURE ifProc1()
BEGIN
	IF 100 = 100 THEN
		SELECT '100 �� 100�� �����ϴ�.';
	END IF;
END $$
DELIMITER;
CALL ifProc1();

-- IF ~ ELSE �� (�� �Ͻ� IF �� ���� ������ �� ELSE �� ����)
DROP PROCEDURE IF EXISTS ifProc2; -- ������ ���� ���ν����� ����

DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
	DECLARE myNum = INT;	-- myNum ���� ����
	SET myNum = 200;	-- ������ �� ����
	IF myNum = 100 THEN
		SELECT '100 �Դϴ�.';
	ELSE 
		SELECT '100�� �ƴմϴ�.';
	END IF;
END $$
DELIMITER;
CALL ifProc2();

USE market_db;


DROP PROCEDURE IF EXISTS TestProcedure; -- ������ ���� ���ν����� ����


-- DELIMITER 
CREATE PROCEDURE TestProcedure()
BEGIN
	SELECT * FROM market_db.buy;
END 
--DELIMITER;

CALL TestProcedure();

DROP PROCEDURE IF EXISTS ifProc3; -- ������ ���� ���ν����� ����


CREATE PROCEDURE ifProc3()
BEGIN
	DECLARE debutDate DATE;	-- ������
	DECLARE curDate DATE;	-- ���� ��¥
	DECLARE days INT;	-- Ȱ���� �� �� 
	
	-- debutDate ������ ���� ���� ��
	SELECT debut_date INTO debutDate	-- debut_date ����� hireDate �� ����
	  FROM market_db.`member` m 
	 WHERE m.mem_id = 'APN';
	
	SET curDATE = CURRENT_DATE();	-- ���� ��¥
	SET days = DATEDIFF(curDATE, debutDate);	-- ��¥�� ����, �� ����
	
	IF(days/365) >= 5 THEN -- 5 ���� �����ٸ�
		SELECT CONCAT('�������� ' , days, ' ���̳� �������ϴ�. �μ��̵� ���� �մϴ�.');
	ELSE 
		SELECT '�������� ' + days + '�� �ۿ� �ȵǾ��׿�. �μ��̵� ȭ���� !';
	END IF;
END;

CALL ifProc3();


-- CASE �� (IF ���� ��/���� 2 ���� ������ CASE ���� �������� ��찡 ���� �� ����� ����)
-- ���� : CASE WHEN ����1 THEN ���� SQL ���� WHEN ���� 2 THEN SQL ����2 ELSE SQL����4 END CASE;
-- ELSE �� �� �ѹ� �;� �� 

DROP PROCEDURE IF EXISTS caseProc;

CREATE PROCEDURE caseProc()
BEGIN
		DECLARE point INT;
		DECLARE credit CHAR(1);
		SET point = 88;
	
	CASE 
		WHEN point >= 90 THEN
			SET credit = 'A';
		WHEN point >= 80 THEN
			SET credit = 'B';
		WHEN point >= 70 THEN
			SET credit = 'C';
		WHEN point >= 60 THEN
			SET credit = 'D';
		ELSE 
			SET credit = 'F';
	END CASE;
	SELECT 
		CONCAT('��� ���� ==> ', point)
	  , CONCAT('���� ==> ', credit);
END;
	
-- caseProc() Stored Procdure ȣ�� 
CALL caseProc();

-- case ���� Ȱ��
-- ���θ����� �ѱ��ž׿� ���� ȸ�� ��� ��ȸ �ϱ�

SELECT * FROM market_db.buy b ;

-- mem_id �� ���� �� ���ž� ���ϱ�
SELECT mem_id, SUM(price*amount) '�� ���ž�'
	FROM market_db.buy b 
	GROUP BY mem_id	
	ORDER BY SUM(price*amount) DESC;

SELECT b.mem_id, m.mem_name, SUM(price*amount)  
  FROM market_db.buy b 
INNER JOIN market_db.`member` m 
	    ON b.mem_id = m.mem_id 
  GROUP BY b.mem_id 
  ORDER BY SUM(price*amount) DESC;

 -- ���� ȸ���� �ȳ����Ƿ� RIGHT OUTER JOIN ���� ����
SELECT b.mem_id, m.mem_name, SUM(price*amount)  
  FROM market_db.buy b 
RIGHT JOIN market_db.`member` m 
	    ON b.mem_id = m.mem_id 
  GROUP BY b.mem_id 
  ORDER BY SUM(price*amount) DESC;

 -- CASE ���� ���Ͽ� ȸ�� ���ž׿� ���� ȸ����� ǥ��
 SELECT 
        m.mem_id
      , m.mem_name
      , SUM(price * amount) '�� ���ž�'
      ,
 	    CASE 
 	    	WHEN (SUM(price*amount) >= 1500) THEN '�ֿ�� ��'
 	    	WHEN (SUM(price*amount) >= 1000) THEN '��� ��'
 	    	WHEN (SUM(price*amount) <= 1) THEN '�Ϲݰ�'
 	    	ELSE '���ɰ�'
 	    END
   FROM market_db.buy b  
RIGHT OUTER JOIN market_db.`member` m 
			  ON b.mem_id = m.mem_id 
		GROUP BY m.mem_id;	  

-- WHILE �� 
CREATE PROCEDURE whileProce()
BEGIN
	DECLARE i INT;
	DECLARE hap INT;
	SET i = 1;
	SET hap = 0;
	
	WHILE(i <= 100) DO
		SET hap = hap + i;
		SET i = i + 1;
	END WHILE;
	
	SELECT '1���� 100������ ���� : ' + hap;
END

CALL whileProce();

-- ITERATE ���� LEAVE �� (������ ���� �Ǿ��� �� �ش� ������ ��� ����)

DROP PROCEDURE IF EXISTS whileProc2; 

CREATE PROCEDURE whileProc2()
BEGIN
	DECLARE i INT;
	DECLARE hap INT;
	SET i = 0;
	SET hap = 0;
	
	-- myWhile �̶�� �̸��� ���� 
	myWhile:	-- WHILE ���� label �� ����
	WHILE (i <= 100) DO	 
		IF(i % 4 = 0) THEN
			SET i = i + 1;	 
			ITERATE myWhile;	-- ������ label ������ ���� ��� ����
		END IF;
	
		SET hap = hap + i;
	
		IF(hap > 1000) THEN
			LEAVE myWhile;	-- ������ label ���� ���� , WHILE �� ��� ����
		END IF;
	
		SET i = i + 1;
		
	END WHILE;
	
	SELECT '1 ���� 100 ������ �� (4�� ��� ����), 1000 ������ ���� ==> ' , hap;
END

CALL whileProc2();

-- ���� SQL 
-- ���� SQL �� SQL �� ������Ű�� �ʰ� ������ ���� �� �� ����
-- PREPARE �� ��� �� ���� SQL�� ����� �� �� �� ���� 
-- ���� SQL�� EX)���Թ��� ���� �����Ͽ��� �� DB�� ������ ���� �� ���� �ð� �� ... ���� SQL �� INSERT �� ���

DROP TABLE IF EXISTS gate_table;

CREATE TABLE gate_table (id INT AUTO_INCREMENT PRIMARY KEY, entry_time DATETIME);

-- SET @curDate = CURRENT_TIMESTAMP();	-- ���� ��¥�� �ð�
SET @curDate = CURRENT_TIMESTAMP(); 
PREPARE myQuery FROM 'INSERT INTO gate_table VALUES(NULL, ?)';	-- SQL �� �غ�
EXECUTE myQuery USING @curDate;	-- USING @curDate curDate �� ����ǥ ������ ������ ��
DEALLOCATE PREPARE myQuery;

SELECT * FROM market_db.gate_table;














