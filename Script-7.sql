-- DELETE 문

-- 문법 DELETE FROM DB_BNAME WHERE 조건
-- !!! 가중 중요한 것 WHERE 빼먹지 않기 (WHERE 빼 먹을 시 모든 데이터 삭제 됨 !!!!) !!!!!!

delete from city_popul where city_name like 'New%';

select * from city_popul where city_name like '%New%';

