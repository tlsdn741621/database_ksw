select * from dept;
select * from emp;
select * from salgrade;

desc emp;
desc dept;
desc salgrade;

select * from emp;
--오라클 sql developer 에서 주석 (-)2번입니다.
--행 기준으로 검색, where 조건 이용
select * from emp where job = 'manager';
select * from emp where job = 'MANAGER';

-- 열기준으로 프로젝션 , 보고 싶은 열만 선택해서 조회해보기
select ename, job from emp where job = 'MANAGER';
select ename, job from emp;

--기본 퀴즈1
-- 셀력션 - 'SALES' 부서 소속 직원만 조회
select * from emp where deptno = '30';
--기본 퀴즈2
-- 프로젝션 - 사원명과 입사일만 조회
select ename, hiredate from emp;
--기본 퀴즈3
-- 급여가 3000 이상인 직원만 조회
select * from emp where sal >= '3000';
--기본 퀴즈4
-- EMP 테이블에서 이름(ename), 급여(sal), 부서번호(deptno)만 조회 해보기
select ename, sal, deptno from emp;

---------------------------------------------------------------------
--distinct 중복 제거
select distinct job from emp;

--all(생략가능, 기본값), 중복 포함
select all job from emp;
select job from emp;

-- 직무 + 부서 번호 조합의 고유 데이터 적출
-- JOB 직무, 부서 번호 조합의 중복 되지 않는 행만 조회
-- 결론, 동일한 직무와 동일한 부서 번호를 가진 직원이
-- 여러명 있어도 한번만 결과에 나타남
select DISTINCT JOB, DEPTNO FROM EMP;
select JOB, DEPTNO FROM EMP;
--주의사항
-- 1 DISTINCT 는 SELECT 문 뒤에 위치를 하고
-- 2 하나의 컬럼에 적용 되는게 아니라, 예시 2개의 컬럼이 하나처럼 취급이 되어서 동작

--퀴즈1
-- EMP 테이블에서 중복되지 않는 부서번호만 출력하기
SELECT DISTINCT DEPTNO FROM EMP;
--퀴즈2
-- EMP 테이블에서 사원 직무와 부서 번호 조합이 고유한 결과 한번더 해보기
SELECT DISTINCT JOB, DEPTNO FROM EMP;
--퀴즈3
-- EMP 테이블에서 중복을 제거하지 않고
--사원 직무와 부서 번호를 모두 출력하기
--ALL 키워드 이용해보기
SELECT ALL JOB, DEPTNO FROM EMP;

----------------------------------------------------------------------------
--ALIAS 별칭 사용해보기
SELECT ENAME AS "사원명" FROM EMP;
SELECT ENAME AS "직원 이름" FROM EMP;
SELECT ENAME "직원 이름2" FROM EMP;
SELECT ENAME AS "사원명", SAL * 12 AS "연봉" FROM EMP;

--퀴즈1
-- EMP 테이블에서 사원 이름에 '각자 정하고 싶은 이름' 별칭을 부여해서 출력해보기
SELECT EMPNO AS "사원번호", ENAME AS "사원명", JOB AS "직무", MGR AS "관리번호",
HIREDATE AS "입사일", SAL AS "급여", COMM AS "보너스", DEPTNO AS "부서번호" FROM EMP;
--퀴즈2
-- EMP 테이블에서 급여(SAL)를 연봉으로 계산해서 출력해보기 한번더
SELECT ENAME AS "사원명", SAL * 12 AS "연봉" FROM EMP;
--퀴즈3
-- 사원명과 직무를 각각 '사원이름','직무'로 출력해보기
SELECT ENAME AS "사원이름", JOB AS "직무" FROM EMP;
--퀴즈4
-- 사원명과 급여, 그리고 커미션(COMM)이 있을 경우 총 수입을 계산하기 
-- 출력 별칭은 "총 급여"로 지정해서 출력
-- 특정 옵션 함수 NVL(COMM,0):COMM 있으면, COMM 값으로 출력
-- 특정 옵션 함수 NVL(COMM,0):COMM 없으면, 0 값으로 출력
SELECT ENAME AS "사원명",SAL AS "급여",COMM AS "커미션",SAL * 12 AS "연봉", SAL * 12 + NVL(COMM,0) AS "총 급여" FROM EMP;