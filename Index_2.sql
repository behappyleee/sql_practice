-- INDEX�� ���� �۵�

-- TREE, �Ѹ� (ROOT) / �߰� / �� Leaf --> TREE ����
-- ���� Ʈ�� : Node - �����Ͱ� ������ �Ǵ� ����, MySQL ������ Node �� ��������� �θ� 

-- å�� �ڿ� ã�ƺ��Ⱑ ����, INDEX �� ����� ���� �׳� ù��° ������ ���� ã��  
-- �Ϲ������� index �� ���� ���¿����� ù��° ������ ���� ã�� (Full Page Scan �̶�� �� --> ������ ������ ������ 1���� ã�� ���Ͽ� ��� �������� ã�� ��)

-- INDEX �� ���� �� Full Page Scan �� ���� �� ����
-- ROOT PAGE �� �߰� (�� ������ �� ���� �ִ� �� �鸸 ��� ���� ��������)

-- INDEX �� �ִ� ���� �����͸� ã�� ����� �Ȱ��� 
-- ���� Ʈ���� ������ ����, INDEX �� SELECT �� �������� INSERT DELETE UPDATE �� �� ������ (������ ���� ������ �׷�)

-- ������ ������ �Ͼ �� ���� ������ ������
-- �Ȱ��� 1���� �Է��� �Ͽ����� ������ ���� �� ���� �Ͼ�� �ӵ��� ������ ������ 
-- �Է� �� �� ���ٴ� ������ ���� ������ �ӵ��� ���� �� 

-- Index ���� : Cluster �� �ε���, ���� �ε��� 

USE market_db;
CREATE TABLE cluster (
	mem_id CHAR(8),
	mem_name VARCHAR(10)
);

SELECT * FROM market_db.cluster;

INSERT INTO market_db.cluster VALUES ('TWC', 'Ʈ���̽�');
INSERT INTO market_db.cluster VALUES ('BLK', '����ũ');
INSERT INTO market_db.cluster VALUES ('WMN', '����ģ��');
INSERT INTO market_db.cluster VALUES ('OMY', '�����̰�');
INSERT INTO market_db.cluster VALUES ('GRL', '�ҳ�ô�');
INSERT INTO market_db.cluster VALUES ('ITZ', '����');
INSERT INTO market_db.cluster VALUES ('RED', '���座��');
INSERT INTO market_db.cluster VALUES ('APN', '������ũ');
INSERT INTO market_db.cluster VALUES ('SPC', '���ּҳ�');
INSERT INTO market_db.cluster VALUES ('MMU', '������');

SELECT * FROM cluster;

ALTER TABLE market_db.cluster
	ADD CONSTRAINT PRIMARY KEY (mem_id);

USE market_db;

-- ������ �Ʊ� DATA �Է� �� �׳� �ϳ��ϳ� �׿�����
-- PRIMARY KEY ���� �� DATE �Է� �� mem_id ������ ���� �����Ͱ� ������ ��
-- ROOT PAGE �� �� PRIMARY Ű ������ ���� �������� �������

USE market_db;

CREATE TABLE market_db.second (
	mem_id CHAR(8),
	mem_name VARCHAR(10)
);

SELECT * FROM market_db.SECOND;

INSERT INTO market_db.SECOND VALUES('TWC', 'Ʈ���̽�');
INSERT INTO market_db.SECOND VALUES('BLK', '����ũ');
INSERT INTO market_db.SECOND VALUES('WMN', '����ģ��');
INSERT INTO market_db.SECOND VALUES('OMY', '�����̰�');
INSERT INTO market_db.SECOND VALUES('GRL', '�ҳ�ô�');
INSERT INTO market_db.SECOND VALUES('ITZ', '����');
INSERT INTO market_db.SECOND VALUES('RED', '���座��');
INSERT INTO market_db.SECOND VALUES('APN', '������ũ');
INSERT INTO market_db.SECOND VALUES('SPC', '���ּҳ�');
INSERT INTO market_db.SECOND VALUES('MMU', '������');

SELECT * FROM market_db.SECOND;

-- ���� INDEX ���� 
ALTER TABLE market_db.SECOND 
	ADD CONSTRAINT UNIQUE (mem_id);

-- ���� INDEX �� ������ �Ͽ����Ƿ� ������ ��ȸ ��� ������ �ٲ��� ���� 
SELECT * FROM market_db.SECOND;

-- ������ Page �� �״�� �ְ� ã�ƺ��Ⱑ ����� �� (ROOT �������� ���Ӱ� ����� �� )
-- ���� �� ���� �۵��� �̷������� �۵��� �ǰ� ���� 
-- ������ �˻� �� ���� SPC ��� �����͸� ã�� ��

-- CLUSTER �� INDEX �� ���ĺ� ��ü�� �ε������ �����ϸ� ��
-- 1) ��Ʈ ���������� �ش� �����Ͱ� ���ϴ� �������� ã�� ��
-- 2) ���� ���������� �ش� �����͸� ã�� �� (Cluster �� index ���� �����͸� ��ȸ �� ã�� ��)
SELECT * FROM market_db.SECOND WHERE mem_id ='SPC' ;

-- ���� �ε������� ������ ã��
-- CLUSTER �� INDEX �� 2�������� �˻��ؼ� �����͸� �˾Ƴ���, ���� INDEX �� 3 �������� ã�Ƴ��� �����͸� ã�Ƴ�
-- CLUSTER ���� ������ INDEX ���� ȿ�� ���� 







