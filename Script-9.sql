-- SQL Programming
-- SQL에서도 일반적인 코딩이 가능
-- 일반적인 언어문 보다는 약하지만 반복문, 조건문은 가능


-- Stored Precedure
-- 문법 DELIMETER $$ CREATE PROCEDURE 프로시져 이름 BEGIN 프로시져 내용 END $$ DELIMTER;
-- 프로시져 호출 CALL 프로시져 이름

-- IF 문 (조건문)
-- 문법 : IF <조건식> THEN SQL 문장들 END IF;

USE market_db;

DROP PROCEDURE IF EXISTS ifProc1; -- 기존에 만든 프로시져면 삭제

DELIMITER $$
CREATE PROCEDURE ifProc1()
BEGIN
	IF 100 = 100 THEN
		SELECT '100 은 100과 같습니다.';
	END IF;
END $$
DELIMITER;
CALL ifProc1();

-- IF ~ ELSE 문 (참 일시 IF 문 수행 거짓일 시 ELSE 문 수행)
DROP PROCEDURE IF EXISTS ifProc2; -- 기존에 만든 프로시져면 삭제

DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
	DECLARE myNum = INT;	-- myNum 변수 선언
	SET myNum = 200;	-- 변수에 값 대입
	IF myNum = 100 THEN
		SELECT '100 입니다.';
	ELSE 
		SELECT '100이 아닙니다.';
	END IF;
END $$
DELIMITER;
CALL ifProc2();

USE market_db;


DROP PROCEDURE IF EXISTS TestProcedure; -- 기존에 만든 프로시져면 삭제


-- DELIMITER 
CREATE PROCEDURE TestProcedure()
BEGIN
	SELECT * FROM market_db.buy;
END 
--DELIMITER;

CALL TestProcedure();

DROP PROCEDURE IF EXISTS ifProc3; -- 기존에 만든 프로시져면 삭제


CREATE PROCEDURE ifProc3()
BEGIN
	DECLARE debutDate DATE;	-- 데뷔일
	DECLARE curDate DATE;	-- 오늘 날짜
	DECLARE days INT;	-- 활동한 일 수 
	
	-- debutDate 변수에 값이 대입 됨
	SELECT debut_date INTO debutDate	-- debut_date 결과를 hireDate 에 대입
	  FROM market_db.`member` m 
	 WHERE m.mem_id = 'APN';
	
	SET curDATE = CURRENT_DATE();	-- 현재 날짜
	SET days = DATEDIFF(curDATE, debutDate);	-- 날짜의 차이, 일 단위
	
	IF(days/365) >= 5 THEN -- 5 년이 지났다면
		SELECT CONCAT('데뷔한지 ' , days, ' 일이나 지났습니다. 팡순이들 축하 합니다.');
	ELSE 
		SELECT '데뷔한지 ' + days + '일 밖에 안되었네요. 팡순이들 화이팅 !';
	END IF;
END;

CALL ifProc3();


-- CASE 문 (IF 문은 참/거짓 2 가지 이지만 CASE 문은 여러가지 경우가 존재 시 사용이 가능)
-- 문법 : CASE WHEN 조건1 THEN 실행 SQL 문장 WHEN 조건 2 THEN SQL 문장2 ELSE SQL문장4 END CASE;
-- ELSE 는 딱 한번 와야 함 

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
		CONCAT('취득 점수 ==> ', point)
	  , CONCAT('학점 ==> ', credit);
END;
	
-- caseProc() Stored Procdure 호출 
CALL caseProc();

-- case 문의 활용
-- 쇼핑몰에서 총구매액에 따라 회원 등급 조회 하기

SELECT * FROM market_db.buy b ;

-- mem_id 에 따라 총 구매액 구하기
SELECT mem_id, SUM(price*amount) '총 구매액'
	FROM market_db.buy b 
	GROUP BY mem_id	
	ORDER BY SUM(price*amount) DESC;

SELECT b.mem_id, m.mem_name, SUM(price*amount)  
  FROM market_db.buy b 
INNER JOIN market_db.`member` m 
	    ON b.mem_id = m.mem_id 
  GROUP BY b.mem_id 
  ORDER BY SUM(price*amount) DESC;

 -- 유령 회원이 안나오므로 RIGHT OUTER JOIN 으로 변경
SELECT b.mem_id, m.mem_name, SUM(price*amount)  
  FROM market_db.buy b 
RIGHT JOIN market_db.`member` m 
	    ON b.mem_id = m.mem_id 
  GROUP BY b.mem_id 
  ORDER BY SUM(price*amount) DESC;

 -- CASE 문을 통하여 회원 구매액에 따라 회원등급 표출
 SELECT 
        m.mem_id
      , m.mem_name
      , SUM(price * amount) '총 구매액'
      ,
 	    CASE 
 	    	WHEN (SUM(price*amount) >= 1500) THEN '최우수 고객'
 	    	WHEN (SUM(price*amount) >= 1000) THEN '우수 고객'
 	    	WHEN (SUM(price*amount) <= 1) THEN '일반고객'
 	    	ELSE '유령고객'
 	    END
   FROM market_db.buy b  
RIGHT OUTER JOIN market_db.`member` m 
			  ON b.mem_id = m.mem_id 
		GROUP BY m.mem_id;	  

-- WHILE 문 
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
	
	SELECT '1부터 100까지의 합은 : ' + hap;
END

CALL whileProce();

-- ITERATE 문과 LEAVE 문 (조건이 충족 되었을 시 해당 루프가 즉시 끝남)

DROP PROCEDURE IF EXISTS whileProc2; 

CREATE PROCEDURE whileProc2()
BEGIN
	DECLARE i INT;
	DECLARE hap INT;
	SET i = 0;
	SET hap = 0;
	
	-- myWhile 이라고 이름을 지정 
	myWhile:	-- WHILE 문에 label 을 지정
	WHILE (i <= 100) DO	 
		IF(i % 4 = 0) THEN
			SET i = i + 1;	 
			ITERATE myWhile;	-- 지정한 label 문으로 가서 계속 진행
		END IF;
	
		SET hap = hap + i;
	
		IF(hap > 1000) THEN
			LEAVE myWhile;	-- 지정한 label 문을 떠남 , WHILE 문 즉시 종료
		END IF;
	
		SET i = i + 1;
		
	END WHILE;
	
	SELECT '1 부터 100 까지의 합 (4의 배수 제외), 1000 넘으면 종료 ==> ' , hap;
END

CALL whileProc2();

-- 동적 SQL 
-- 동적 SQL 은 SQL 을 고정시키지 않고 동적을 만들 수 가 있음
-- PREPARE 를 사용 시 동적 SQL로 사용을 할 수 가 있음 
-- 동적 SQL은 EX)출입문에 누가 출입하였는 지 DB에 데이터 저장 시 현재 시간 등 ... 동적 SQL 로 INSERT 를 사용

DROP TABLE IF EXISTS gate_table;

CREATE TABLE gate_table (id INT AUTO_INCREMENT PRIMARY KEY, entry_time DATETIME);

-- SET @curDate = CURRENT_TIMESTAMP();	-- 현재 날짜와 시간
SET @curDate = CURRENT_TIMESTAMP(); 
PREPARE myQuery FROM 'INSERT INTO gate_table VALUES(NULL, ?)';	-- SQL 문 준비
EXECUTE myQuery USING @curDate;	-- USING @curDate curDate 가 물음표 변수로 대입이 됨
DEALLOCATE PREPARE myQuery;

SELECT * FROM market_db.gate_table;














