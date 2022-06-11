-- ���� ������ ���̺��� �߰��ϰ� ����� ��
-- �����Ͱ� ������ ������ �� �ֵ��� ������
-- �������� ���� (�⺻Ű, �ܷ�Ű, ����ũ Ű (����Ű), üũ Ű, DEFAULT ����, NOT NULL ...)
-- MySQL �� �⺻������ �������� 6������ ������

-- �⺻ Ű : �����͸� ������ �� �ִ� Ű (UNIQUE, NOT NULL)
-- �⺻Ű�� ������ ���� CLUSTER INDEX �� ������ ��, ���̺��� �⺻������ 1���� �⺻Ű�� ����

USE naver_db;
-- TABLE ���� 
DROP TABLE IF EXISTS buy, naver_db.`member`;
CREATE TABLE `member` (
	mem_id CHAR(8) NOT NULL PRIMARY KEY,
	mem_name VARCHAR(10) NOT NULL,
	height TINYINT UNSIGNED NULL
)
SELECT * FROM naver_db.`member` m;

-- �ܷ� Ű ���� ���� (FK - Foreign Key)
-- �� ���̺��� ���踦 ������� �� ex)ȸ�� ���̺�, ���� ���̺� ���� ���̺��� ���� ȸ���� ���� �Ͽ��� �� ������ �߻� 
-- �ܷ� Ű ���� �Ͽ��� �� �ٸ� ���̺� Ű�� �ݵ�� �����Ͽ��� �� 

CREATE TABLE buy (
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	user_id CHAR(8) NOT NULL,
	prod_name CHAR(6) NOT NULL
);

SELECT * FROM naver_db.buy b;

-- �����ϸ� PK, FK �� �̸��� �����ϰ� �����ؾ� �� 
DROP TABLE IF EXISTS buy;

CREATE TABLE buy (
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	mem_id CHAR(8) NOT NULL,
	prod_name CHAR(6) NOT NULL,
	FOREIGN KEY(mem_id) REFERENCES member(mem_id)
);

-- ���� ���̺� ���� �����ϴ� ���
SELECT m.mem_id, m.mem_name FROM naver_db.buy b INNER JOIN naver_db.`member` m ON b.mem_id = m.mem_id ; 

-- PK FK ���踦 �ξ�� ������ ���Ἲ�� ������ ���� �� (FK ������ �θ� ���̺� �����Ͱ� �����Ͽ��� INSERT �� ��)
INSERT INTO `member` VALUES('BLK', '����ũ', 163);
INSERT INTO buy  VALUES(NULL, 'BLK', '����');
INSERT INTO buy  VALUES(NULL, 'BLK', '�ƺ�');

SELECT * FROM `member` m ;
SELECT * FROM buy b ;

-- DELETE �õ��� ��  a foreign key constraint fails ������ �߻�, FOreignKey �� �����Ͽ� ������ �Ұ����� ������ ���Ἲ�� ����
DELETE FROM `member` WHERE mem_id = 'BLK';

-- ���̺� ���� �� ON CASACADE �ɼ��� ���� �� �ڵ����� FK �� ���� �ִ� �����͵��� �ڵ����� �ٲ�

DROP TABLE IF EXISTS buy;
CREATE TABLE buy (
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	mem_id CHAR(8) NOT NULL,
	prod_name CHAR(6) NOT NULL
)

SELECT * FROM buy b ;
-- ON CASCADE �ɼ� �̿� �� UPDATE �� �� DELETE �� �ڵ����� FOREIGN KEY �� ���鵵 ���� 
ALTER TABLE buy 
	ADD CONSTRAINT FOREIGN KEY(mem_id) REFERENCES member(mem_id)
	ON UPDATE CASCADE 
	ON DELETE CASCADE;

INSERT INTO buy values(NULL, 'BLK', '����');
INSERT INTO buy values(NULL, 'BLK', '�ƺ�');
-- member table �� BLK �� PINK �� UPDATE �� �� �� buy ���̺� mem_id �� ���� PINK �κ��ϰ� �ȴ�
-- CASCADE �ɼ��� �־� member ���̺��� ������Ʈ �ϸ� �ڵ����� FOREIGN KEY ���� ���ϰ� �ȴ�
UPDATE naver_db.`member` SET mem_id = 'PINK' WHERE mem_id = 'BLK'; 
SELECT * FROM buy b ;

SELECT m.mem_id, m.mem_name, b.prod_name 
  FROM naver_db.buy b 
INNER JOIN naver_db.`member` m 
        ON b.mem_id = m.mem_id; 

SELECT * FROM buy b;

-- member ���̺� �����͸� �����Ͽ��� CASCADE �� ���Ͽ� buy ���̺� �����͵� ������ �ȴ�
DELETE FROM naver_db.`member` WHERE mem_id = 'PINK';

-- ���� Ű ���� ����
-- EX) member table EMAIL ���� �͵鵵 ���� Ű ���� �������� ���� �� �� ���� �̸��� �ߺ��Ǵ°�찡
-- ���� ������ mem_id ��ŭ�� �ƴ����� �⺻ Ű ����� ������ ���� 
DROP TABLE IF EXISTS buy, naver_db.`member`;
-- ���� Ű �������� UNIQUE ���� �� �ߺ� ���� INSERT �� ���� ���� 
CREATE TABLE `member` (
	mem_id CHAR(8) NOT NULL PRIMARY KEY,
	mem_name VARCHAR(10) NOT NULL,
	height TINYINT UNSIGNED NULL,
	email CHAR(30) NULL UNIQUE
);

SELECT * FROM `member` m;

INSERT INTO `member` VALUES('BLK', '����ũ', 163, 'pink@gmail.com');
INSERT INTO `member` VALUES('TWC', 'Ʈ���̽�', 167, NULL);
-- �̸��� UNIQUE KEY ���� ������ ������ �߻�, �ߺ� ���� �����ϸ� �ȵ�
-- INSERT INTO `member` VALUES('APN', '������ũ', 164, 'pink@gmail.com');
INSERT INTO `member` VALUES('APN', '������ũ', 164, 'apn@gmail.com');

SELECT * FROM `member` m ;


-- CHECK ���� ����
-- CHECK ���� ������ �����͸� �Է� �� � Ư�� ������ �Է� �ǰԸ� ����

DROP TABLE IF EXISTS buy, naver_db.`member`;
 
CREATE TABLE `member` (
	mem_id CHAR(8) NOT NULL PRIMARY KEY,
	mem_name VARCHAR(10) NOT NULL,
	height TINYINT UNSIGNED NULL CHECK (height >= 100),
	phone1 CHAR(3) NULL 
);

SELECT * FROM `member` m ;

INSERT INTO `member` VALUES('BLK', '����ũ', 163, NULL);
-- CHECK ���� �������� ���Ͽ� 100 ���� �� �Է� �� ������ �߻�
INSERT INTO `member` VALUES('BLK', '����ũ', 99, NULL);

-- ALTER TABLE �� �̿��Ͽ� ���� ���� ������ ����
ALTER TABLE `member` ADD CONSTRAINT CHECK 
(phone1 IN ('02', '031', '032', '054', '055', '061'));

INSERT INTO `member`  values('TWC', 'Ʈ���̽�', 167, '02');

-- CHECK ���� �������� ���Ͽ� ������ ������ �ȵ� 
INSERT INTO `member`  values('TWC', 'Ʈ���̽�', 167, '077');


DROP TABLE IF EXISTS buy, naver_db.`member`;

-- DEFAULT ���� �������� ���Ͽ� �ƹ� ���� �Է� ���� �ʾ��� �� 160�� �Է� �ǵ��� ����
CREATE TABLE `member` (
	mem_id CHAR(8) NOT NULL PRIMARY KEY,
	mem_name VARCHAR(10) NOT NULL,
	height TINYINT UNSIGNED NULL DEFAULT 160,
	phone1 CHAR(3) NULL 
);

-- ALTER TABLE �� �̿��Ͽ� ���� ���� ������ ����
ALTER TABLE `member` ALTER COLUMN phone1
SET DEFAULT '02';

-- ������ �� height, phone1 ���� ���� ������ DEFAULT �� �� ��
INSERT INTO `member` (mem_id, mem_name) values('TWC', 'Ʈ���̽�');

SELECT * FROM `member` m ;





