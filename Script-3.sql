DROP DATABASE IF EXISTS market_db; -- ���� market_db�� �����ϸ� �켱 �����Ѵ�.
CREATE DATABASE market_db;

USE market_db;
CREATE TABLE member -- ȸ�� ���̺�
( mem_id  		CHAR(8) NOT NULL PRIMARY KEY, -- ����� ���̵�(PK)
  mem_name    	VARCHAR(10) NOT NULL, -- �̸�
  mem_number    INT NOT NULL,  -- �ο���
  addr	  		CHAR(2) NOT NULL, -- ����(���,����,�泲 ������ 2���ڸ��Է�)
  phone1		CHAR(3), -- ����ó�� ����(02, 031, 055 ��)
  phone2		CHAR(8), -- ����ó�� ������ ��ȭ��ȣ(����������)
  height    	SMALLINT,  -- ��� Ű
  debut_date	DATE  -- ���� ����
);
CREATE TABLE buy -- ���� ���̺�
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- ����(PK)
   mem_id  	CHAR(8) NOT NULL, -- ���̵�(FK)
   prod_name 	CHAR(6) NOT NULL, --  ��ǰ�̸�
   group_name 	CHAR(4)  , -- �з�
   price     	INT  NOT NULL, -- ����
   amount    	SMALLINT  NOT NULL, -- ����
   FOREIGN KEY (mem_id) REFERENCES member(mem_id)
);

INSERT INTO member VALUES('TWC', 'Ʈ���̽�', 9, '����', '02', '11111111', 167, '2015.10.19');
INSERT INTO member VALUES('BLK', '������ũ', 4, '�泲', '055', '22222222', 163, '2016.08.08');
INSERT INTO member VALUES('WMN', '����ģ��', 6, '���', '031', '33333333', 166, '2015.01.15');
INSERT INTO member VALUES('OMY', '�����̰�', 7, '����', NULL, NULL, 160, '2015.04.21');
INSERT INTO member VALUES('GRL', '�ҳ�ô�', 8, '����', '02', '44444444', 168, '2007.08.02');
INSERT INTO member VALUES('ITZ', '����', 5, '�泲', NULL, NULL, 167, '2019.02.12');
INSERT INTO member VALUES('RED', '���座��', 4, '���', '054', '55555555', 161, '2014.08.01');
INSERT INTO member VALUES('APN', '������ũ', 6, '���', '031', '77777777', 164, '2011.02.10');
INSERT INTO member VALUES('SPC', '���ּҳ�', 13, '����', '02', '88888888', 162, '2016.02.25');
INSERT INTO member VALUES('MMU', '������', 4, '����', '061', '99999999', 165, '2014.06.19');

INSERT INTO buy VALUES(NULL, 'BLK', '����', NULL, 30, 2);
INSERT INTO buy VALUES(NULL, 'BLK', '�ƺ�����', '������', 1000, 1);
INSERT INTO buy VALUES(NULL, 'APN', '������', '������', 200, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '������', '������', 200, 5);
INSERT INTO buy VALUES(NULL, 'BLK', 'û����', '�м�', 50, 3);
INSERT INTO buy VALUES(NULL, 'MMU', '������', '������', 80, 10);
INSERT INTO buy VALUES(NULL, 'GRL', 'ȥ��SQL', '����', 15, 5);
INSERT INTO buy VALUES(NULL, 'APN', 'ȥ��SQL', '����', 15, 2);
INSERT INTO buy VALUES(NULL, 'APN', 'û����', '�м�', 50, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '����', NULL, 30, 1);
INSERT INTO buy VALUES(NULL, 'APN', 'ȥ��SQL', '����', 15, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '����', NULL, 30, 4);

SELECT * FROM member;
SELECT * FROM buy;