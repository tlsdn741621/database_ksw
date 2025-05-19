-- where 기본 문법 확인
-- WHERE  조건식(TRUE) 일 경우의 행만 출력
-- 부서 번호가 30인 경우
SELECT * FROM EMP WHERE DEPTNO = 30;

-- 직무(JOB)가 'SALESMAN' 인 사원 조회
SELECT * FROM EMP WHERE JOB = 'SALESMAN';

-- 퀴즈1
-- 급여가(SAL) 2000 이상인 사원만 조회하기
SELECT * FROM EMP WHERE SAL >= 2000 ORDER BY SAL;
-- 퀴즈2
-- 입사일(HIREDATE)이 '1981-02-20' 이후인 사원만 조회하기
-- 날짜가 이후이면 값으로 치면 큰값, 최신이다
SELECT * FROM EMP WHERE HIREDATE > '1981-02-20' ORDER BY HIREDATE DESC;
-- 퀴즈3
-- 부서 번호가 10이 아닌 사원만 조회하기
-- 아니다는 표현인 일단 '<>'로 표기 하기
SELECT * FROM EMP WHERE DEPTNO <> 10 ORDER BY DEPTNO ASC;

SELECT * FROM EMP WHERE DEPTNO != 10 ORDER BY DEPTNO ASC;

-- 괄호가 없는 경우
-- AND가 OR보다 우선순위가 높습니다
-- 괄호가 있는 경우
-- 괄호 안의 조건이 먼저 계산됩니다.
SELECT * FROM EMP WHERE DEPTNO = 30 AND JOB = 'SALESMAN';

-- OR 조건
-- 하나라도 만족하면 출력됨
-- JOB 가 CLERK 또는 MANAGER 인 사원 출력해보기
SELECT * FROM EMP WHERE JOB = 'CLERK' OR JOB = 'MANAGER';

-- 괄호 사용 (우선순위 명확히 하기)
-- 부서 번호가 10 또는 20 이고, 급여가 2000 초과인 경우
SELECT * FROM EMP WHERE (DEPTNO = 10 OR DEPTNO = 20) AND SAL > 2000;

-- 퀴즈1
-- 급여가 1500 이상이고 커미션이 NULL이 아닌 사원만 조회
-- 힌트 NULL이 아닌 표현 : IS NOT NULL
SELECT * FROM EMP WHERE SAL >= 1500 AND COMM IS NOT NULL;
-- 퀴즈2
-- 직무가 'SALESMAN' 이거나 급여가 3000 이상인 사원 출력
SELECT * FROM EMP WHERE JOB = 'SALESMAN' OR SAL >= 3000;
-- 퀴즈3
-- 부서번호가 10,20,30 중 하나이고 급여가 2000 이상인 사원 출력
-- 힌트 10,20,30 중 하나 표현 IN :(10, 20, 30)이용
-- OR 조건을 간단히 하기 위해서
-- 컬럼명 IN (값1, 값2, 값3 등...)
-- 컬럼명의 조건이 IN 안의 값을 하나라도 만족한다면 TRUE
SELECT * FROM EMP WHERE (DEPTNO = 10 OR DEPTNO = 20 OR DEPTNO = 30) AND SAL >= 2000;
-- IN 연산자 이용해서 표현해보기
SELECT * FROM EMP WHERE DEPTNO IN (10, 20, 30) AND SAL >= 2000;

----------------------------------------------------------------------------------
-- 5-3 연산자 종류와 활용 기본
-- 산술 연산자
SELECT ENAME, SAL * 12 AS "기본 연봉" FROM EMP;

-- 비교 연산자
SELECT * FROM EMP WHERE SAL >= 2000;

-- 문자 비교 (1글자 VS 여러글자)
-- L 보다 뒤에, 사전식 기준 생각하기
SELECT * FROM EMP WHERE ENAME > 'L';
-- 여러글자 , 순서대로 앞의 글자 비교하고 다음글자 비교
SELECT * FROM EMP WHERE ENAME < 'MILLER';

-- 등가 비교 연산자
-- !=, <> , ^=
-- JOB CLERK 이 아닌 사원만 출력 해보기
SELECT * FROM EMP WHERE JOB != 'CLERK';
SELECT * FROM EMP WHERE JOB <> 'CLERK';
SELECT * FROM EMP WHERE JOB ^= 'CLERK';

-- NOT 연산자
-- JOB 이 MANAGER 가 아닌 사원만 출력 해보기
SELECT * FROM EMP WHERE NOT JOB = 'MANAGER';

-- IN 연산자 (NOT 포함 버전) 
-- OR 을 간결히 사용하기
-- 컬럼명 IN (값1,값2,값3,...)
-- 컬럼의 값이 IN 연산자안의 값을 만족하면 TRUE
-- 부서 번호가 10, 30이 아닌 사원을 출력해보기
SELECT * FROM EMP WHERE DEPTNO NOT IN(10,30);

-- BETWEEN A AND B
-- 급여가 1100 이상 3000 이하 인 사원 출력 해보기
SELECT * FROM EMP WHERE SAL BETWEEN 1100 AND 3000;

--위의 경우의 반대인 경우
SELECT * FROM EMP WHERE SAL NOT BETWEEN 1100 AND 3000;

-- LIKE 연산자
-- 컬럼명 LIKE '조건식'
-- % : 모든글자
-- (_)언더바 : 특정 글자 수
-- 사원명이 S로 시작하는 사원 출력 해보기
SELECT * FROM EMP WHERE ENAME LIKE 'S%';

-- 사원명이 두 번째 글자가 L을 포함하는 사원 출력하기
SELECT *FROM EMP WHERE ENAME LIKE '_L%';

-- 사원명이 AM 글자를 포함하는 사원 출력하기
SELECT * FROM EMP WHERE ENAME LIKE '%AM%';

-- 위의 경우, 반대
SELECT * FROM EMP WHERE ENAME NOT LIKE '%AM%';

-- IS NULL 널 조건이기? / IS NOT NULL 널이 아닌 조건이니?
-- 커미션이 널인 사원만 출력하기
SELECT * FROM EMP WHERE COMM IS NULL;
-- 위의 경우 반대인 경우
SELECT * FROM EMP WHERE COMM IS NOT NULL;

-- AND + IS NULL
-- JOB가 SALESMAN 이고 COMM 이 널 인사원만 출력
SELECT * FROM EMP WHERE JOB = 'SALESMAN' AND COMM IS NULL;
-- 위의 경우 반대
SELECT * FROM EMP WHERE JOB = 'SALESMAN' AND COMM IS NOT NULL;

-- OR + IS NULL
-- JOB MANAGER 이거나 MGR(직속상관)이 NULL 인 사원 출력하기
SELECT *FROM EMP WHERE JOB = 'MANAGER' OR MGR IS NULL;

-- 집합 연산자
-- 1 UNION 중복 제거
-- JOB MANAGER 이거나, DEPTNO 10인 사원 출력하기
SELECT ENAME,JOB,DEPTNO FROM EMP WHERE JOB = 'MANAGER'
UNION
SELECT ENAME,JOB,DEPTNO FROM EMP WHERE DEPTNO = 10;