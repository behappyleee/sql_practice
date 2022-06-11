-- 가상의 테이블 (View) -- 실체가 없음, 실제 테이블에 연결해 놓은 것 같은 개념
-- 데이터 베이스 개체 중 하나 view 의 핵심은 바로가기 아이콘 더블 클릭 처럼
-- 진짜 실제가 있는 것이 아니라 편하게 조회 하기 위하여 만들어 놓은 개념
-- VIEW 에는 진짜 데이터가 없고 SELECT 문 만 있음
USE market_db;

-- 뷰 생성 문법
-- CREATE VIEW 뷰_이름 AS SELECT 문;

SELECT * FROM market_db.`member` m ;

-- 실제로 view 라고 구분 위하여 앞에 v_ 를 붙여주는 것이 좋음
CREATE VIEW v_member
AS 	
	SELECT mem_id, mem_name, addr FROM market_db.`member` m ;

-- v_member view 를 조회를 가능
SELECT * FROM market_db.v_member;

-- VIEW 에서 WHERE 문 으로도 접근이 가능
SELECT mem_name, addr FROM v_member
	WHERE addr IN('서울', '경기');
-- VIEW 사용 이우
-- VIEW 를 사용하는 이유는 보안에 많은 도움이 됨
-- 테이블에 주요 컬럼을 제외 하고 조회를 시킬 수 있음
-- 복잡한 쿼리도 간단하게 접근이 가능

CREATE VIEW v_memberbuy
AS 
	SELECT b.mem_id, m.mem_name, b.prod_name, m.addr,
		CONCAT (m.phone1, m.phone2) '연락처'
		FROM market_db.buy b 
		INNER JOIN market_db.`member` m 
			ON b.mem_id = m.mem_id; 
		
SELECT * FROM v_memberbuy WHERE mem_name = '블랙핑크';

-- 뷰의 실제 작동
-- 뷰를 만들 시 Alias 사용 가능 

USE market_db;

CREATE VIEW v_viewtest1
AS
	SELECT 
	  b.mem_id AS 'Member ID'
	, m.mem_name AS 'Member Name'
	, b.prod_name AS 'Product Name'
	, CONCAT(m.phone1, m.phone2) AS 'Office Phone'
FROM market_db.buy b 
	INNER JOIN market_db.`member` m 
		ON b.mem_id = m.mem_id ;

-- AS 에 띄워쓰기가 존재 할 시에는 백틱을 사용하여 조회
SELECT DISTINCT `Member ID`, `Member Name` FROM v_viewtest1;	

-- view 수정 원할 시에는 ALTER VIEW 를 사용
ALTER VIEW v_viewtest1 
AS 
	SELECT 
	  b.mem_id AS '회원 아이디'
	, m.mem_name AS '회원 이름'
	, b.prod_name AS '상품 이름'
	, CONCAT(m.phone1, m.phone2) AS '연락처'
		FROM market_db.buy b 
	INNER JOIN market_db.`member` m 
		ON b.mem_id = m.mem_id ;

SELECT DISTINCT `회원 아이디`, `회원 이름` FROM v_viewtest1;

-- VIEW 삭제 문
DROP VIEW v_viewtest1;

CREATE OR REPLACE VIEW v_viewtest2
AS
	SELECT mem_id, mem_name, addr FROM market_db.`member` m ;

-- DESCRIBE 사용 시 v_viewtest2 에 내용들이 보임 (key .. primary key 등 key 내용은 보이지 않음)
DESCRIBE v_viewtest2;

-- view 를 통하여 데이터 업데이트 하기 
UPDATE v_member SET addr = '부산' WHERE mem_id = 'BLK';

SELECT * FROM v_member;

SELECT * FROM market_db.`member` m ;

-- INSERT 문은 입력이 안됨 (실제 테이블에는 NOT NULL 인 컬럼이 있기에 VIEW 를 통하여 데이터를 입력이 되기도 하지만 권장 하지는 안흠)
-- 실제 테이블에는 컬럼에 NOT NULL 조건이 있기에 VIEW 에 모든 컬럼이 없을 수 있음 그렇기에 데이터가 입력이 될수도 있고 없을수도있음
INSERT INTO v_member(mem_id, mem_name, addr) 
VALUES ('BTS', '방탄소년단', '경기');

DESCRIBE market_db.`member`;

--  height 가 167 인 이상인 멤버들만 조회하는 view 를 생성
CREATE VIEW v_height167
	AS
		SELECT * FROM market_db.`member` m WHERE m.height >= 167;

SELECT * FROM v_height167;	

-- VIEW 에서 DELETE 문을 사용할 수도 있지만 권장 사항은 아님 해당 DELETE 문은 167인 이상인 사람들만 있기에 삭제할 데이터가 없음 
DELETE FROM v_height167 WHERE height < 167;

-- 데이터가 입력은 되지만 view 에서 확인은 불가능 키가 159 기에 바람직하지는 않음 권장 사항은 아님 
INSERT INTO v_height167 
VALUES ('TRA', '티아라', 6, '서울', NULL, NULL, 159, '2005-06-01');

SELECT * FROM v_height167 ;

-- WITH OPTION CHECK 사용 시 (사용하는 것이 훨씬 안전- VIEW 에 해당하는 조건 데이터만 입력이 가능)해당 DATA CHECK 가 가능
ALTER VIEW v_height167 
	AS
		SELECT * FROM market_db.`member` m WHERE m.height >= 167
		WITH CHECK OPTION;

-- 제약 조건을 걸었기에 입력이 안됨 (WITH CHECK OPTION 을 통하여 167 미만은 입력이 안되게 설정 하였음)	
INSERT INTO v_height167 
VALUES ('TOB', '테레토비', 4, '영국', NULL, NULL, 159, '2005-06-01');
	
-- VIEW 가 참조하고 있다고 테이블이 삭제 안되지는 않음 VIEW 가 참조 상관없이  TABLE 은 삭제가 가능
SELECT * FROM market_db.`member_1` m ;

INSERT INTO market_db.member_1 
SELECT * FROM market_db.`member`;

INSERT INTO market_db.buy_1 
SELECT * FROM market_db.buy;

DROP TABLE IF EXISTS market_db.buy, market_db.MEMBER;

-- TABLE 을 DROP 삭제하였기에 데이터 조회가 안됨
SELECT * FROM v_height167;

-- CHECK TABLE 문을 통하여 VIEW 가 참조하고 있는 TABLE 에 상태를 확인이 가능
CHECK TABLE v_height167;
	







		
		