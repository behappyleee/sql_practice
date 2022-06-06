-- ORDER BY 절 : 결과 내용은 변하지 않으며 결과 차례만 변함
-- market_db 사용
use market_db;

-- ORDER BY 는 기본적으로 오름차순임 (생략 시 ASC - 오름차순, DESC- 내림차순)
select mem_id, mem_name, debut_date
	from market_db.`member` m  order by debut_date;

select mem_id, mem_name, debut_date from market_db.`member` m  
order by debut_date desc;

-- 키 기본적으로 내림차순이며 키가 같을 시 debut_date 로 오름차순으로 정렬
select mem_id, mem_name, debut_date, height from market_db.`member` m  
where height >= 164 order by height desc, debut_date ASC;

-- LIMIT 사용 시 3 개 잘라서 보여주게 됨
select * from market_db.`member` m limit 3;

-- LIMIT 숫자 2개 연속 적어 줄 시 3번째 이후 행부터 2개 데이터 SELECT 
select mem_name, height from member order by height desc 
limit 3, 2;

-- DISTINCT : 중복된 것은 제거해 준 후 딱 하나만 SELECT 를 해 줌
select distinct addr from market_db.`member` m;

-- GROUP BY : GROUP 같은 GROUP 으로 묶어 줌 

select  m.mem_id, m.mem_name, sum(amount) from market_db.`member` m group by m.mem_id; 

select * from market_db.buy;

select b.mem_id, sum(b.amount) as '총 구매 갯수' from market_db.buy b group by b.mem_id; 

select b.mem_id '회원 아이디', SUM(price*amount) from market_db.buy b group by b.mem_id;

select b.mem_id, b.group_name, AVG(amount) from market_db.buy b group by b.mem_id;

-- phone1 컬럼이 값이 있는 컬럼만 count 를 함 
select count(m.phone1) as '휴대폰 보유 회원' from market_db.`member` m ;

-- GROUP 함수에 조건을 걸 시에는 WHERE 가 아닌 GROUP BY 를 사용
select mem_id '회원 아이디', SUM(price*amount) as '총 구매 금액', b.prod_name 
from market_db.buy b group by b.mem_id  having SUM(price*amount) > 1000

select b.mem_id, SUM(b.price*b.amount) as '총 구매 금액' from market_db.buy b group by b.mem_id having SUM(b.price*b.amount) > 1000
order by sum(b.price*b.amount) desc;

select * from market_db.buy b;

select *, count(mem_id) as '멤버 수' from market_db.buy b group by b.mem_id; 
