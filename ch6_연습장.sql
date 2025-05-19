-- 문자열 관련 내장 함수, 오라클에서 미리 만든 기능
-- 우리는 이용하는 부분을 공부함

-- 이름을 모두 대문자로, 소문자, 첫 글자 대문자등 출력
SELECT ENAME, 
UPPER(ENAME) AS "사원명 대문자",
LOWER(ENAME) AS "사원명 소문자",
INITCAP(ENAME) AS "사원명 첫글자 대문자" 
FROM EMP;

-- 사원 이름의 길이, 바이트 수 출력
SELECT ENAME, 
LENGTH(ENAME) AS "사원명 글자 길이",
LENGTHB(ENAME) AS "사원명 바이트 길이" 
FROM EMP;

-- 직문 문자열 안에 'A'가 포함된 위치
SELECT JOB, 
-- 문자열 찾기
INSTR(JOB,'A') AS "A가 몇번째 위치",
-- 문자열 일부 추출
SUBSTR(JOB,1,3) AS "1~3글자 읽기",
-- 문자열 바꾸기
REPLACE(JOB,'CLERK','직원') AS "한글 직무"
FROM EMP;
