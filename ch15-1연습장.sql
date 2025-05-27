-- 사용자 관리, 단순 생성만 했지 다른 권한이 없음
-- 그래서 결론은 접근도 아직은 안된다

-- 사용자 생성 예시
CREATE USER KSW2 IDENTIFIED BY 1234; -- 사용자 생성

-- 사용자 정보 조회
SELECT * FROM ALL_USERS WHERE USERNAME = 'KSW2'; -- 새 사용자 확인
-- 사용자 상태 확인
SELECT USERNAME, ACCOUNT_STATUS, CREATED FROM DBA_USERS WHERE USERNAME = 'KSW2';

-- 사용자 비밀번호 변경
ALTER USER KSW2 IDENTIFIED BY 5678; -- 비밀번호 변경

-- 사용자 삭제
DROP USER KSW2; -- 기본 사용자 삭제
DROP USER KSW2 CASCADE; -- 사용자 삭제 (CASCADE 옵션으로 모든 객체도 삭제)

-- 사용자 권한 부여, 기본 권한, 접근 권한, 자원에 접근하는 권한 2가지 확인
-- CONNECT : 데이터베이스 접속 가능 권한
-- RESOURCE : 자원에 접근 가능 권한, 테이블, 인덱스, 시퀀스 등 객체 생성 권한
GRANT CONNECT TO KSW2; -- 세션 생성 권한 부여
GRANT RESOURCE TO KSW2; -- 자원 접근 권한 부여

-- RESOURCE 권한으로 테이블 생성 가능
 CREATE TABLE user_primay3(
    ID NUMBER(5) ,
    NAME VARCHAR2(20) NOT NULL,
    -- USER_ID VARCHAR2(20) PRIMARY KEY -- 방법1
    -- USER_ID2 VARCHAR2(20) CONSTRAINT user_id_primary PRIMARY KEY -- 방법2
    USER_ID2 VARCHAR2(20) -- 방법3
);

-- SCOTT 계정으로 생성한 테이블 조회. 
SELECT * FROM EMP;


-- 퀴즈1, 
-- SYSTEM 계정에서, LSY3 사용자 생성 , 패스워드 1234
CREATE USER KSW3 IDENTIFIED BY 1234;
-- 퀴즈2, 
-- LSY3 계정에 접근 권한, 자원 권한 부여 
GRANT CONNECT, RESOURCE TO KSW3;
GRANT SELECT ON SCOTT.EMP TO KSW3; -- SCOTT.EMP 테이블 조회 권한 부여
-- 퀴즈3, 
-- 패스워드 5678 변경해보기., 유저 삭제 확인 
ALTER USER KSW3 IDENTIFIED BY 5678;
DROP USER KSW3 CASCADE;