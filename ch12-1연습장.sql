-- 객체(테이블)를 생성, 변경, 삭제하는 데이터 정의어

-- CREATE : 객체를 생성하는 명령어
-- ALTER : 객체를 변경하는 명령어
-- DROP : 객체를 삭제하는 명령어
-- TRUNCATE : 테이블의 데이터를 삭제하는 명령어

-- 테이블 이름 명명, 각각 언어의 예약어를 사용하면 안됨. 주의사항
create table member (
   member_id    number(5) primary key,  -- PK = NOT NULL + UNIQUE(중복 불가)
   member_name  varchar2(20) not null, -- 값이 비어있으면 안됨
   member_email varchar2(50) not null
);
select *
  from member_info;
-- 샘플 데이터 추가
insert into member_info (
   member_id,
   member_name,
   member_email
) values ( 1,
           '홍길동',
           'HONG@NAVER.COM' );
insert into member_info (
   member_id,
   member_name,
   member_email
) values ( 2,
           '이순신',
           'LEE@NAVER.COM' );
insert into member_info (
   member_id,
   member_name,
   member_email
) values ( 3,
           '강감찬',
           'KANG@NAVER.COM' );

-- 테이블 구조 변경
alter table member add member_phone varchar(20);

-- 테이블 이름 변경하기
alter table member rename to member_info;

-- 테이블의 내용만 전체 삭제하기 -> 빈 테이블만 남음
truncate table member_info;

-- 테이블 삭제하기
drop table member_info;

-- 퀴즈1
-- 테이블 : BOARD , 컬럼 : BOARD_ID(NUMBER 5), BOAR_TITLE VARCHAR(30), 
-- BOARD_CONTENT VARCHAR(300), BOARD_WRITER VARCHAR(30), BOARD_REGDATE VARCHAR(DATE)
create table board (
   board_id      number(5) primary key,
   board_title   varchar(30),
   board_content varchar(300),
   board_writer  varchar(30),
   board_regdate date default sysdate
);
-- 퀴즈2, ALTER ~ MODIFY
-- BOARD 테이블에 특정 컬럼의 타입 변경해보기 (WRITER VARCHAR2 40 으로 변경)
alter table board modify
   board_writer varchar2(40);
-- 퀴즈3
-- BOARD 테이블에, 내용만 삭제 해보기
truncate table board;
insert into board (
   board_id,
   board_title,
   board_content,
   board_writer,
   board_regdate
) values ( 1,
           '강신우',
           '반갑습니다',
           '우',
           sysdate );
select *
  from board;