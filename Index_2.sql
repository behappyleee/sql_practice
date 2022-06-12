-- INDEX의 내부 작동

-- TREE, 뿌리 (ROOT) / 중간 / 잎 Leaf --> TREE 구조
-- 균형 트리 : Node - 데이터가 저장이 되는 공간, MySQL 에서는 Node 를 페이지라고 부름 

-- 책에 뒤에 찾아보기가 없음, INDEX 가 방법이 없음 그냥 첫번째 페이지 부터 찾음  
-- 일반적으로 index 가 없는 상태에서는 첫번째 페이지 부터 찾음 (Full Page Scan 이라고도 함 --> 굉장히 안좋음 데이터 1건을 찾기 위하여 모든 페이지를 찾는 격)

-- INDEX 를 생성 시 Full Page Scan 을 피할 수 있음
-- ROOT PAGE 를 추가 (각 페이지 맨 위에 있는 것 들만 모아 놓은 페이지임)

-- INDEX 가 있던 없던 데이터를 찾은 결과는 똑같음 
-- 균형 트리의 페이지 분할, INDEX 는 SELECT 는 빠르지만 INSERT DELETE UPDATE 는 더 느려짐 (페이지 분할 떄문에 그럼)

-- 페이지 분할이 일어날 시 에는 굉장히 느려짐
-- 똑같이 1건을 입력을 하였더라도 페이지 분할 이 많이 일어나면 속도가 굉장히 느려짐 
-- 입력 건 수 보다는 페이지 분할 떄문에 속도가 저하 됨 

-- Index 종류 : Cluster 형 인덱스, 보조 인덱스 

USE market_db;
CREATE TABLE cluster (
	mem_id CHAR(8),
	mem_name VARCHAR(10)
);

SELECT * FROM market_db.cluster;

INSERT INTO market_db.cluster VALUES ('TWC', '트와이스');
INSERT INTO market_db.cluster VALUES ('BLK', '블랙핑크');
INSERT INTO market_db.cluster VALUES ('WMN', '여자친구');
INSERT INTO market_db.cluster VALUES ('OMY', '오마이걸');
INSERT INTO market_db.cluster VALUES ('GRL', '소녀시대');
INSERT INTO market_db.cluster VALUES ('ITZ', '잇지');
INSERT INTO market_db.cluster VALUES ('RED', '레드벨벳');
INSERT INTO market_db.cluster VALUES ('APN', '에이핑크');
INSERT INTO market_db.cluster VALUES ('SPC', '우주소녀');
INSERT INTO market_db.cluster VALUES ('MMU', '마마무');

SELECT * FROM cluster;

ALTER TABLE market_db.cluster
	ADD CONSTRAINT PRIMARY KEY (mem_id);

USE market_db;

-- 지금은 아까 DATA 입력 시 그냥 하나하나 쌓엿지만
-- PRIMARY KEY 설정 후 DATE 입력 이 mem_id 기준이 쌓임 데이터가 정렬이 됨
-- ROOT PAGE 로 각 PRIMARY 키 값들이 들어가고 페이지가 만들어짐

USE market_db;

CREATE TABLE market_db.second (
	mem_id CHAR(8),
	mem_name VARCHAR(10)
);

SELECT * FROM market_db.SECOND;

INSERT INTO market_db.SECOND VALUES('TWC', '트와이스');
INSERT INTO market_db.SECOND VALUES('BLK', '블랙핑크');
INSERT INTO market_db.SECOND VALUES('WMN', '여자친구');
INSERT INTO market_db.SECOND VALUES('OMY', '오마이걸');
INSERT INTO market_db.SECOND VALUES('GRL', '소녀시대');
INSERT INTO market_db.SECOND VALUES('ITZ', '잇지');
INSERT INTO market_db.SECOND VALUES('RED', '레드벨벳');
INSERT INTO market_db.SECOND VALUES('APN', '에이핑크');
INSERT INTO market_db.SECOND VALUES('SPC', '우주소녀');
INSERT INTO market_db.SECOND VALUES('MMU', '마마무');

SELECT * FROM market_db.SECOND;

-- 보조 INDEX 생성 
ALTER TABLE market_db.SECOND 
	ADD CONSTRAINT UNIQUE (mem_id);

-- 보조 INDEX 만 생성을 하였으므로 데이터 조회 출력 순서는 바뀌지 않음 
SELECT * FROM market_db.SECOND;

-- 데이터 Page 는 그대로 있고 찾아보기가 만들어 짐 (ROOT 페이지가 새롭게 만들어 짐 )
-- 내부 적 으로 작동은 이런식으로 작동이 되고 있음 
-- 데이터 검색 시 에는 SPC 라는 데이터를 찾을 시

-- CLUSTER 형 INDEX 는 알파벳 전체가 인덱스라고 생각하면 됨
-- 1) 루트 페이지에서 해당 데이터가 속하는 페이지를 찾은 뒤
-- 2) 리프 페이지에서 해당 데이터를 찾아 냄 (Cluster 형 index 에서 데이터를 조회 및 찾을 시)
SELECT * FROM market_db.SECOND WHERE mem_id ='SPC' ;

-- 보조 인덱스에서 데이터 찾기
-- CLUSTER 형 INDEX 는 2페이지를 검색해서 데이터를 알아내고, 보조 INDEX 는 3 페이지를 찾아내어 데이터를 찾아냄
-- CLUSTER 형이 보조형 INDEX 보다 효율 적임 







