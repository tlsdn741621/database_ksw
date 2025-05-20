-- 날짜 데이터를 다루는 내장 함수

-- 현재 날짜
SELECT SYSDATE FROM DUAL;

-- 3개월 후
SELECT ADD_MONTHS(SYSDATE, 3) FROM DUAL;

-- 개월 차이
SELECT MONTHS_BETWEEN(SYSDATE, HIREDATE) FROM EMP;

-- 다음 금요일, 요일 선택 부분에 서버의 언어맞게 설정하기
SELECT NEXT_DAY(SYSDATE, '금요일') FROM DUAL;

-- 이번달 말일
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- 날짜 반올림 / 버림
SELECT ROUND(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'MONTH') FROM DUAL;

-- 입사일 10주년 구하기
SELECT ENAME, ADD_MONTHS(HIREDATE, 120) AS "10주년" FROM EMP;

-- 퀴즈1
-- 입사일로 부터 32년이 지난 사원만 출력해보기
SELECT * FROM EMP WHERE ADD_MONTHS(HIREDATE, 384) < SYSDATE;
SELECT * FROM EMP WHERE MONTHS_BETWEEN(SYSDATE,HIREDATE) > 384;
-- 퀴즈2
-- 사원별로 입사일 기준 다음 월요일 출력해보기
SELECT ENAME, HIREDATE, NEXT_DAY(HIREDATE, '월요일') AS "다음 월요일" FROM EMP;
-- 퀴즈3
-- 사원의 입사일을 월 단위로 반올림 해서 출력 해보기
SELECT ENAME, HIREDATE, ROUND(HIREDATE, 'MONTH') AS "반올림일자" FROM EMP;

-- SYSDATE 시간까지 출력
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
-- 오라클 시간 동기화
-- 도커 데스크톱 실행 후
-- 도커 데스크톱 -> 컨테이너 아이디 복사
-- 예시
-- 1d2573726ddc7a2085c23425fa05da421469165192a3092f1ebc62e048a6ac46
-- 터미널에서 해보기
-- 마이크로 소프트의 스토어 -> 터미널 설치
-- docker exec -it 컨테이너 아이디 복사 /bin/bash
-- docker exec -it 1d2573726ddc7a2085c23425fa05da421469165192a3092f1ebc62e048a6ac46 /bin/bash
-- dpkg-reconfigure tzdata
-- 만약 안될경우1, apt-get update
-- 만약 안될경우2, apt-get install --reinstall tzdata

-- 6 asis, 선택
-- 69 seoul 선택 

-- date, 명령어 확인