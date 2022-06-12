-- INDEX �� ������ ���� ����

-- INDEX ���� ����
-- CREATE INDEX �ε���_�̸� ON ���̺�_�̸� (��_�̸�) [ASC/DESC (�⺻�� ASC)];
-- INDEX ���� �� UNIQUE OPTION �� ������ �� UNIQUE ���� �� �ߺ� ���� �ȵ��� �̸� ������ �ߺ� ������ ������ �����Ͽ��� �ϹǷ� �����ϱ�

-- CREATE / DROP �� �ڵ������� ���� �Ǵ� INDEX �� �ƴ� 
-- �ڵ����� �����Ǵ� INDEX �� DROP �� �ƴ� PRIMARY KEY �� ������ ��

USE market_db;

SELECT * FROM market_db.`member` m;

-- INDEX CHECK
-- PRIMKARY KEY �� INDEX �� �����Ǿ� ����
SHOW INDEX FROM market_db.MEMBER;

-- Data_length 16384 �� 16kb ������ ���� ��
SHOW TABLE STATUS LIKE 'member';

-- �ܼ� �ε��� ����
CREATE INDEX idx_member_addr
	ON market_db.`member` (addr);

SHOW INDEX FROM market_db.MEMBER;

-- ANALYZE ��ɾ �Է��� �־�� ������ index �� ��
ANALYZE TABLE market_db.`member`;
-- ���� �ε����� ���� �� ��ȸ �� index_length ���� kb �� ������ ��
SHOW TABLE STATUS LIKE 'member';

-- ������ �߻� UNIQUE �ɼ��� �־����� �ο����� �ߺ� �� ������ �ֱ⿡ ������ �߻���
CREATE UNIQUE INDEX idx_member_mem_number
	ON market_db.`member` (mem_number);	-- ������ �߻��� 

-- ��� UNIQUE �� ���������� ������ ����� �ߺ����� ���������ʾ� ���� ����� ������ INSERT �� �� �ߺ����� �Է��� �ȵ� ����� ���� �� 
-- �ݵ�� UNIQUE �� �� ���� UNIQUE �ɼ� �ֱ� email ���� .... unique option ���� �� INSERT �� �� ���� INSERT �� �ȵ�
CREATE UNIQUE INDEX idx_member_mem_name
	ON market_db.`member` (mem_name);

ANALYZE TABLE market_db.`member`;

SHOW INDEX FROM market_db.`member`;

-- �ش� SELET ���� INDEX ������� ���� �ֳ��ϸ� �����͸� ��ü �� ��ȸ�̱⿡ INDEX ��� �ʿ䰡 ����
-- INDEX �� ����Ͽ��� �� �ƴ� ���� CRTL + SHIFT + E �� Ŭ���ϸ� Execution Plan �� �� �� ����

SELECT  * FROM market_db.MEMBER;

-- WHERE ���� ����Ͽ��� INDEX �� ����Ͽ��� ��ȸ�� �� 
SELECT addr FROM market_db.`member` m;

SELECT  m.mem_id, m.mem_name, m.addr FROM market_db.`member` m WHERE m.mem_name = '������ũ';

CREATE  INDEX idx_member_mem_number
	ON market_db.`member` (mem_number);

-- INDEX �� ����Ͽ� ��ȸ
SELECT m.mem_name, m.mem_number FROM market_db.`member` m WHERE m.mem_number >= 7;

-- 7 �̻��� ��ȸ �� ���� INDEX �� ����Ͽ� �� ��ȸ�� �Ͽ����� 1 �̻��� �� ��ȸ�� �� ���� INDEX �� ������� ����
-- MySQL ���� �˾Ƽ� 7 �̻��� �� �� INDEX �� ����ϴ� ���� ȿ�����̿��� INDEX �� ����� �Ͽ����� 1 �̻��� ���� INDEX ����ϴ� ���� ��ȿ���� ��ȿ�����̿��� MYSQL �� �˾Ƽ� ����� ���� ���� 
SELECT m.mem_name, m.mem_number FROM market_db.`member` m WHERE m.mem_number >= 1;

-- WHERE ���� (�� ��_ ������ ���� MySQL �� �˾Ƽ� INDEX �� ������� ���� 
SELECT m.mem_name, m.mem_number  FROM market_db.`member` m WHERE m.mem_number * 2 >= 14;

-- ������ INDEX �� ����ϴ� ���� ȿ���� �̹Ƿ� �� �̸��� ������ �����ʴ� ���� ����
-- INDEX �� ��� ���� �� ���� ������ �ִ� ���� �ƴ� = �����U ���� ������ ���� (�� �� ����� �����Ƿ� ������ �� ����Ͽ� ���� �ϱ�)
SELECT m.mem_name, m.mem_number  FROM market_db.`member` m WHERE m.mem_number >= 14/2;

-- INDEX ���� (DROP ���� �̿��Ͽ� ����)
DROP INDEX idx_member_mem_name ON market_db.`member` ;

SHOW INDEX FROM market_db.`member`;

-- PRIMARY KEY ������ ���� �� �ݵ�� FOREIGN Ű ���� ������ ���־�� ��
-- �׷��� ������ ERROR �� �߻� �� 

-- �ش� DATABASE �� �ܷ� Ű �� ���� �� �� ���� 
SELECT table_name, constraint_name 
  FROM information_schema.REFERENTIAL_CONSTRAINTS rc 
  WHERE CONSTRAINT_SCHEMA = 'market_db';





