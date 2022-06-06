-- 3장 (SQL 문법 SELECT 문)
-- SELECT 문은 SQL 에서 가장 많이 사용 함, 기존에 있는 데이터들을 읽기만 함  
-- SELECT ~ FROM ~ WHERE 을 가장 보편적임

select * from market_db.`member` m ;

-- market_db 를 사용한다는 명령어
-- 한번 USE 를 해 놓으면 계속 유지가 됨 (종료 시 다시 USE 를 사용하기)
use market_db;

select * from market_db.buy b;
select * from market_db.`member` m;
select * from market_db.member m where m.mem_name = '블랙핑크';

select addr 주소, height as 키, debut_date from market_db.`member` m ;









