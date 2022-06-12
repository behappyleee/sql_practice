-- INDEX
-- INDEX ���� : INDEX �� å�� ã�ƺ��� �� ����� ������ 
-- ã�ƺ��Ⱑ ���� �� ã�� �Ŷ� ���� �� ã�� ���� �ӵ� ���̰� ���� �� �߻��� �� ����
-- INDEX �� �ݵ�� �ʿ��� ���� �ƴ�, ������ ���������� INDEX �� �ݵ�� ����Ͽ��� �� (������ ���� �ʹ� ���� ���� 
-- �ʹ� ���� �����͸� ��ǻ�Ͱ� �� ������ ���� �ӵ��� �ʹ� ���� �ɸ�, ã�ƺ��� ���� SELECT �� ����� 

-- �ε����� ������: �ε����� ������ ����� �� ���� ���� ������ ������ �ʹ� ���� ����� �ÿ��� SELECT ���ÿ��� �� �����ɸ��� ������ ���� �� ����
-- INDEX �� ���� : ��û���� ������ ã��, �������� ��ǻ�� �ý����� ������, SELECT �� �ӵ��� ��û���� ������ 
-- INDEX �� ���� : INDEX �� ������ �����ϰ� ��, å�� �ѹ� �� �� ��ĵ �� ���� ����� ���Ƿ� �ε��� ��ü�� ����µ� �ð��� �����ɸ�  

-- INDEX �� ���� : Ŭ�������� �ε��� (Cluster INDEX): ������� �Ǵ� ������� ���� ����, ���� �ε���: å ������ �ְ� �ε����� ���� ���� å�� �ǵڿ� ���� �ִ� ã�ƺ��� ���� ���� 

-- �ڵ����� ���� �Ǵ� �ε��� (PRIMARY KEY) : �ڵ����� Cluster �� INDEX �� ������ �� EX) member ���̺� mem_id �� PK �̹Ƿ� �� �ش� ���� CLUSTER �� �ε����� �ڵ������� ��
-- CLUSTER �� �ε����� ������� ó�� �ڵ����� �ε��� �����ÿ� �ڵ����� ������ �� 

-- INDEX �� �ڵ����� ������ �� PRIMARY ���� �� - Cluster �� �ε����� ����
-- ���� �ε�����  UNIQUE ���� �� �����ε��� �ڵ� ������ ��, Cluster �� �ε����� ���̺�� 1���� ������ �� 

SELECT * FROM market_db.member m ;	-- SELECT ����� ���� PK mem_id �� ���ĵǾ� ��ȸ�� ��, Cluster �� INDEX �� �ڵ����� �����Ǿ� �����̵Ǿ� ��ȸ�� ��

USE market_db;

CREATE TABLE table1 (
	col1 INT PRIMARY KEY, -- PRIMARY KEY ���� �� �ڵ����� Cluster �� INDEX �� ������ �� 
	col2 INT,
	col3 INT
)
SHOW INDEX FROM table1; -- key_name �� PRIMARY �� ���� �Ǿ����� Cluster �� INDEX �� 

CREATE TABLE table2 (
	col1 INT PRIMARY KEY,
	col2 INT UNIQUE,
	col3 INT UNIQUE
)
SHOW INDEX FROM table2;	-- INDEX �� 3�� ���� UNIQUE ������ col2, col3 �� ���� �ε����� ������ ��

-- Cluster �� INDEX �� ����� ���� Cluster �� index �� ������ ��

CREATE TABLE member_index (
	mem_id CHAR(8),
	mem_name VARCHAR(10),
	mem_number INT,
	addr CHAR(2)
);

SELECT * FROM member_index;

INSERT INTO market_db.member_index  VALUES('TWC', 'Ʈ���̽�', 9, '����');
INSERT INTO market_db.member_index  VALUES('BLK', '����ũ', 4, '����');
INSERT INTO market_db.member_index  VALUES('WMN', '����ģ��', 6, '���');
INSERT INTO market_db.member_index  VALUES('OMY', '�����̰�', 7, '����');

-- �Է��� ������� �����Ͱ� ��ȸ �� 
SELECT * FROM market_db.member_index mi ;

ALTER TABLE market_db.member_index 
	ADD CONSTRAINT PRIMARY KEY (mem_id);

-- PRIMARY KEY �� ���� �� Cluster �� INDEX �� ������ �Ǹ鼭 mem_id �������� �����Ͱ� ������ �Ǿ� ��ȸ�� ��, cluster �� index �� TABLE�� �ϳ��� ������ ���� 
SELECT * FROM market_db.member_index mi;

-- �⺻ Ű ����
ALTER TABLE market_db.member_index DROP PRIMARY KEY;

ALTER TABLE market_db.member_index 
	ADD CONSTRAINT PRIMARY KEY (mem_name);

-- mem_name PRIMARY Ű ���� �� mem_name ������ �������� ������ �Ǿ� ��ȸ�� �� 
SELECT * FROM market_db.member_index mi;

INSERT INTO market_db.member_index VALUES('GRL', '�ҳ�ô�', 8, '����');
-- mem_name ������ �������� ������ �Ǿ� ��ȸ�� �� Cluster �� INDEX �������� �����Ͱ� ������ �� 
SELECT * FROM market_db.member_index mi;

-- ���� �ε��� (UNIQUE KEY ���� ���� �� ���� �ε����� ������ �� ) : å�� ������ �״�� ���� �Ǹ鼭 ���� �ڿ� ã�ƺ��Ⱑ ������� , �����ε����Ƿ� �����ε��� �������� �����Ͱ� ������ �� ���� ���� 
CREATE TABLE member_assistIndex(
	mem_id CHAR(8),
	mem_name VARCHAR(10),
	mem_number INT,
	addr CHAR(2)
);

INSERT INTO market_db.member_assistIndex  VALUES('TWC', 'Ʈ���̽�', 9, '����');
INSERT INTO market_db.member_assistIndex  VALUES('BLK', '����ũ', 4, '����');
INSERT INTO market_db.member_assistIndex  VALUES('WMN', '����ģ��', 6, '���');
INSERT INTO market_db.member_assistIndex  VALUES('OMY', '�����̰�', 7, '����');

-- mem_id ���� PRIMARY KEY �� �ƴ� UNIQUE KEY �� ����
ALTER TABLE market_db.member_assistindex 
	ADD CONSTRAINT UNIQUE(mem_id);

-- ������ ���� ��ȸ�� �ٲ����� ���� PRIMARY KEY Cluster ���� �ƴ϶� ���� �ε��� ������ �Ƿ� UNIQUE KEY ������ 
SELECT * FROM market_db.member_assistindex ma ;


























