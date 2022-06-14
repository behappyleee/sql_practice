-- PROCEDURE 2

-- STORED �Լ� �� CURSOR 
-- STORED �Լ��� PROCEDURE �� ��¦ �ٸ�
-- STORED �Լ��� MySQL ���� �������ִ� �Լ� �ܿ� �ڽ��� ����� �Լ���

-- ���� : CREATE FUNCTION ������_�Լ�_�̸� (�Ű�����) RETURNS ��ȯ ���� BEGIN �ڵ� RETURN ��ȯ ��; END

-- ȣ�� : SELECT ������_�Լ�_�̸� (��κ� SELECT �̿��Ͽ� ȣ��)

-- �ѹ��� �����ϸ� �� �׷��� ��� ������ �Ǿ� ����
SET GLOBAL log_bin_trust_function_creators = 1;

USE market_db;

DROP FUNCTION IF EXISTS sumFunc;

CREATE FUNCTION sumFunc(number1 INT, number2 INT) 
	RETURNS INT
BEGIN 
	RETURN number1 + number2;
END;

SELECT sumFunc(100, 200) AS '�հ�';

DROP FUNCTION IF EXISTS calcYearFunc;

CREATE FUNCTION calYearFunc(dYear INT)
	RETURNS INT
BEGIN
	DECLARE runYear INT;	-- Ȱ���Ⱓ(����)
	SET runYear = YEAR(CURDATE()) - dYear;
	RETURN runYear;
END;

SELECT calYearFunc(2015);

SELECT calYearFunc(2007) INTO @debut2007;
SELECT calYearFunc(2013) INTO @debut2013;
SELECT @debut2007 - @debut2013 AS '2007�� �� 2013 ����';

-- ���� �Լ��� �����ϰ� ��� ��� �� ����� ���� ��
SELECT mem_id, mem_name, calYearFunc(YEAR(debut_date)) AS 'Ȱ�� �� ��'
	FROM MEMBER;

-- �Լ��� ����
DROP FUNCTION calYearFunc;



















