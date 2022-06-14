-- STORED PROCEDURE

-- STORED PROCEDURE : SQL + Programming

-- $$ �̿��� ���ڵ� ��� ������ ���� $$ ���ڸ� ���
-- ���� DELITMITER $$ CREATE PROCEDURE ���ν���_�̸� (IN �Ǵ� OUT �Ű�����) BEGIN ~ END DELIMITER;

-- ������ ���ν��� ����
USE market_db;

DROP PROCEDURE IF EXISTS user_proc;

-- �Ű������� ������ �� ��ȣ�ȿ� �Ű������� �־���
CREATE PROCEDURE user_proc()
BEGIN
	SELECT * FROM market_db.MEMBER;
END;

-- PROCEDURE �� �ʿ��� �� ���� CALL �� �̿��Ͽ� ȣ��
CALL user_proc();

-- PROCEDURE ����
DROP PROCEDURE user_proc;

-- ������ ���ν��� �ǽ�
-- �Ű������� ���
-- �Է� �Ű����� ���� IN �Է�_�Ű�����_�̸� ������ ����

-- ��� �Ű����� : ���ν����� �����ϰ� ��ȯ �޴� �� 
-- ��� �Ű����� ���� OUT _���_�Ű�����_�̸� ������_����

DROP PROCEDURE IF EXISTS user_proc_1;

CREATE PROCEDURE user_proc_1(IN userName VARCHAR(10))
BEGIN
	SELECT * FROM market_db.`member` m WHERE m.mem_name = userName;
END;

-- ������ũ�� �Ķ���ͷ� �� ������ũ �����Ͱ� ��ȸ ��
CALL user_proc_1('������ũ');

DROP PROCEDURE IF EXISTS user_proc_2
CREATE PROCEDURE user_proc_2(
	IN userNumber INT,
	IN userWeight INT
)
BEGIN
	SELECT * FROM market_db.`member` m WHERE m.mem_number  > userNumber AND m.height  > userWeight;
END;

CALL user_proc_2(6, 165);

DROP PROCEDURE IF EXISTS user_proc_3;

CREATE PROCEDURE user_proc_3 (
	IN txtValue CHAR(10),
	OUT outValue INT
)
BEGIN
	-- ���� Table �� ���� ���ν��� ���� �� ������ �߻������� ������
	-- ����� ������ �ƴ� �����ϴ� ������ ������ �߻� (���� ���� ������ ���̺��� ����� ������ ��)
	INSERT INTO noTable VALUES(NULL, txtValue);
	-- ��ȸ SELECT �� id �� �� outValue �� ���� ��� ��
	SELECT max(id) INTO outVALUE FROM noTable;
END;

DESC noTable;

CREATE TABLE IF NOT EXISTS noTable (
	id INT AUTO_INCREMENT PRIMARY KEY,
	txt CHAR(10)
);

-- '�׽�Ʈ1' �Ķ���Ϳ�, outValue �� myValue
CALL user_proc_3('�׽�Ʈ1', @myValue);

-- @myValue �� out�Ű������̹Ƿ� �� �� ����.
SELECT @myValue FROM DUAL;

SELECT * FROM noTable;

DROP PROCEDURE IF EXISTS ifElse_proc;

SELECT * FROM market_db.`member` m ;

CREATE PROCEDURE ifElse_proc(
	IN memName VARCHAR(10)
)
BEGIN 
	DECLARE debutYear INT;	-- ���� ����
	SELECT YEAR(debut_date) INTO debutYear FROM market_db.`member` m WHERE mem_name = memName;
	
	IF(debutYear >= 2015) THEN
		SELECT '���� �����׿�. ȭ���� �ϼ���.' AS '�޼���';
	ELSE
		SELECT '���� �����׿�. ���� �ϼ���' AS '�޼���';
	END IF;
END;

CALL ifElse_proc('����ģ��');

DROP PROCEDURE IF EXISTS while_proc;

CREATE PROCEDURE while_proc()
BEGIN
	DECLARE hap INT;	-- �հ�
	DECLARE num INT;	-- 1 ���� 100 ���� ����
	SET hap = 0;	-- �հ� �ʱ�ȭ
	SET num = 1;
	
	WHILE(num <= 100) DO 	-- 100 ���� �ݺ�
		SET hap = hap + num;
		SET num = num + 1;
	END WHILE;

	SELECT hap AS '1 ~ 100 ���� �հ�';

END

CALL while_proc();

-- ���� SQL : SQL �� ������ ���� �ƴ϶� ��� �ٲ�

DROP PROCEDURE IF EXISTS dynamic_proc;

CREATE PROCEDURE dynamic_proc(
	IN tableName VARCHAR(20)
)
BEGIN
	SET @sqlQuery = CONCAT('SELECT * FROM ', tableName);
	
	PREPARE myQuery FROM @sqlQuery;
	EXECUTE myQuery;
	DEALLOCATE PREPARE myQuery;
END;

CALL dynamic_proc('member');






