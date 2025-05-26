-- 테이블처럼 사용하는 뷰

-- 기본 개념



-- 기본 문법 예시
-- 뷰 생성
CREATE VIEW EMP_VIEW AS -- 뷰 이름 : EMP_VIEW
-- EMP 테이블에서 사원번호, 이름 ,부서번호를 선택 -> 뷰에 넣을 예정
SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE DEPTNO = 10;

-- 데이터 사전이용해서 뷰 정보 확인
SELECT * FROM USER_VIEWS WHERE VIEW_NAME = 'EMP_VIEW';

-- 뷰에서 데이터 조회
SELECT * FROM EMP_VIEW;

-- 뷰 삭제
DROP VIEW EMP_VIEW;

-- 인라인 뷰 사용 예시
SELECT EMPNO, ENAME, SAL FROM EMP; -- 현재 사원 총 19명
SELECT * FROM (
    SELECT EMPNO, ENAME, SAL FROM EMP -- 서브쿼리
) WHERE ROWNUM <= 5; -- 상위 5개 행만 조회

-- ROWNUM 같이 출력하는 예제
SELECT ROWNUM, EMPNO, ENAME, SAL FROM (
    SELECT EMPNO, ENAME, SAL FROM EMP
) WHERE ROWNUM <= 5;

-- WITH 절을 이용한 뷰 예시
WITH EMP_SAL_TOP_3 AS (
    SELECT EMPNO, ENAME, SAL FROM EMP
)
-- 상위 3개 행만 조회
SELECT * FROM EMP_SAL_TOP_3 WHERE ROWNUM <= 3;

-- EMP 테이블에서 부서번호가 20인 사원만 표시하는 뷰 생성
CREATE VIEW EMP_DEPT20_VIEW AS
SELECT EMPNO, ENAME, HIREDATE, DEPTNO FROM EMP WHERE DEPTNO = 20;

-- 뷰에서 데이터 조회
SELECT * FROM EMP_DEPT20_VIEW;

-- 생성된 뷰의 구조 정보 확인
DESC EMP_DEPT20_VIEW;

-- 생성 뷰 삭제
DROP VIEW EMP_DEPT20_VIEW;