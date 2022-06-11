-- ������ ���̺� (View) -- ��ü�� ����, ���� ���̺� ������ ���� �� ���� ����
-- ������ ���̽� ��ü �� �ϳ� view �� �ٽ��� �ٷΰ��� ������ ���� Ŭ�� ó��
-- ��¥ ������ �ִ� ���� �ƴ϶� ���ϰ� ��ȸ �ϱ� ���Ͽ� ����� ���� ����
-- VIEW ���� ��¥ �����Ͱ� ���� SELECT �� �� ����
USE market_db;

-- �� ���� ����
-- CREATE VIEW ��_�̸� AS SELECT ��;

SELECT * FROM market_db.`member` m ;

-- ������ view ��� ���� ���Ͽ� �տ� v_ �� �ٿ��ִ� ���� ����
CREATE VIEW v_member
AS 	
	SELECT mem_id, mem_name, addr FROM market_db.`member` m ;

-- v_member view �� ��ȸ�� ����
SELECT * FROM market_db.v_member;

-- VIEW ���� WHERE �� ���ε� ������ ����
SELECT mem_name, addr FROM v_member
	WHERE addr IN('����', '���');
-- VIEW ��� �̿�
-- VIEW �� ����ϴ� ������ ���ȿ� ���� ������ ��
-- ���̺� �ֿ� �÷��� ���� �ϰ� ��ȸ�� ��ų �� ����
-- ������ ������ �����ϰ� ������ ����

CREATE VIEW v_memberbuy
AS 
	SELECT b.mem_id, m.mem_name, b.prod_name, m.addr,
		CONCAT (m.phone1, m.phone2) '����ó'
		FROM market_db.buy b 
		INNER JOIN market_db.`member` m 
			ON b.mem_id = m.mem_id; 
		
SELECT * FROM v_memberbuy WHERE mem_name = '����ũ';

-- ���� ���� �۵�
-- �並 ���� �� Alias ��� ���� 

USE market_db;

CREATE VIEW v_viewtest1
AS
	SELECT 
	  b.mem_id AS 'Member ID'
	, m.mem_name AS 'Member Name'
	, b.prod_name AS 'Product Name'
	, CONCAT(m.phone1, m.phone2) AS 'Office Phone'
FROM market_db.buy b 
	INNER JOIN market_db.`member` m 
		ON b.mem_id = m.mem_id ;

-- AS �� ������Ⱑ ���� �� �ÿ��� ��ƽ�� ����Ͽ� ��ȸ
SELECT DISTINCT `Member ID`, `Member Name` FROM v_viewtest1;	

-- view ���� ���� �ÿ��� ALTER VIEW �� ���
ALTER VIEW v_viewtest1 
AS 
	SELECT 
	  b.mem_id AS 'ȸ�� ���̵�'
	, m.mem_name AS 'ȸ�� �̸�'
	, b.prod_name AS '��ǰ �̸�'
	, CONCAT(m.phone1, m.phone2) AS '����ó'
		FROM market_db.buy b 
	INNER JOIN market_db.`member` m 
		ON b.mem_id = m.mem_id ;

SELECT DISTINCT `ȸ�� ���̵�`, `ȸ�� �̸�` FROM v_viewtest1;

-- VIEW ���� ��
DROP VIEW v_viewtest1;

CREATE OR REPLACE VIEW v_viewtest2
AS
	SELECT mem_id, mem_name, addr FROM market_db.`member` m ;

-- DESCRIBE ��� �� v_viewtest2 �� ������� ���� (key .. primary key �� key ������ ������ ����)
DESCRIBE v_viewtest2;

-- view �� ���Ͽ� ������ ������Ʈ �ϱ� 
UPDATE v_member SET addr = '�λ�' WHERE mem_id = 'BLK';

SELECT * FROM v_member;

SELECT * FROM market_db.`member` m ;

-- INSERT ���� �Է��� �ȵ� (���� ���̺��� NOT NULL �� �÷��� �ֱ⿡ VIEW �� ���Ͽ� �����͸� �Է��� �Ǳ⵵ ������ ���� ������ ����)
-- ���� ���̺��� �÷��� NOT NULL ������ �ֱ⿡ VIEW �� ��� �÷��� ���� �� ���� �׷��⿡ �����Ͱ� �Է��� �ɼ��� �ְ� ������������
INSERT INTO v_member(mem_id, mem_name, addr) 
VALUES ('BTS', '��ź�ҳ��', '���');

DESCRIBE market_db.`member`;

--  height �� 167 �� �̻��� ����鸸 ��ȸ�ϴ� view �� ����
CREATE VIEW v_height167
	AS
		SELECT * FROM market_db.`member` m WHERE m.height >= 167;

SELECT * FROM v_height167;	

-- VIEW ���� DELETE ���� ����� ���� ������ ���� ������ �ƴ� �ش� DELETE ���� 167�� �̻��� ����鸸 �ֱ⿡ ������ �����Ͱ� ���� 
DELETE FROM v_height167 WHERE height < 167;

-- �����Ͱ� �Է��� ������ view ���� Ȯ���� �Ұ��� Ű�� 159 �⿡ �ٶ��������� ���� ���� ������ �ƴ� 
INSERT INTO v_height167 
VALUES ('TRA', 'Ƽ�ƶ�', 6, '����', NULL, NULL, 159, '2005-06-01');

SELECT * FROM v_height167 ;

-- WITH OPTION CHECK ��� �� (����ϴ� ���� �ξ� ����- VIEW �� �ش��ϴ� ���� �����͸� �Է��� ����)�ش� DATA CHECK �� ����
ALTER VIEW v_height167 
	AS
		SELECT * FROM market_db.`member` m WHERE m.height >= 167
		WITH CHECK OPTION;

-- ���� ������ �ɾ��⿡ �Է��� �ȵ� (WITH CHECK OPTION �� ���Ͽ� 167 �̸��� �Է��� �ȵǰ� ���� �Ͽ���)	
INSERT INTO v_height167 
VALUES ('TOB', '�׷����', 4, '����', NULL, NULL, 159, '2005-06-01');
	
-- VIEW �� �����ϰ� �ִٰ� ���̺��� ���� �ȵ����� ���� VIEW �� ���� �������  TABLE �� ������ ����
SELECT * FROM market_db.`member_1` m ;

INSERT INTO market_db.member_1 
SELECT * FROM market_db.`member`;

INSERT INTO market_db.buy_1 
SELECT * FROM market_db.buy;

DROP TABLE IF EXISTS market_db.buy, market_db.MEMBER;

-- TABLE �� DROP �����Ͽ��⿡ ������ ��ȸ�� �ȵ�
SELECT * FROM v_height167;

-- CHECK TABLE ���� ���Ͽ� VIEW �� �����ϰ� �ִ� TABLE �� ���¸� Ȯ���� ����
CHECK TABLE v_height167;
	







		
		