-- 다른 테이블과 관계를 맺는 FOREIGN KEY 제약조건을 추가하는 예제

-- 기본 문법

-- 방법1, 테이블 생성시, 외래키 설정
DROP TABLE emp_fk;
DROP TABLE dept_fk;
-- 테이블 삭제시 자식 테이블 먼저 삭제 후 부모 테이블 삭제
CREATE TABLE dept_fk ( -- 부모 테이블 : 1
  deptno  NUMBER PRIMARY KEY,
  dname   VARCHAR2(20),
  loc     VARCHAR2(20)
);

CREATE TABLE emp_fk ( -- 자식 테이블 : N
  empno   NUMBER PRIMARY KEY,
  ename   VARCHAR2(20),
  deptno  NUMBER,
  -- CONSTRAINT 제약조건_이름 FOREIGN KEY (현재 테이블의 컬럼명:deptno)
  -- REFERENCES (부모테이블: dept_fk) (부모테이블의 컬럼명:deptno)
  CONSTRAINT fk_dept FOREIGN KEY (deptno)  
  REFERENCES dept_fk(deptno)
);
-- 결론, 외래키 설정은 자식 테이블에서 한다

-- 제약조건 확인
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMP_FK';

-- 제약 조건 위배 되는 상황
-- 1) emp_fk 테이블에 데이터를 추가시 부서 번호가 없는 번호를 입력시 오류
-- 샘플 데이터 추가
INSERT INTO dept_fk VALUES(10, '인사부', '서울');
INSERT INTO dept_fk VALUES(20, '개발부', '부산');
SELECT * FROM dept_fk;
INSERT INTO emp_fk VALUES(100, '홍길동', 10); -- 정상
INSERT INTO emp_fk VALUES(101, '이순신', 20); -- 정상
INSERT INTO emp_fk VALUES(102, '강감찬', 30); -- 오류 발생, 30번 부서가 없음
INSERT INTO emp_fk VALUES(102, '강감찬', NULL); -- NULL 입력해보기
SELECT * FROM emp_fk;

-- 자식 테이블에, 외래키 설정시 부모가 데이터가 삭제시 같이 삭제되는 옵션 CASCADE 설정 확인
-- 부모 데이터 삭제시 확인
-- CASCADE 설정 없이 삭제시 오류 발생
DELETE FROM dept_fk WHERE deptno = 10; -- 오류, 10번 부서 삭제

-- 기존 자식 테이블에서 외래키 설정 삭제 후, CASCADE 설정 추가해서 제약조건 다시 설정
ALTER TABLE emp_fk DROP CONSTRAINT fk_dept; -- 외래키 제약조건 삭제

-- 외래키 제약조건 다시 설정, CASCADE 옵션 추가
ALTER TABLE emp_fk ADD CONSTRAINT fk_dept FOREIGN KEY (deptno)
REFERENCES dept_fk(deptno) ON DELETE CASCADE;

-- 삭제 테스트
DELETE FROM dept_fk WHERE deptno = 10; -- 정상, 10번 부서 삭제, 자식 테이블도 같이 삭제
SELECT * FROM emp_fk; -- 10번 부서에 속한 직원도 같이 삭제됨

-- 퀴즈1
-- 부모 테이블 : DEPT_FK2 , 컬럼 : DEPTNO NUMBER PRIMARY KEY , DNAME VARCHAR2(20)
-- 자식 테이블 : EMP_FK2, 컬럼 : EMPNO, ENAME, DEPTNO, 제약조건명 FK_DEPT2
-- 외래키 설정 해보기 방법1으로 해보기
CREATE TABLE DEPT_FK2 (  -- 부모 테이블
    DEPTNO NUMBER PRIMARY KEY,
    DNAME VARCHAR2(20)
);
CREATE TABLE EMP_FK2(    -- 자식 테이블
    EMPNO NUMBER PRIMARY KEY,
    ENAME VARCHAR2(20),
    DEPTNO NUMBER,
    CONSTRAINT FK_DEPT2 FOREIGN KEY (DEPTNO)
    REFERENCES DEPT_FK2(DEPTNO)
);

-- 퀴즈2
-- 제약 조건 위반 확인
-- 1) 부모테이블 먼저 삭제 시도시 오류 확인
-- 2) 추가시, 부모 테이블에 없는 데이터를 추가시 오류 확인
-- 샘플 데이터 추가
INSERT INTO DEPT_FK2 VALUES(10, '개발부');
INSERT INTO DEPT_FK2 VALUES(20, '인사부');
SELECT * FROM DEPT_FK2;
-- 샘플 데이터 추가, 오류 발생
INSERT INTO EMP_FK2 VALUES(100, '홍길동', 10);
INSERT INTO EMP_FK2 VALUES(101, '이순신', 20);
INSERT INTO EMP_FK2 VALUES(102, '강감찬', 30); -- 오류 발생
SELECT * FROM EMP_FK2;
-- 삭제테스트 오류
DELETE FROM DEPT_FK2 WHERE deptno = 10; -- 오류 발생

-- 퀴즈3
-- 3) ON DELETE CASCADE 옵션 설정 및, 삭제확인, 부모데이터 삭제시 자식데이터 삭제 확인 해보기
-- 외래키 제약조건 삭제
ALTER TABLE EMP_FK2 DROP CONSTRAINT FK_DEPT2;
-- 외래키 다시 설정
ALTER TABLE EMP_FK2 ADD CONSTRAINT FK_DEPT2 FOREIGN KEY (DEPTNO)
REFERENCES DEPT_FK2(DEPTNO) ON DELETE CASCADE;
-- 부모 데이터 삭제시 자식 데이터도 같이 삭제 확인
DELETE FROM DEPT_FK2 WHERE DEPTNO = 10; --정상 작동
SELECT * FROM EMP_FK2;