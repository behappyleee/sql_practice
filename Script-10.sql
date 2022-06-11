-- TABLE, VIEW

-- ���̺� ����� 
-- ���̺��� ������ ��Ʈ�� �Ȱ��� ������ ���̺��� ������ ���̽� �ȿ� ��� �ִ� ��ü ���� ����

-- ���̹� ���� DB ������
-- ���̺� ����� ����� 2���� CREATE �� �� GUI �� �̿��Ͽ� �׳� Ŭ���Ͽ� �����

-- 1) ���̺� ���� ȸ�� ���̺�
-- (1) DB ���� �� member, buy ���̺� ����

CREATE DATABASE naver_db;
-- DDL ��
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

-- ���� buy ���̺� ���� �Է� �� member ���̺� ���� mem_id �Է� �� ������ �߻���
-- FOREIGN KEY �� �ݵ�� �θ����̺� �����Ͽ��� �� (�ȱ׷��� ������ �߻�)













