-- TABLE, VIEW

-- 테이블 만들기 
-- 테이블은 엑셀에 시트와 똑같은 구조임 테이블은 데이터 베이스 안에 들어 있는 개체 같은 개념

-- 네이버 쇼핑 DB 구성도
-- 테이블 만드는 방식은 2가지 CREATE 문 및 GUI 를 이용하여 그냥 클릭하여 만들기

-- 1) 테이블 설계 회원 테이블
-- (1) DB 생성 및 member, buy 테이블 생성

CREATE DATABASE naver_db;
-- DDL 문
CREATE TABLE `member` (
  `mem_id` char(8) NOT NULL,
  `mem_name` varchar(10) NOT NULL,
  `mem_number` tinyint NOT NULL,
  `addr` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone1` char(3) DEFAULT NULL,
  `phone2` char(8) DEFAULT NULL,
  `height` tinyint DEFAULT NULL,
  `debut_date` date DEFAULT NULL,
  PRIMARY KEY (`mem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `buy` (
  `num` int NOT NULL,
  `mem_id` char(8) NOT NULL,
  `prod_name` char(8) NOT NULL,
  `group_name` char(4) DEFAULT NULL,
  `price` int NOT NULL,
  `amount` smallint NOT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE 
	buy 
	ADD FOREIGN KEY (mem_id) REFERENCES `member`(mem_id );

USE naver_db;
SELECT * FROM market_db.`member` m ;

INSERT INTO naver_db.`member` (mem_id, mem_name, mem_number, addr, phone1, phone2, height, debut_date) 
		SELECT 
			mem_id, mem_name, mem_number, addr, phone1, phone2, height, debut_date 
		FROM market_db.`member` WHERE mem_id = 'APN'; 

INSERT INTO naver_db.`member` SELECT * FROM market_db.`member` a WHERE a.mem_id = 'GRL';	
INSERT INTO naver_db.buy SELECT * FROM market_db.buy WHERE ,  	
	
SELECT * FROM naver_db.buy b;

-- 만약 buy 테이블에 값을 입력 시 member 테이블에 없는 mem_id 입력 시 에러가 발생함
-- FOREIGN KEY 는 반드시 부모테이블에 존재하여야 함 (안그러면 에러가 발생)













