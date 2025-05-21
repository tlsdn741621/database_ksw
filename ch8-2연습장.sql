-- 비등가 조인,
-- 외부 조인(오라클 전용) -> 표준 문법 같이소개

-- 비등가 조인
SELECT E.ENAME, E.SAL, G.GRADE, G.LOSAL, G.HISAL
FROM EMP E, SALGRADE G
WHERE E. SAL BETWEEN G.LOSAL AND G.HISAL;

-- 외부 조인 (오라클전용)
-- 오른쪽 외부 조인,
-- 오른쪽 기준으로, 왼쪽에 값이 없어도 표기하겠다
-- 값이 NULL 이어도 표기 하겠다
SELECT E.ENAME, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);

-- 원본, 자체조인 = 등가조인, MGR = EMPNO
-- NULL 인 경우, 데이터가 누락이됨
-- 왼쪽 내부 조인 M.EMPNO(+)
SELECT E.EMPNO AS"사원번호", E.ENAME AS"사원명", E.MGR AS"상관번호", M.ENAME AS"직속상관명"
FROM EMP E, EMP M WHERE E.MGR = M.EMPNO(+);
-- 오른쪽 내부 조인 E.MGR(+)
SELECT E.EMPNO AS"사원번호", E.ENAME AS"사원명", E.MGR AS"상관번호", M.ENAME AS"직속상관명"
FROM EMP E, EMP M WHERE E.MGR(+) = M.EMPNO;

-- 퀴즈1
-- EMP와 DEPT 테이블에서 부서가 없는 사원도 포함해
-- 사원명과 부서명을 출력하시오 (왼쪽 외부 조인)
SELECT E.ENAME, D.DNAME FROM EMP E, DEPT D WHERE E.DEPTNO = D.DEPTNO(+);
-- 퀴즈2
-- 오른쪽 외부 조인을 사용하여 부서가 있지만
-- 사원이 없는 부서를 포함해서 출력하시오
SELECT E.ENAME, D.DNAME FROM EMP E, DEPT D WHERE E.DEPTNO(+) = D.DEPTNO;
-- 퀴즈3
-- WHERE 절에 추가 조건(`job = 'CLERK'`)을 넣고 부서별 사원 출력
SELECT E.ENAME, D.DNAME, E.JOB FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND E.JOB = 'CLERK';