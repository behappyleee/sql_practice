-- JOIN (두 개의 테이블을 묶음)

-- 내부 조인 (그냥 조인이라 하면 내부 조인이라 생각하면 됨)
-- 기본키(PK)와 외래키(FK)가 엮어져 있어야 함 
-- 일대다 관계 (one to many) 
-- 일대 다 관계 : 만약 회원(member)이 구매(buy)를 하였을 시 데이터가 buy 테이블에 쌓임 그러면 회원 id  가 여러개 쌓이므로 일대다 관계 형성 (회원 테이블에는 member_id 가 한개)
use market_db;

select * from market_db.`member` m;
select * from market_db.buy;

-- 문법 SELECT <열 목록> FROM 첫 테이블 INNER JOIN 두번째 테이블 ON 조인할 조건 WHERE 검색 조건

select * from buy b 
	 inner join `member` m 
			 ON b.mem_id = m.mem_id 
		  where b.mem_id = 'GRL';

-- WHERE 조건 없어도 됨 
SELECT * FROM buy b INNER JOIN `member` m ON b.MEM_ID = m.MEM_ID;

-- 구매 테이블을 기준으로 잡음 
SELECT b.mem_id, m.mem_name, b.prod_name, m.addr, CONCAT(phone1, phone2) AS '연락처'
FROM buy b INNER JOIN `member` m ON b.mem_id = m.mem_id;

-- 외부 조인 : 내부조인에 한계점은 구매를 한 회원들만 회원 정보만 조회가 됨
-- 외부 조인은 구매한 데이터가 없어도 데이터가 조회, 한 쪽에만 있는 데이터 들도 조회가 가능

-- LEFT OUTER JOIN 왼쪽 테이블 기준으로 데이터가 모두 조회 하도록 조회
SELECT m.mem_id, m.mem_name, b.prod_name, m.addr  
  FROM market_db.`member` m
LEFT OUTER JOIN market_db.buy b 
		ON m.mem_id = b.mem_id
	ORDER BY m.mem_id;

-- RIGHT OUTER JOIN 오른쪽 테이블 기준으로 데이터가 모두 조회 하도록 조회
SELECT m.mem_id, m.mem_name, b.prod_name, m.addr  
  FROM market_db.buy b
LEFT OUTER JOIN market_db.`member` m  
		ON m.mem_id = b.mem_id
	ORDER BY m.mem_id;


-- 상호 조인 (CROSS JOIN) - 내용의 의미는 없지만 대용량 데이터 만들기 원할 시 사용
-- 조건은 없고 전부다 조인이 됨 (테스트 용으로 대용량 샘플 데이터 원할 시 주로 사용)
SELECT * FROM market_db.buy b CROSS JOIN market_db.`member` m ;

SELECT COUNT(*) '데이터 갯수' FROM sakila.inventory i 
CROSS JOIN world.city c;

CREATE TABLE cross_table 
SELECT * FROM sakila.actor a CROSS JOIN world.country c;

SELECT * FROM cross_table;

SELECT * FROM cross_table LIMIT5;
	 
-- SELF JOIN (자기자신과 자기자신이 조인 되는 경우) --> 테이블이 다르다고 생각 하고 JOIN 하는 것이 편함 
-- 자체 조인의 형식은 테이블의 별칭을 반드시 다르게 주어야 함 

USE market_db;		 

CREATE TABLE emp_table (emp CHAR(4), manager CHAR(4), phone VARCHAR(8));

INSERT INTO emp_table VALUES('대표', NULL, '0000');
INSERT INTO emp_table VALUES('영업이사', '대표', '1111');
INSERT INTO emp_table VALUES('관리이사', '대표', '2222');
INSERT INTO emp_table VALUES('정보이사', '대표', '3333');
INSERT INTO emp_table VALUES('영업과장', '영업이사', '1111-1');
INSERT INTO emp_table VALUES('경리부장', '관리이사', '2222-1');
INSERT INTO emp_table VALUES('인사부장', '관리이사', '2222-2');
INSERT INTO emp_table VALUES('개발팀장', '정보이사', '3333-1');
INSERT INTO emp_table VALUES('개발주임', '정보이사', '3333-1-1');	

SELECT * FROM emp_table;

SELECT a.phone FROM emp_table a INNER JOIN emp_table b ON a.manager = b.emp; 





