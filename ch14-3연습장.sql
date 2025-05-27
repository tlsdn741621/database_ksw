-- 중복 되지 않는 값 UNIQUE 제약 조건

-- 기본 문법 
-- 테이블 생성시 제약 조건 추가 
-- CREATE TABLE 테이블명 (
-- CONSTRAINT: 제약조건명 제약조건종류 (열명),
-- 추가 방법1, 추천 
-- EMAIL VARCHAR2(50) CONSTRAINT email_unique UNIQUE,

-- 추가 방법 1-2 , 이름을 자동으로 생성 -> 예시 -> SYS_C007126(자동 생성 이름)
-- EMAIL VARCHAR2(50) UNIQUE

-- 추가 방법2
-- 테이블을 생성 후, 제약 조건만 따로 추가. 
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건종류 (열명)
ALTER TABLE TABLE_UNIQUE ADD CONSTRAINT email_unique22 UNIQUE (EMAIL);

-- 제약 조건 삭제 
-- ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
ALTER TABLE TABLE_UNIQUE DROP CONSTRAINT email_unique;

-- 제약 조건 확인 
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'TABLE_UNIQUE';

DROP TABLE TABLE_UNIQUE;
CREATE TABLE TABLE_UNIQUE(
    ID NUMBER(5) PRIMARY KEY,
    NAME VARCHAR2(20) NOT NULL,
    -- 수동으로 제약조건의 이름을 만들어서 직접 추가
    EMAIL VARCHAR2(50) CONSTRAINT email_unique UNIQUE
);
SELECT * FROM TABLE_UNIQUE;
-- 제약 조건 확인 
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'TABLE_UNIQUE';
-- 시퀀스 생성 후, 샘플 데이터 추가시, 자동 번호 생성 이용해보기. 
CREATE SEQUENCE TABLE_UNIQUE_SEQ
START WITH 1
INCREMENT BY 1  
MAXVALUE 99999
NOCYCLE;    
-- 시퀀스 생성 확인 
SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'TABLE_UNIQUE_SEQ';
-- 샘플 데이터 추가 
INSERT INTO TABLE_UNIQUE(ID, NAME, EMAIL) VALUES(
    TABLE_UNIQUE_SEQ.NEXTVAL, '홍길동', 'HONG@NAVER.COM');
-- 데이터 조회 
SELECT * FROM TABLE_UNIQUE;    
-- 데이터 중복 방지 확인. 같은 이메일로 확인
INSERT INTO TABLE_UNIQUE(ID, NAME, EMAIL) VALUES(
    TABLE_UNIQUE_SEQ.NEXTVAL, '홍길동2', 'HONG@NAVER.COM');


-- 퀴즈1, 
-- 테이블 생성 시 UNIQUE 지정 해보기, 방법 1, 2,3 
-- 테이블명 :  user_table, 컬럼, user_id에 유니크 설정 
DROP TABLE user_table;
 CREATE TABLE user_table(
    ID NUMBER(5) PRIMARY KEY,
    NAME VARCHAR2(20) NOT NULL,
    -- 방법1
    EMAIL VARCHAR2(50) CONSTRAINT email_unique_mini UNIQUE,
    -- 방법2
    EMAIL2 VARCHAR2(50) UNIQUE,
    EMAIL3 VARCHAR2(50) 

);
-- 방법3
ALTER TABLE user_table ADD CONSTRAINT email_unique_mini2 UNIQUE (EMAIL3);
-- 제약 조건 확인
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER_TABLE';

-- 테이블에 컬럼 추가 user_id
ALTER TABLE user_table ADD USER_ID VARCHAR2(20) UNIQUE;



-- 퀴즈2, 
-- 테이블 생성 후, 제약 조건 추가 , 
-- 테이블명 :  user_table2, 컬럼, user_id에 유니크 설정 
DROP TABLE user_table2;
   CREATE TABLE user_table2(
    ID NUMBER(5) PRIMARY KEY,
    NAME VARCHAR2(20) NOT NULL,
    user_id VARCHAR2(50) NOT NULL
);
ALTER TABLE user_table2 ADD CONSTRAINT email_unique_mini_q2 UNIQUE (user_id);
-- 제약 조건 확인
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER_TABLE2';
-- 퀴즈3, 
-- user_table2 , 시퀀스 생성 후, 자동 번호 생성기를 이용해서, 데이터 입력 . 
-- 중복 테스트도 해보기. 
CREATE SEQUENCE USER_TABLE2_SEQ
START WITH 1
INCREMENT BY 1  
MAXVALUE 99999
NOCYCLE;
-- 시퀀스 생성 확인
SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'USER_TABLE2_SEQ';
-- 샘플 데이터 추가
INSERT INTO user_table2(ID, NAME, USER_ID) VALUES(
    USER_TABLE2_SEQ.NEXTVAL, '홍길동', 'HONG');
-- 데이터 조회
SELECT * FROM user_table2;
-- 샘플 데이터 추가
INSERT INTO user_table2(ID, NAME, USER_ID) VALUES(
    USER_TABLE2_SEQ.NEXTVAL, '홍길동2', 'HONG');

-- 복합키, : 
-- 2개이상의 컬럼을 묶어서, 하나의 키로 사용
-- 하나의 테이블에 pk 보통 하나인 경우가 많아요. 
-- 
-- 기본 문법 
-- 테이블 생성시, 방법1 
-- ```sql
-- CREATE TABLE 주문상세 (
--   주문번호     VARCHAR2(10),
--   상품번호     VARCHAR2(10),
--   수량        NUMBER,
--   CONSTRAINT pk_주문상세 PRIMARY KEY (주문번호, 상품번호)
-- );
-- ```
-- 예시 
-- 주문번호,  상품번호, 수량 
-- 1,          1001(청바지),    2
-- 1,          1002(반팔티),    1
-- 1,          1001(청바지),    2 -- 중복 발생하면 안됨. 

-- * `주문번호 + 상품번호` 조합이 **유일하게** 행을 식별
-- * `수량`은 기본키와 무관한 일반 컬럼

-- 테이블 생성 후, 방법2 
-- ALTER TABLE 주문상세
-- ADD CONSTRAINT pk_주문상세 PRIMARY KEY (주문번호, 상품번호);


--예시 
-- 학생 수강 정보 테이블
-- | 학번   | 과목코드 | 성적 |
-- | ---- | ---- | -- |
-- | 1001 | C001 | A  |
-- | 1001 | C002 | B+ |
-- | 1002 | C001 | B  |-- 중복 발생하면 안됨

-- 학번   | 과목코드  -> 복합키 로 사용함. 
-- CREATE TABLE 학생수강정보 (
--   학번      VARCHAR2(10),
--   과목코드  VARCHAR2(10),
--   성적      CHAR(2),
--   CONSTRAINT pk_학생수강 PRIMARY KEY (학번, 과목코드)
-- );

-- 필요한 상황 
-- 1) 주문번호 + 상품번호 : 주문 내 상품 항목 식별 
--2) 학생 + 과목코드 : 학생의 특정 과목 수강 정보 식별
--3) 도서id + 저자 id : 다대다 관계 테이블에서 많이 사용.