-- UPDATE 문
-- UPDATE 는 기존에 입력되어 있는 값을 수정하는 명령어

use market_db;

-- 문법 UPDATE DB_NAME SET Column WHERE 조건 ~
-- !!!!! 가장 중요한 것은 UPDATE 문 시 무조건 WHERE 넣어주기 (WHERE 사용 안할 시 모든 데이터 업데이트 진행 됨)

update city_popul 
	set city_name = '서울'
	where city_name = 'Seoul';
		
select * from city_popul where city_name = '서울';

update city_popul set city_name = '뉴욕', population = 0
	where city_name = 'New York';

select * from city_popul where city_name = '뉴욕';
	



