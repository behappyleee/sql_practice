-- CURSOR
-- Ŀ���� �� �� �� �� �� �� ó���ϴ� ����
-- ��� ��� 1) Ŀ�� ���� 2) �� �� �� ó�� 3) Ŀ���� ����

-- Ŀ���� ���ν��� �ȿ� ���� ������ 
-- Ŀ�� ���� �ϱ�
DECLARE memberCursor CURSOR FOR SELECT m.mem_number FROM market_db.`member` m;



-- TRIGGER : �ڵ����� ����Ǵ� ��Ƽ谡 �ڵ����� ������ٰ� �����ϸ� ��
-- Ʈ���� INSERT UPDATE DELETE �� �߻� EX) ����ũ�� Ż�� �� ȸ�� ���̺��� ����
-- � ���̺��� ������ ���Ͽ� DELETE �� ���󰡸� �ڵ����� ������ ��
-- TRIGGER �� �̺�Ʈ ���� (Ʈ���Ŵ� ���̺� ������)

USE market_db;

CREATE TABLE IF NOT EXISTS trigger_table (id INT, txt VARCHAR(10));

INSERT INTO trigger_table VALUES(1, '���座��');
INSERT INTO trigger_table VALUES(2, '����');
INSERT INTO trigger_table VALUES(3, '����ũ');

SELECT * FROM market_db.trigger_table;

DROP TRIGGER IF EXISTS myTrigger;

CREATE TRIGGER myTrigger
	AFTER DELETE 	
	ON trigger_table
	FOR EACH ROW 
BEGIN 
	SET @msg = '���� �׷��� ���� ��';
END;

-- Ʈ���Ű� �۵��� �� �� msg ������ update ��
SET @msg = '';

INSERT INTO trigger_table VALUES(4, '������');

SELECT @msg;

UPDATE market_db.trigger_table SET txt = '����' WHERE id= 3;

DELETE FROM market_db.trigger_table WHERE id = 4;

-- TRIGGER �� �۵��� �ϸ鼭 msg ���ڰ� SET ��
SELECT @msg;

-- Ʈ���� Ȱ��
-- UPDATE �� DELETE �� �Ͼ �� ����� ����� �� �� Ȱ���� ����
CREATE TABLE singer (SELECT mem_id, mem_name, mem_number, addr FROM market_db.`member` m);

SELECT * FROM market_db.singer;

DROP TABLE IF EXISTS backup_singer;

CREATE TABLE backup_singer (
	mem_id CHAR(8) NOT NULL,
	mem_name VARCHAR(10) NOT NULL,
	mem_number INT NOT NULL,
	addr CHAR(2) NOT NULL,
	modType CHAR(2),
	modDate DATE,
	modUser VARCHAR(30)
);

SELECT * FROM market_db.backup_singer;

-- UPDATE �� �۵��Ǵ� TRIGGER
DROP TRIGGER IF EXISTS singer_updateTrg;
CREATE TRIGGER singer_updateTrg
	AFTER UPDATE 	
	ON market_db.singer
	FOR EACH ROW 
BEGIN 
	INSERT INTO backup_singer 
	-- OLD TABLE �� SYSTEM TABLE �� MYSQL �� ������ ����, ���󰡱����� OLD ��� ���̺� ��� �� ���� (UPDATE �� DELETE �� MYSQL ���� ����) 
	    VALUES (OLD.mem_id, OLD.mem_name, OLD.mem_number, OLD.addr, 
	    '����', CURDATE(), CURRENT_USER());
END;

-- DELETE �� �۵��Ǵ� TRIGGER
DROP TRIGGER IF EXISTS singer_deleteTrg;

CREATE TRIGGER singer_deleteTrg
	AFTER DELETE 	
	ON market_db.singer
	FOR EACH ROW 
BEGIN 
	INSERT INTO backup_singer 
	-- OLD TABLE �� SYSTEM TABLE �� MYSQL �� ������ ����, ���󰡱����� OLD ��� ���̺� ��� �� ���� (UPDATE �� DELETE �� MYSQL ���� ����) 
	    VALUES (OLD.mem_id, OLD.mem_name, OLD.mem_number, OLD.addr, 
	    '����', CURDATE(), CURRENT_USER());
END;

SELECT * FROM market_db.singer s;
SELECT * FROM market_db.backup_singer;
SELECT * FROM market_db.MEMBER;


UPDATE market_db.singer s SET s.addr = '����' WHERE s.mem_id = 'BLK';

DELETE FROM market_db.singer WHERE mem_number >= 2;















