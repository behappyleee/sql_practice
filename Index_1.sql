-- INDEX
-- INDEX 개념 : INDEX 는 책에 찾아보기 와 비슷한 개념임 
-- 찾아보기가 있을 때 찾는 거랑 없을 때 찾는 것이 속도 차이가 수백 배 발생할 수 있음
-- INDEX 는 반드시 필요한 것은 아님, 하지만 현실적으로 INDEX 는 반드시 사용하여야 함 (데이터 양이 너무 많기 때문 
-- 너무 많은 데이터를 컴퓨터가 다 뒤지는 것은 속도가 너무 오래 걸림, 찾아보는 것이 SELECT 와 비슷함 

-- 인덱스의 문제점: 인덱스는 적절히 사용할 시 에는 많은 도움이 되지만 너무 많이 사용할 시에는 SELECT 사용시에는 더 오래걸리고 문제가 생길 수 있음
-- INDEX 의 장점 : 엄청나게 빠르게 찾음, 전반적인 컴퓨터 시스템이 빨라짐, SELECT 문 속도가 엄청나게 빨라짐 
-- INDEX 의 단점 : INDEX 가 공간도 차지하게 됨, 책을 한번 씩 다 스캔 한 다음 만들어 지므로 인덱스 자체를 만드는데 시간이 오래걸림  

-- INDEX 의 종류 : 클러스터형 인덱스 (Cluster INDEX): 영어사전 또는 국어사전 같은 개념, 보조 인덱스: 책 내용이 있고 인덱스가 따로 있음 책의 맨뒤에 따로 있는 찾아보기 같은 개념 

-- 자동으로 생성 되는 인덱스 (PRIMARY KEY) : 자동으로 Cluster 형 INDEX 가 생성이 됨 EX) member 테이블에 mem_id 가 PK 이므로 그 해당 열에 CLUSTER 형 인덱스가 자동생성이 됨
-- CLUSTER 형 인덱스는 영어사전 처럼 자동으로 인덱스 생성시에 자동으로 정렬이 됨 

-- INDEX 가 자동으로 생성이 됨 PRIMARY 지정 시 - Cluster 형 인덱스가 생성
-- 보조 인덱스는  UNIQUE 지정 시 보조인덱스 자동 생성이 됨, Cluster 형 인덱스는 테이블당 1개만 생성이 됨 

SELECT * FROM market_db.member m ;	-- SELECT 결과를 보면 PK mem_id 가 정렬되어 조회가 됨, Cluster 형 INDEX 가 자동으로 생성되어 정렬이되어 조회가 됨

USE market_db;

CREATE TABLE table1 (
	col1 INT PRIMARY KEY, -- PRIMARY KEY 지정 시 자동으로 Cluster 형 INDEX 가 생성이 됨 
	col2 INT,
	col3 INT
)
SHOW INDEX FROM table1; -- key_name 에 PRIMARY 가 기입 되어있음 Cluster 형 INDEX 임 

CREATE TABLE table2 (
	col1 INT PRIMARY KEY,
	col2 INT UNIQUE,
	col3 INT UNIQUE
)
SHOW INDEX FROM table2;	-- INDEX 가 3개 생김 UNIQUE 때문에 col2, col3 는 보조 인덱스가 생성이 됨

-- Cluster 형 INDEX 를 만드는 순간 Cluster 형 index 로 정렬이 됨

CREATE TABLE member_index (
	mem_id CHAR(8),
	mem_name VARCHAR(10),
	mem_number INT,
	addr CHAR(2)
);

SELECT * FROM member_index;

INSERT INTO market_db.member_index  VALUES('TWC', '트와이스', 9, '서울');
INSERT INTO market_db.member_index  VALUES('BLK', '블랙핑크', 4, '강남');
INSERT INTO market_db.member_index  VALUES('WMN', '여자친구', 6, '경기');
INSERT INTO market_db.member_index  VALUES('OMY', '오마이걸', 7, '서울');

-- 입력한 순서대로 데이터가 조회 됨 
SELECT * FROM market_db.member_index mi ;

ALTER TABLE market_db.member_index 
	ADD CONSTRAINT PRIMARY KEY (mem_id);

-- PRIMARY KEY 로 지정 시 Cluster 형 INDEX 가 생성이 되면서 mem_id 기준으로 데이터가 정렬이 되어 조회가 됨, cluster 형 index 는 TABLE에 하나만 지정이 가능 
SELECT * FROM market_db.member_index mi;

-- 기본 키 제거
ALTER TABLE market_db.member_index DROP PRIMARY KEY;

ALTER TABLE market_db.member_index 
	ADD CONSTRAINT PRIMARY KEY (mem_name);

-- mem_name PRIMARY 키 지정 시 mem_name 데이터 기준으로 정렬이 되어 조회가 됨 
SELECT * FROM market_db.member_index mi;

INSERT INTO market_db.member_index VALUES('GRL', '소녀시대', 8, '서울');
-- mem_name 데이터 기준으로 정렬이 되어 조회가 됨 Cluster 형 INDEX 기준으로 데이터가 정렬이 됨 
SELECT * FROM market_db.member_index mi;

-- 보조 인덱스 (UNIQUE KEY 같이 설정 시 보조 인덱스가 생성이 됨 ) : 책에 내용은 그대로 유지 되면서 따로 뒤에 찾아보기가 만들어짐 , 보조인덱스므로 보조인덱스 기준으로 데이터가 정렬이 될 수는 없음 
CREATE TABLE member_assistIndex(
	mem_id CHAR(8),
	mem_name VARCHAR(10),
	mem_number INT,
	addr CHAR(2)
);

INSERT INTO market_db.member_assistIndex  VALUES('TWC', '트와이스', 9, '서울');
INSERT INTO market_db.member_assistIndex  VALUES('BLK', '블랙핑크', 4, '강남');
INSERT INTO market_db.member_assistIndex  VALUES('WMN', '여자친구', 6, '경기');
INSERT INTO market_db.member_assistIndex  VALUES('OMY', '오마이걸', 7, '서울');

-- mem_id 열에 PRIMARY KEY 가 아닌 UNIQUE KEY 를 만듦
ALTER TABLE market_db.member_assistindex 
	ADD CONSTRAINT UNIQUE(mem_id);

-- 데이터 정렬 조회가 바뀌지는 않음 PRIMARY KEY Cluster 형이 아니라 보조 인덱스 개념이 므로 UNIQUE KEY 설정은 
SELECT * FROM market_db.member_assistindex ma ;


























