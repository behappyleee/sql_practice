-- 3�� (SQL ���� SELECT ��)
-- SELECT ���� SQL ���� ���� ���� ��� ��, ������ �ִ� �����͵��� �б⸸ ��  
-- SELECT ~ FROM ~ WHERE �� ���� ��������

select * from market_db.`member` m ;

-- market_db �� ����Ѵٴ� ��ɾ�
-- �ѹ� USE �� �� ������ ��� ������ �� (���� �� �ٽ� USE �� ����ϱ�)
use market_db;

select * from market_db.buy b;
select * from market_db.`member` m;
select * from market_db.member m where m.mem_name = '����ũ';

select addr �ּ�, height as Ű, debut_date from market_db.`member` m ;









