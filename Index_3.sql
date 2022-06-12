-- INDEX 의 생성과 제거 문법

-- INDEX 생성 문법
-- CREATE INDEX 인덱스_이름 ON 테이블_이름 (열_이름) [ASC/DESC (기본은 ASC)];
-- INDEX 생성 시 UNIQUE OPTION 은 주의할 것 UNIQUE 설정 시 중복 값은 안들어가서 이름 같은것 중복 데이터 삽입이 가능하여야 하므로 주의하기

-- CREATE / DROP 은 자동적으로 생성 되는 INDEX 가 아닌 
-- 자동으로 생성되는 INDEX 는 DROP 이 아닌 PRIMARY KEY 를 지워야 함

USE market_db;

SELECT * FROM market_db.`member` m;

-- INDEX CHECK
-- PRIMKARY KEY 가 INDEX 로 지정되어 있음
SHOW INDEX FROM market_db.MEMBER;

-- Data_length 16384 약 16kb 데이터 양이 들어감
SHOW TABLE STATUS LIKE 'member';

-- 단순 인덱스 생성
CREATE INDEX idx_member_addr
	ON market_db.`member` (addr);

SHOW INDEX FROM market_db.MEMBER;

-- ANALYZE 명령어를 입력해 주어야 생성한 index 가 들어감
ANALYZE TABLE market_db.`member`;
-- 보조 인덱스를 적용 후 조회 시 index_length 에도 kb 가 지정이 됨
SHOW TABLE STATUS LIKE 'member';

-- 오류가 발생 UNIQUE 옵션을 주었지만 인원수가 중복 된 사항이 있기에 오류가 발생함
CREATE UNIQUE INDEX idx_member_mem_number
	ON market_db.`member` (mem_number);	-- 오류가 발생함 

-- 사실 UNIQUE 가 만들어지기는 하지만 현재는 중복값이 존재하지않아 값이 들어가기는 하지만 INSERT 할 시 중복값이 입력이 안됨 상당히 위험 함 
-- 반드시 UNIQUE 인 열 값만 UNIQUE 옵션 주기 email 같은 .... unique option 설정 시 INSERT 할 시 값이 INSERT 가 안됨
CREATE UNIQUE INDEX idx_member_mem_name
	ON market_db.`member` (mem_name);

ANALYZE TABLE market_db.`member`;

SHOW INDEX FROM market_db.`member`;

-- 해당 SELET 문은 INDEX 사용하지 않음 왜냐하면 데이터를 전체 다 조회이기에 INDEX 사용 필요가 없음
-- INDEX 를 사용하였는 지 아닌 지는 CRTL + SHIFT + E 를 클릭하면 Execution Plan 을 볼 수 있음

SELECT  * FROM market_db.MEMBER;

-- WHERE 절을 사용하여야 INDEX 를 사용하여서 조회를 함 
SELECT addr FROM market_db.`member` m;

SELECT  m.mem_id, m.mem_name, m.addr FROM market_db.`member` m WHERE m.mem_name = '에이핑크';

CREATE  INDEX idx_member_mem_number
	ON market_db.`member` (mem_number);

-- INDEX 를 사용하여 조회
SELECT m.mem_name, m.mem_number FROM market_db.`member` m WHERE m.mem_number >= 7;

-- 7 이상을 조회 할 떄는 INDEX 를 사용하여 서 조회를 하였지만 1 이상일 때 조회를 할 떄는 INDEX 를 사용하지 않음
-- MySQL 에서 알아서 7 이상일 때 는 INDEX 를 사용하는 것이 효율적이여서 INDEX 를 사용을 하였지만 1 이상일 떄는 INDEX 사용하는 것이 비효율이 비효율적이여서 MYSQL 이 알아서 사용을 하지 않음 
SELECT m.mem_name, m.mem_number FROM market_db.`member` m WHERE m.mem_number >= 1;

-- WHERE 문에 (열 에_ 연산이 들어가면 MySQL 이 알아서 INDEX 를 사용하지 않음 
SELECT m.mem_name, m.mem_number  FROM market_db.`member` m WHERE m.mem_number * 2 >= 14;

-- 가급적 INDEX 를 사용하는 것이 효율적 이므로 열 이름에 가공을 하지않는 것을 권장
-- INDEX 를 사용 원할 시 열에 연산을 넣는 것이 아닌 = 오른쪾 값에 연산을 넣음 (위 랑 결과는 같으므로 연산을 잘 고려하여 설정 하기)
SELECT m.mem_name, m.mem_number  FROM market_db.`member` m WHERE m.mem_number >= 14/2;

-- INDEX 제거 (DROP 문을 이용하여 제거)
DROP INDEX idx_member_mem_name ON market_db.`member` ;

SHOW INDEX FROM market_db.`member`;

-- PRIMARY KEY 삭제를 원할 시 반드시 FOREIGN 키 부터 삭제를 해주어야 함
-- 그렇지 않으면 ERROR 가 발생 함 

-- 해당 DATABASE 에 외래 키 값 들을 볼 수 있음 
SELECT table_name, constraint_name 
  FROM information_schema.REFERENTIAL_CONSTRAINTS rc 
  WHERE CONSTRAINT_SCHEMA = 'market_db';





