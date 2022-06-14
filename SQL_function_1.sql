-- PROCEDURE 2

-- STORED 함수 와 CURSOR 
-- STORED 함수는 PROCEDURE 와 살짝 다름
-- STORED 함수는 MySQL 에서 제공해주는 함수 외에 자신이 만드는 함수임

-- 문법 : CREATE FUNCTION 스토어드_함수_이름 (매개변수) RETURNS 변환 형식 BEGIN 코딩 RETURN 반환 값; END

-- 호출 : SELECT 스토어드_함수_이름 (대부분 SELECT 이용하여 호출)

-- 한번만 실행하면 됨 그러면 계속 세팅이 되어 있음
SET GLOBAL log_bin_trust_function_creators = 1;

USE market_db;

DROP FUNCTION IF EXISTS sumFunc;

CREATE FUNCTION sumFunc(number1 INT, number2 INT) 
	RETURNS INT
BEGIN 
	RETURN number1 + number2;
END;

SELECT sumFunc(100, 200) AS '합계';

DROP FUNCTION IF EXISTS calcYearFunc;

CREATE FUNCTION calYearFunc(dYear INT)
	RETURNS INT
BEGIN
	DECLARE runYear INT;	-- 활동기간(연도)
	SET runYear = YEAR(CURDATE()) - dYear;
	RETURN runYear;
END;

SELECT calYearFunc(2015);

SELECT calYearFunc(2007) INTO @debut2007;
SELECT calYearFunc(2013) INTO @debut2013;
SELECT @debut2007 - @debut2013 AS '2007년 과 2013 차이';

-- 보통 함수를 정의하고 결과 출력 시 사용을 많이 함
SELECT mem_id, mem_name, calYearFunc(YEAR(debut_date)) AS '활동 년 수'
	FROM MEMBER;

-- 함수의 삭제
DROP FUNCTION calYearFunc;



















