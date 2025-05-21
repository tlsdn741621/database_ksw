-- 서브 쿼리, 쿼리 안에 쿼리

-- 기본 문법 정의

-- WHERE 절 안에 사용하는 서브 쿼리
-- 사원 이름 : JONES 의 급여 보다 많이 받는 사원 출력
-- JONES의 급여를 몰름
SELECT SAL FROM EMP WHERE ENAME = 'JONES';
-- 밖의 쿼리 메인
SELECT * FROM EMP
WHERE SAL > (
-- 서브 쿼리
SELECT SAL FROM EMP WHERE ENAME = 'JONES'
);

-- SELECT 절에 사용하는 서브 쿼리
SELECT ENAME,
(SELECT DNAME FROM DEPT WHERE DEPTNO = EMP.DEPTNO) AS"부서명"
FROM EMP;

-- FROM 절에 사용하는 인라인 뷰
SELECT JOB, AVG(SAL) AS"평균 급여"
FROM(
SELECT * FROM EMP WHERE DEPTNO = 30
)
GROUP BY JOB;

-- 퀴즈1
-- 급여가 2975 보다 높은 사원의 이름과 급여를 출력하시오
SELECT ENAME AS"사원명", SAL AS"급여" FROM EMP
WHERE SAL > 2975;
-- 퀴즈2
-- JONES 보다 급여가 높은 사원의 이름과 급여를 출력하시오
SELECT ENAME AS"사원명", SAL AS"급여" FROM EMP
WHERE SAL > (
SELECT SAL FROM EMP WHERE ENAME = 'JONES'
);
-- 퀴즈3 메인 쿼리에 서브 쿼리 이용해서, 부서명 출력
-- DEPT 테이블의 부서명 표시
SELECT ENAME AS"사원명", (
SELECT DNAME FROM DEPT WHERE DEPTNO = EMP.DEPTNO
) AS"부서명"
FROM EMP;