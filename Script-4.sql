-- ORDER BY �� : ��� ������ ������ ������ ��� ���ʸ� ����
-- market_db ���
use market_db;

-- ORDER BY �� �⺻������ ���������� (���� �� ASC - ��������, DESC- ��������)
select mem_id, mem_name, debut_date
	from market_db.`member` m  order by debut_date;

select mem_id, mem_name, debut_date from market_db.`member` m  
order by debut_date desc;

-- Ű �⺻������ ���������̸� Ű�� ���� �� debut_date �� ������������ ����
select mem_id, mem_name, debut_date, height from market_db.`member` m  
where height >= 164 order by height desc, debut_date ASC;

-- LIMIT ��� �� 3 �� �߶� �����ְ� ��
select * from market_db.`member` m limit 3;

-- LIMIT ���� 2�� ���� ���� �� �� 3��° ���� ����� 2�� ������ SELECT 
select mem_name, height from member order by height desc 
limit 3, 2;

-- DISTINCT : �ߺ��� ���� ������ �� �� �� �ϳ��� SELECT �� �� ��
select distinct addr from market_db.`member` m;

-- GROUP BY : GROUP ���� GROUP ���� ���� �� 

select  m.mem_id, m.mem_name, sum(amount) from market_db.`member` m group by m.mem_id; 

select * from market_db.buy;

select b.mem_id, sum(b.amount) as '�� ���� ����' from market_db.buy b group by b.mem_id; 

select b.mem_id 'ȸ�� ���̵�', SUM(price*amount) from market_db.buy b group by b.mem_id;

select b.mem_id, b.group_name, AVG(amount) from market_db.buy b group by b.mem_id;

-- phone1 �÷��� ���� �ִ� �÷��� count �� �� 
select count(m.phone1) as '�޴��� ���� ȸ��' from market_db.`member` m ;

-- GROUP �Լ��� ������ �� �ÿ��� WHERE �� �ƴ� GROUP BY �� ���
select mem_id 'ȸ�� ���̵�', SUM(price*amount) as '�� ���� �ݾ�', b.prod_name 
from market_db.buy b group by b.mem_id  having SUM(price*amount) > 1000

select b.mem_id, SUM(b.price*b.amount) as '�� ���� �ݾ�' from market_db.buy b group by b.mem_id having SUM(b.price*b.amount) > 1000
order by sum(b.price*b.amount) desc;

select * from market_db.buy b;

select *, count(mem_id) as '��� ��' from market_db.buy b group by b.mem_id; 
