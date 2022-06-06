select * from sakila.actor;

-- PRIMARY KEY
-- �ֿ� Ư�� 2 ���� NOT NULL, UNIQUE

-- ������ ���̽� ���� ����
-- 1) Database �����
-- 2) Table ���� �ϱ�

select * from shop_db.`member`;

insert into shop_db.`member` values('tess' , '���ƾ�', '��� ��õ�� �ߵ�');
insert into shop_db.`member` values('hero' , '�ӿ���', '���� ���� ���굿');
insert into shop_db.`member` values('iyou' , '������', '��õ ���� �־ȵ�');
insert into shop_db.`member` values('jyp' , '������', '��� ���� ���׵�');

insert into shop_db.product  values('�ٳ���', 1500, '2021-07-01', '����Ʈ', 17);
insert into shop_db.product  values('ī��', 2500, '2022-03-01', 'OB', 3);
insert into shop_db.product  values('�ﰢ���', 800, '2023-09-01', 'CJ', 22);

select * from shop_db.product p ;
select * from shop_db.`member` m;

select * from shop_db.`member` m where member_name = '�Ӷ��̾�';

-- �����ͺ��̽� ��ü
-- ������ ���̽� �ȿ� ������� �� �ִ� �ϳ��� ������Ʈ���� 
-- ���̺��� ��ǥ���� �����ͺ��̽� ��ü��, 
-- ��, �ε���, ���ν���, Ʈ����

-- �ε��� (Index)
-- �����͸� ��ȸ �� ������ ��ȸ�� �� �ֵ��� �����ִ� ��ü
-- ��� �ε����� ��� ũ�� ����� ���� ��� ���� ã���� �ֵ��� ������ �� �� ����

-- ���� WHERE ���� DB �� ��ü �� ���� name �� �������� ���� ã�Ƴ� ���� (�����Ͱ� ���� ���� ��û ���� �ɸ�) 
select * from shop_db.`member` m where m.member_name = '������';

-- INDEX ���� DDL �� (ã�ƺ��⸦ ���� ���� å ǥ�� �� ���� ����)
create index idx_member_name on shop_db.`member`(member_name);

-- INDEX �� ����Ͽ� ã�� �ð��� �ξ� ���� �ٿ��� (��Ʈ��+shift+E �� �Բ� ���� ���� ��ȹ���� Ȯ���� ����)
select * from shop_db.`member` m where m.member_name = '������';

-- view �� ������ ���̺��� (view �� �ٷΰ��� �������̶� ����� ������ )
-- view �� �ƴ϶� Table �� �����ϴ� ���̶� ������ ȿ���� �߻� 
-- view �� ������ �� �� SELECT �� �۵��� �Ͽ� ����ڴ� TABLE �� �����Ͽ��ٰ� ������ ��

-- SELECT �� ����� VIW �� ���� (���� ���� �̽��ε� ����� �ϱ⵵ ��)
create view member_view
AS
select * from shop_db.`member` m;

-- view �� �����Ͽ� �����͸� SELECT ��
select * from member_view;

-- stored procedure (SQL �� ���α׷��� �� �ƴϱ⿡ ���α׷��� ��� ���ó�� ����ϱ� ���Ͽ� Stored Procedure �� ���)
select * from shop_db.`member` m where m.member_name = '���ƾ�';
select * from shop_db.product p where p.product_name = '�ﰢ���';

-- �� SELECT ����� ���� ����Ѵٰ� �ϸ� ��� stored Procedure ����� ����� ����
-- STORED PROCEDURE �� ����� ���� DELIMETER �� BEGIN / END �� ����Ͽ� PROCEDURE �� ���� 
DELIMITER //
create procedure myProc()
BEGIN
	select * from shop_db.`member` m where m.member_name = '���ƾ�';
	select * from shop_db.product p where p.product_name = '�ﰢ���';
end // 
DELIMITER;

-- PROCEDURE ȣ�� �ϴ� ���
call myProc();





















	






