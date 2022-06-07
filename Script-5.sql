-- INSERT / UPDATE
-- SELECT �� Data �� �����ͼ� ���� ������ Data �� ���� ���� ����

-- INSERT �� �����͸� �Է�
-- ���� : INSERT INTO [��1, ��2 ...] VALUES(��1, ��2 ...)

use market_db;

create table hongong1 (toy_id INT, toy_name CHAR(4) , age INT );

-- INSERT �� �Է� �� ���� ���� �� �Է� �� ��� �Է� �� ���� �����־�� �� 

insert into hongong1 VALUES(1, '���', 25);

insert into hongong1(toy_id, toy_name) VALUES(2, '����');

insert into hongong1(toy_name, age, toy_id) VALUES('����' , 20, 3);

create table hongong2 (
	-- AUTO_INCREMENT �� �ݵ�� PRIMARY KEY �� ����
	-- AUTO_INCREMENT �� ��ȣ�� �ǹ� ���� �׳� 1�� �þ� �� 
	toy_id INT auto_increment primary key,
	toy_name CHAR(4),
	AGE INT
)

insert into hongong2 VALUES(null, '����', 25);
insert into hongong2 VALUES(null, '����Ű', 22);
insert into hongong2 VALUES(null, '����', 21);

-- ������ AUTO_INCREMENT �� ���� ���� �˰� ���� �� ���� ��ũ��Ʈ ����
select last_insert_id(); 

-- ���� ��ũ��Ʈ�� AUTO_INCREMENT �� 100 ���� ���� �� 
-- ó������ AUTO_INCREMENT �Է� �� �� �Է� �� ���� ������ ī��Ʈ
alter table hongong2 auto_increment= 100;

-- ���� ��ũ��Ʈ�� auto_increment �� ������ 3���� ���߾� �ָ鼭 AUTO_INCREMENT �� ��
set @@auto_increment_increment = 3;

insert into hongong2 VALUES(null, '�丶��', 20);
insert into hongong2 VALUES(null, '���ӽ�', 23);
insert into hongong2 VALUES(null, '���', 25);

select * from hongong2;

-- ���� INSERT INTO ���̺�_�̸� (��_�̸�1, ��_�̸� 2) SELECT ~ SELECT �� ���� ��� ���� ����

select count(*) from world.city c;

-- DESC �� ���̺� ������ �˷��ִ� ��ɾ�
desc world.city ;

select * from world.city c limit 5;

create table city_popul(city_name CHAR(35), population INT);

-- INSER ~ SELECT �� �̿�� SELECT �� �����͸� INSERT �� �� �� �ִ�
insert into city_popul 
	select name, population from world.city;















