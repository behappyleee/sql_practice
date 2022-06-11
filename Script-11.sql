-- 제약 조건은 테이블을 견고하게 만들어 줌
-- 데이터가 오나전 무결할 수 있도록 도와줌
-- 제약조건 종류 (기본키, 외래키, 유니크 키 (고유키), 체크 키, DEFAULT 정의, NOT NULL ...)
-- MySQL 은 기본적으로 제약조건 6가지를 제공함

-- 기본 키 : 데이터를 구별할 수 있는 키 (UNIQUE, NOT NULL)
-- 기본키로 생성한 것은 CLUSTER INDEX 가 생성이 됨, 테이블에는 기본적으로 1개의 기본키만 가능

USE naver_db;
-- TABLE 생성 
DROP TABLE IF EXISTS buy, naver_db.`member`;
CREATE TABLE `member` (
	mem_id CHAR(8) NOT NULL PRIMARY KEY,
	mem_name VARCHAR(10) NOT NULL,
	height TINYINT UNSIGNED NULL
)
SELECT * FROM naver_db.`member` m;

-- 외래 키 제약 조건 (FK - Foreign Key)
-- 두 테이블의 관계를 연결시켜 줌 ex)회원 테이블, 구매 테이블 구매 테이블에서 없는 회원이 구매 하였을 시 에러가 발생 
-- 외래 키 설정 하였을 시 다른 테이블에 키가 반드시 존재하여야 함 

CREATE TABLE buy (
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	user_id CHAR(8) NOT NULL,
	prod_name CHAR(6) NOT NULL
);

SELECT * FROM naver_db.buy b;

-- 가능하면 PK, FK 열 이름을 동일하게 설정해야 함 
DROP TABLE IF EXISTS buy;

CREATE TABLE buy (
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	mem_id CHAR(8) NOT NULL,
	prod_name CHAR(6) NOT NULL,
	FOREIGN KEY(mem_id) REFERENCES member(mem_id)
);

-- 기존 테이블에 열이 변경하는 경우
SELECT m.mem_id, m.mem_name FROM naver_db.buy b INNER JOIN naver_db.`member` m ON b.mem_id = m.mem_id ; 

-- PK FK 관계를 맺어야 데이터 무결성에 도움이 많이 됨 (FK 관계인 부모 테이블에 데이터가 존재하여야 INSERT 가 됨)
INSERT INTO `member` VALUES('BLK', '블랙핑크', 163);
INSERT INTO buy  VALUES(NULL, 'BLK', '지갑');
INSERT INTO buy  VALUES(NULL, 'BLK', '맥북');

SELECT * FROM `member` m ;
SELECT * FROM buy b ;

-- DELETE 시도일 시  a foreign key constraint fails 에러가 발생, FOreignKey 가 존재하여 삭제가 불가능함 데이터 무결성을 보장
DELETE FROM `member` WHERE mem_id = 'BLK';

-- 테이블 생성 시 ON CASACADE 옵션을 지정 시 자동으로 FK 에 딸려 있는 데이터들이 자동으로 바뀜

DROP TABLE IF EXISTS buy;
CREATE TABLE buy (
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	mem_id CHAR(8) NOT NULL,
	prod_name CHAR(6) NOT NULL
)

SELECT * FROM buy b ;
-- ON CASCADE 옵션 이용 시 UPDATE 시 와 DELETE 시 자동으로 FOREIGN KEY 의 값들도 변함 
ALTER TABLE buy 
	ADD CONSTRAINT FOREIGN KEY(mem_id) REFERENCES member(mem_id)
	ON UPDATE CASCADE 
	ON DELETE CASCADE;

INSERT INTO buy values(NULL, 'BLK', '지갑');
INSERT INTO buy values(NULL, 'BLK', '맥북');
-- member table 에 BLK 를 PINK 로 UPDATE 로 할 시 buy 테이블에 mem_id 의 값도 PINK 로변하게 된다
-- CASCADE 옵션을 주어 member 테이블을 업데이트 하면 자동으로 FOREIGN KEY 값도 변하게 된다
UPDATE naver_db.`member` SET mem_id = 'PINK' WHERE mem_id = 'BLK'; 
SELECT * FROM buy b ;

SELECT m.mem_id, m.mem_name, b.prod_name 
  FROM naver_db.buy b 
INNER JOIN naver_db.`member` m 
        ON b.mem_id = m.mem_id; 

SELECT * FROM buy b;

-- member 테이블에 데이터를 삭제하여도 CASCADE 로 인하여 buy 테이블 데이터도 삭제가 된다
DELETE FROM naver_db.`member` WHERE mem_id = 'PINK';

-- 고유 키 제약 조건
-- EX) member table EMAIL 같은 것들도 고유 키 제약 조건으로 설정 할 수 있음 이메일 중복되는경우가
-- 없기 때문에 mem_id 만큼은 아니지만 기본 키 비슷한 역할을 해줌 
DROP TABLE IF EXISTS buy, naver_db.`member`;
-- 고유 키 제약조건 UNIQUE 설정 시 중복 값이 INSERT 가 되지 않음 
CREATE TABLE `member` (
	mem_id CHAR(8) NOT NULL PRIMARY KEY,
	mem_name VARCHAR(10) NOT NULL,
	height TINYINT UNSIGNED NULL,
	email CHAR(30) NULL UNIQUE
);

SELECT * FROM `member` m;

INSERT INTO `member` VALUES('BLK', '블랙핑크', 163, 'pink@gmail.com');
INSERT INTO `member` VALUES('TWC', '트와이스', 167, NULL);
-- 이메일 UNIQUE KEY 설정 때문에 에러가 발생, 중복 값이 존재하면 안됨
-- INSERT INTO `member` VALUES('APN', '에이핑크', 164, 'pink@gmail.com');
INSERT INTO `member` VALUES('APN', '에이핑크', 164, 'apn@gmail.com');

SELECT * FROM `member` m ;


-- CHECK 제약 조건
-- CHECK 제약 조건은 데이터를 입력 시 어떤 특정 범위만 입력 되게만 가능

DROP TABLE IF EXISTS buy, naver_db.`member`;
 
CREATE TABLE `member` (
	mem_id CHAR(8) NOT NULL PRIMARY KEY,
	mem_name VARCHAR(10) NOT NULL,
	height TINYINT UNSIGNED NULL CHECK (height >= 100),
	phone1 CHAR(3) NULL 
);

SELECT * FROM `member` m ;

INSERT INTO `member` VALUES('BLK', '블랙핑크', 163, NULL);
-- CHECK 제약 조건으로 인하여 100 이하 값 입력 시 에러가 발생
INSERT INTO `member` VALUES('BLK', '블랙핑크', 99, NULL);

-- ALTER TABLE 을 이용하여 제약 조건 설정도 가능
ALTER TABLE `member` ADD CONSTRAINT CHECK 
(phone1 IN ('02', '031', '032', '054', '055', '061'));

INSERT INTO `member`  values('TWC', '트와이스', 167, '02');

-- CHECK 제약 조건으로 인하여 데이터 삽입이 안됨 
INSERT INTO `member`  values('TWC', '트와이스', 167, '077');


DROP TABLE IF EXISTS buy, naver_db.`member`;

-- DEFAULT 제약 조건으로 인하여 아무 값이 입력 되지 않았을 시 160이 입력 되도록 설정
CREATE TABLE `member` (
	mem_id CHAR(8) NOT NULL PRIMARY KEY,
	mem_name VARCHAR(10) NOT NULL,
	height TINYINT UNSIGNED NULL DEFAULT 160,
	phone1 CHAR(3) NULL 
);

-- ALTER TABLE 을 이용하여 제약 조건 설정도 가능
ALTER TABLE `member` ALTER COLUMN phone1
SET DEFAULT '02';

-- 설정해 둔 height, phone1 값이 없기 때문에 DEFAULT 값 이 들어감
INSERT INTO `member` (mem_id, mem_name) values('TWC', '트와이스');

SELECT * FROM `member` m ;





