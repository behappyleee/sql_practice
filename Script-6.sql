-- UPDATE ��
-- UPDATE �� ������ �ԷµǾ� �ִ� ���� �����ϴ� ��ɾ�

use market_db;

-- ���� UPDATE DB_NAME SET Column WHERE ���� ~
-- !!!!! ���� �߿��� ���� UPDATE �� �� ������ WHERE �־��ֱ� (WHERE ��� ���� �� ��� ������ ������Ʈ ���� ��)

update city_popul 
	set city_name = '����'
	where city_name = 'Seoul';
		
select * from city_popul where city_name = '����';

update city_popul set city_name = '����', population = 0
	where city_name = 'New York';

select * from city_popul where city_name = '����';
	



