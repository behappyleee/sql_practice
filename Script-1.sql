select * from sakila.actor;

-- PRIMARY KEY
-- 주요 특성 2 가지 NOT NULL, UNIQUE

-- 데이터 베이스 구축 절차
-- 1) Database 만들기
-- 2) Table 생성 하기

select * from shop_db.`member`;

insert into shop_db.`member` values('tess' , '나훈아', '경기 부천시 중동');
insert into shop_db.`member` values('hero' , '임영웅', '서울 은평구 증산동');
insert into shop_db.`member` values('iyou' , '아이유', '인천 남구 주안동');
insert into shop_db.`member` values('jyp' , '박진영', '경기 고양시 장항동');

insert into shop_db.product  values('바나나', 1500, '2021-07-01', '델몬트', 17);
insert into shop_db.product  values('카스', 2500, '2022-03-01', 'OB', 3);
insert into shop_db.product  values('삼각김밥', 800, '2023-09-01', 'CJ', 22);

select * from shop_db.product p ;
select * from shop_db.`member` m;

select * from shop_db.`member` m where member_name = '머라이어';

-- 데이터베이스 개체
-- 데이터 베이스 안에 들어있을 수 있는 하나의 오브젝트들임 
-- 테이블이 대표적인 데이터베이스 개체임, 
-- 뷰, 인덱스, 프로시져, 트리거

-- 인덱스 (Index)
-- 데이터를 조회 시 빠르게 조회할 수 있도록 도와주는 개체
-- 사실 인덱스는 없어도 크게 상관은 없음 대신 빨리 찾을수 있도록 도움을 줄 수 있음

-- 현재 WHERE 문은 DB 를 전체 다 뒤져 name 이 아이유인 것을 찾아낸 것임 (데이터가 많을 수록 엄청 오래 걸림) 
select * from shop_db.`member` m where m.member_name = '아이유';

-- INDEX 생성 DDL 문 (찾아보기를 만든 것임 책 표지 문 같은 개념)
create index idx_member_name on shop_db.`member`(member_name);

-- INDEX 를 사용하여 찾는 시간을 훨씬 많이 줄여줌 (컨트롤+shift+E 를 함께 눌러 실행 계획으로 확인이 가능)
select * from shop_db.`member` m where m.member_name = '아이유';

-- view 는 가상의 테이블임 (view 는 바로가기 아이콘이랑 비슷한 개념임 )
-- view 가 아니라 Table 에 접근하는 것이랑 동일한 효과를 발생 
-- view 에 접근을 할 시 SELECT 가 작동을 하여 사용자는 TABLE 에 접근하엿다고 착각을 함

-- SELECT 한 결과를 VIW 에 저장 (보안 관련 이슈로도 사용을 하기도 함)
create view member_view
AS
select * from shop_db.`member` m;

-- view 에 접근하여 데이터를 SELECT 함
select * from member_view;

-- stored procedure (SQL 은 프로그래밍 언어가 아니기에 프로그래밍 언어 기능처럼 사용하기 위하여 Stored Procedure 를 사용)
select * from shop_db.`member` m where m.member_name = '나훈아';
select * from shop_db.product p where p.product_name = '삼각김밥';

-- 두 SELECT 기능을 자주 사용한다고 하면 묶어서 stored Procedure 기능을 사용이 가능
-- STORED PROCEDURE 를 만드는 구문 DELIMETER 와 BEGIN / END 를 사용하여 PROCEDURE 를 생성 
DELIMITER //
create procedure myProc()
BEGIN
	select * from shop_db.`member` m where m.member_name = '나훈아';
	select * from shop_db.product p where p.product_name = '삼각김밥';
end // 
DELIMITER;

-- PROCEDURE 호출 하는 방법
call myProc();





















	






