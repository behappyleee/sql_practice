-- STORED PROCEDURE

-- STORED PROCEDURE : SQL + Programming

-- $$ 이외의 문자도 상관 없지만 보통 $$ 문자를 사용
-- 문법 DELITMITER $$ CREATE PROCEDURE 프로시져_이름 (IN 또는 OUT 매개변수) BEGIN ~ END DELIMITER;

-- 스토어드 프로시져 생성
USE market_db;

DROP PROCEDURE IF EXISTS user_proc;

-- 매개변수가 존재할 시 괄호안에 매개변수를 넣어줌
CREATE PROCEDURE user_proc()
BEGIN
	SELECT * FROM market_db.MEMBER;
END;

-- PROCEDURE 가 필요할 때 마다 CALL 을 이용하여 호출
CALL user_proc();

-- PROCEDURE 삭제
DROP PROCEDURE user_proc;

-- 스토어드 프로시져 실습
-- 매개변수의 사용
-- 입력 매개변수 형식 IN 입력_매개변수_이름 데이터 형식

-- 출력 매개변수 : 프로시져를 실행하고 반환 받는 값 
-- 출력 매개변수 형식 OUT _출력_매개변수_이름 데이터_형식

DROP PROCEDURE IF EXISTS user_proc_1;

CREATE PROCEDURE user_proc_1(IN userName VARCHAR(10))
BEGIN
	SELECT * FROM market_db.`member` m WHERE m.mem_name = userName;
END;

-- 에이핑크가 파라미터로 들어가 에이핑크 데이터가 조회 됨
CALL user_proc_1('에이핑크');

DROP PROCEDURE IF EXISTS user_proc_2
CREATE PROCEDURE user_proc_2(
	IN userNumber INT,
	IN userWeight INT
)
BEGIN
	SELECT * FROM market_db.`member` m WHERE m.mem_number  > userNumber AND m.height  > userWeight;
END;

CALL user_proc_2(6, 165);

DROP PROCEDURE IF EXISTS user_proc_3;

CREATE PROCEDURE user_proc_3 (
	IN txtValue CHAR(10),
	OUT outValue INT
)
BEGIN
	-- 없는 Table 이 여도 프로시져 생성 시 에러가 발생하지는 않지만
	-- 만드는 시점이 아닌 실행하는 시점에 에러가 발생 (실행 시점 전에만 테이블을 만들어 놓으면 됨)
	INSERT INTO noTable VALUES(NULL, txtValue);
	-- 조회 SELECT 한 id 값 이 outValue 에 값이 들어 감
	SELECT max(id) INTO outVALUE FROM noTable;
END;

DESC noTable;

CREATE TABLE IF NOT EXISTS noTable (
	id INT AUTO_INCREMENT PRIMARY KEY,
	txt CHAR(10)
);

-- '테스트1' 파라미터와, outValue 인 myValue
CALL user_proc_3('테스트1', @myValue);

-- @myValue 에 out매개변수이므로 값 이 들어간다.
SELECT @myValue FROM DUAL;

SELECT * FROM noTable;

DROP PROCEDURE IF EXISTS ifElse_proc;

SELECT * FROM market_db.`member` m ;

CREATE PROCEDURE ifElse_proc(
	IN memName VARCHAR(10)
)
BEGIN 
	DECLARE debutYear INT;	-- 변수 선언
	SELECT YEAR(debut_date) INTO debutYear FROM market_db.`member` m WHERE mem_name = memName;
	
	IF(debutYear >= 2015) THEN
		SELECT '신인 가수네요. 화이팅 하세요.' AS '메세지';
	ELSE
		SELECT '고참 가수네요. 수고 하세요' AS '메세지';
	END IF;
END;

CALL ifElse_proc('여자친구');

DROP PROCEDURE IF EXISTS while_proc;

CREATE PROCEDURE while_proc()
BEGIN
	DECLARE hap INT;	-- 합계
	DECLARE num INT;	-- 1 부터 100 까지 증가
	SET hap = 0;	-- 합계 초기화
	SET num = 1;
	
	WHILE(num <= 100) DO 	-- 100 까지 반복
		SET hap = hap + num;
		SET num = num + 1;
	END WHILE;

	SELECT hap AS '1 ~ 100 까지 합계';

END

CALL while_proc();

-- 동적 SQL : SQL 이 고정된 것이 아니라 계속 바뀜

DROP PROCEDURE IF EXISTS dynamic_proc;

CREATE PROCEDURE dynamic_proc(
	IN tableName VARCHAR(20)
)
BEGIN
	SET @sqlQuery = CONCAT('SELECT * FROM ', tableName);
	
	PREPARE myQuery FROM @sqlQuery;
	EXECUTE myQuery;
	DEALLOCATE PREPARE myQuery;
END;

CALL dynamic_proc('member');






