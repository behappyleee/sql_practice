-- CURSOR
-- 커서는 한 행 씩 한 행 씩 처리하는 개념
-- 사용 방법 1) 커서 선언 2) 한 행 씩 처리 3) 커서를 닫음

-- 커서도 프로시져 안에 들어가는 개념임 
-- 커서 선언 하기
DECLARE memberCursor CURSOR FOR SELECT m.mem_number FROM market_db.`member` m;



-- TRIGGER : 자동으로 실행되는 방아쇠가 자동으로 당겨진다고 생각하면 됨
-- 트리거 INSERT UPDATE DELETE 가 발생 EX) 블랙핑크가 탈퇴 시 회원 테이블에서 삭제
-- 어떤 테이블에서 삭제를 위하여 DELETE 가 날라가면 자동으로 실행이 됨
-- TRIGGER 는 이벤트 개념 (트리거는 테이블에 부착함)

USE market_db;

CREATE TABLE IF NOT EXISTS trigger_table (id INT, txt VARCHAR(10));

INSERT INTO trigger_table VALUES(1, '레드벨벳');
INSERT INTO trigger_table VALUES(2, '잇지');
INSERT INTO trigger_table VALUES(3, '블랙핑크');

SELECT * FROM market_db.trigger_table;

DROP TRIGGER IF EXISTS myTrigger;

CREATE TRIGGER myTrigger
	AFTER DELETE 	
	ON trigger_table
	FOR EACH ROW 
BEGIN 
	SET @msg = '가수 그룹이 삭제 됨';
END;

-- 트리거가 작동을 할 시 msg 내용이 update 됨
SET @msg = '';

INSERT INTO trigger_table VALUES(4, '마마무');

SELECT @msg;

UPDATE market_db.trigger_table SET txt = '블핑' WHERE id= 3;

DELETE FROM market_db.trigger_table WHERE id = 4;

-- TRIGGER 가 작동을 하면서 msg 글자가 SET 됨
SELECT @msg;

-- 트리거 활용
-- UPDATE 나 DELETE 가 일어날 시 기록을 남기는 것 도 활용이 가능
CREATE TABLE singer (SELECT mem_id, mem_name, mem_number, addr FROM market_db.`member` m);

SELECT * FROM market_db.singer;

DROP TABLE IF EXISTS backup_singer;

CREATE TABLE backup_singer (
	mem_id CHAR(8) NOT NULL,
	mem_name VARCHAR(10) NOT NULL,
	mem_number INT NOT NULL,
	addr CHAR(2) NOT NULL,
	modType CHAR(2),
	modDate DATE,
	modUser VARCHAR(30)
);

SELECT * FROM market_db.backup_singer;

-- UPDATE 시 작동되는 TRIGGER
DROP TRIGGER IF EXISTS singer_updateTrg;
CREATE TRIGGER singer_updateTrg
	AFTER UPDATE 	
	ON market_db.singer
	FOR EACH ROW 
BEGIN 
	INSERT INTO backup_singer 
	-- OLD TABLE 은 SYSTEM TABLE 임 MYSQL 이 가지고 있음, 날라가기전에 OLD 라는 테이블에 잠시 들어가 있음 (UPDATE 나 DELETE 시 MYSQL 에서 제공) 
	    VALUES (OLD.mem_id, OLD.mem_name, OLD.mem_number, OLD.addr, 
	    '수정', CURDATE(), CURRENT_USER());
END;

-- DELETE 시 작동되는 TRIGGER
DROP TRIGGER IF EXISTS singer_deleteTrg;

CREATE TRIGGER singer_deleteTrg
	AFTER DELETE 	
	ON market_db.singer
	FOR EACH ROW 
BEGIN 
	INSERT INTO backup_singer 
	-- OLD TABLE 은 SYSTEM TABLE 임 MYSQL 이 가지고 있음, 날라가기전에 OLD 라는 테이블에 잠시 들어가 있음 (UPDATE 나 DELETE 시 MYSQL 에서 제공) 
	    VALUES (OLD.mem_id, OLD.mem_name, OLD.mem_number, OLD.addr, 
	    '삭제', CURDATE(), CURRENT_USER());
END;

SELECT * FROM market_db.singer s;
SELECT * FROM market_db.backup_singer;
SELECT * FROM market_db.MEMBER;


UPDATE market_db.singer s SET s.addr = '영국' WHERE s.mem_id = 'BLK';

DELETE FROM market_db.singer WHERE mem_number >= 2;















