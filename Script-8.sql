-- JOIN (�� ���� ���̺��� ����)

-- ���� ���� (�׳� �����̶� �ϸ� ���� �����̶� �����ϸ� ��)
-- �⺻Ű(PK)�� �ܷ�Ű(FK)�� ������ �־�� �� 
-- �ϴ�� ���� (one to many) 
-- �ϴ� �� ���� : ���� ȸ��(member)�� ����(buy)�� �Ͽ��� �� �����Ͱ� buy ���̺� ���� �׷��� ȸ�� id  �� ������ ���̹Ƿ� �ϴ�� ���� ���� (ȸ�� ���̺��� member_id �� �Ѱ�)
use market_db;

select * from market_db.`member` m;
select * from market_db.buy;

-- ���� SELECT <�� ���> FROM ù ���̺� INNER JOIN �ι�° ���̺� ON ������ ���� WHERE �˻� ����

select * from buy b 
	 inner join `member` m 
			 ON b.mem_id = m.mem_id 
		  where b.mem_id = 'GRL';

-- WHERE ���� ��� �� 
SELECT * FROM buy b INNER JOIN `member` m ON b.MEM_ID = m.MEM_ID;

-- ���� ���̺��� �������� ���� 
SELECT b.mem_id, m.mem_name, b.prod_name, m.addr, CONCAT(phone1, phone2) AS '����ó'
FROM buy b INNER JOIN `member` m ON b.mem_id = m.mem_id;

-- �ܺ� ���� : �������ο� �Ѱ����� ���Ÿ� �� ȸ���鸸 ȸ�� ������ ��ȸ�� ��
-- �ܺ� ������ ������ �����Ͱ� ��� �����Ͱ� ��ȸ, �� �ʿ��� �ִ� ������ �鵵 ��ȸ�� ����

-- LEFT OUTER JOIN ���� ���̺� �������� �����Ͱ� ��� ��ȸ �ϵ��� ��ȸ
SELECT m.mem_id, m.mem_name, b.prod_name, m.addr  
  FROM market_db.`member` m
LEFT OUTER JOIN market_db.buy b 
		ON m.mem_id = b.mem_id
	ORDER BY m.mem_id;

-- RIGHT OUTER JOIN ������ ���̺� �������� �����Ͱ� ��� ��ȸ �ϵ��� ��ȸ
SELECT m.mem_id, m.mem_name, b.prod_name, m.addr  
  FROM market_db.buy b
LEFT OUTER JOIN market_db.`member` m  
		ON m.mem_id = b.mem_id
	ORDER BY m.mem_id;


-- ��ȣ ���� (CROSS JOIN) - ������ �ǹ̴� ������ ��뷮 ������ ����� ���� �� ���
-- ������ ���� ���δ� ������ �� (�׽�Ʈ ������ ��뷮 ���� ������ ���� �� �ַ� ���)
SELECT * FROM market_db.buy b CROSS JOIN market_db.`member` m ;

SELECT COUNT(*) '������ ����' FROM sakila.inventory i 
CROSS JOIN world.city c;

CREATE TABLE cross_table 
SELECT * FROM sakila.actor a CROSS JOIN world.country c;

SELECT * FROM cross_table;

SELECT * FROM cross_table LIMIT5;
	 
-- SELF JOIN (�ڱ��ڽŰ� �ڱ��ڽ��� ���� �Ǵ� ���) --> ���̺��� �ٸ��ٰ� ���� �ϰ� JOIN �ϴ� ���� ���� 
-- ��ü ������ ������ ���̺��� ��Ī�� �ݵ�� �ٸ��� �־�� �� 

USE market_db;		 

CREATE TABLE emp_table (emp CHAR(4), manager CHAR(4), phone VARCHAR(8));

INSERT INTO emp_table VALUES('��ǥ', NULL, '0000');
INSERT INTO emp_table VALUES('�����̻�', '��ǥ', '1111');
INSERT INTO emp_table VALUES('�����̻�', '��ǥ', '2222');
INSERT INTO emp_table VALUES('�����̻�', '��ǥ', '3333');
INSERT INTO emp_table VALUES('��������', '�����̻�', '1111-1');
INSERT INTO emp_table VALUES('�渮����', '�����̻�', '2222-1');
INSERT INTO emp_table VALUES('�λ����', '�����̻�', '2222-2');
INSERT INTO emp_table VALUES('��������', '�����̻�', '3333-1');
INSERT INTO emp_table VALUES('��������', '�����̻�', '3333-1-1');	

SELECT * FROM emp_table;

SELECT a.phone FROM emp_table a INNER JOIN emp_table b ON a.manager = b.emp; 





