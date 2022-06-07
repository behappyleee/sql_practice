-- INSERT / UPDATE
-- SELECT 는 Data 를 가져와서 보는 것으로 Data 가 변경 되지 않음

-- INSERT 는 데이터를 입력
-- 문법 : INSERT INTO [열1, 열2 ...] VALUES(값1, 값2 ...)

use market_db;

create table hongong1 (toy_id INT, toy_name CHAR(4) , age INT );

-- INSERT 시 입력 행 생략 가능 행 입력 시 행과 입력 값 순서 맞춰주어야 함 

insert into hongong1 VALUES(1, '우디', 25);

insert into hongong1(toy_id, toy_name) VALUES(2, '버즈');

insert into hongong1(toy_name, age, toy_id) VALUES('제시' , 20, 3);

create table hongong2 (
	-- AUTO_INCREMENT 는 반드시 PRIMARY KEY 에 지정
	-- AUTO_INCREMENT 는 번호는 의미 없고 그냥 1씩 늘어 남 
	toy_id INT auto_increment primary key,
	toy_name CHAR(4),
	AGE INT
)

insert into hongong2 VALUES(null, '보팝', 25);
insert into hongong2 VALUES(null, '슬링키', 22);
insert into hongong2 VALUES(null, '렉스', 21);

-- 마지막 AUTO_INCREMENT 가 언제 인지 알고 싶을 떄 다음 스크립트 실행
select last_insert_id(); 

-- 다음 스크립트는 AUTO_INCREMENT 를 100 으로 변경 함 
-- 처음부터 AUTO_INCREMENT 입력 값 을 입력 시 다음 값부터 카운트
alter table hongong2 auto_increment= 100;

-- 다음 스크립트는 auto_increment 시 간격을 3으로 맞추어 주면서 AUTO_INCREMENT 가 됨
set @@auto_increment_increment = 3;

insert into hongong2 VALUES(null, '토마스', 20);
insert into hongong2 VALUES(null, '제임스', 23);
insert into hongong2 VALUES(null, '고든', 25);

select * from hongong2;

-- 문법 INSERT INTO 테이블_이름 (열_이름1, 열_이름 2) SELECT ~ SELECT 한 값을 모두 집어 넣음

select count(*) from world.city c;

-- DESC 는 테이블에 구조를 알려주는 명령어
desc world.city ;

select * from world.city c limit 5;

create table city_popul(city_name CHAR(35), population INT);

-- INSER ~ SELECT 문 이용시 SELECT 한 데이터를 INSERT 를 할 수 있다
insert into city_popul 
	select name, population from world.city;















