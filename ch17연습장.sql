-- copilot, GPT , ai 툴을 이용해서, 

-- 샘플 디비 설계, (쇼핑몰 예시)
-- ERD 다이어그램 확인. 
-- 시퀀스 다이어그램 확인. 
-- DFD 다이어그램 확인.

-- 샘플 디비 설계, 쇼핑몰을 예시로 해서, 
-- 간단한 프롬프트 명령어를 작성 해보기. 

-- 예시 
-- 간단한 쇼핑몰 DB 설계를 할거야, 
-- 생각한 테이블은 사용자, 게시글, 댓글, 상품, 장바구니, 주문, 결제, 배송
-- 중간 테이블 (장바구니에 담긴 상품), (주문된 상품)등도 고려해줘. 
-- 혹시나 빠진 중간 테이블이 있다면, 추가도 해줘. 
-- 설계한 코드는 DDL.sql 파일로 제공해주고, 
-- create 코드 형식으로 코드 알려줘

-- 1차 견본, 받은 후
-- 사용자 테이블
-- drop table USERS;
CREATE TABLE USERS (
    USER_ID NUMBER PRIMARY KEY,
    USERNAME VARCHAR2(50) NOT NULL,
    PASSWORD VARCHAR2(100) NOT NULL,
    EMAIL VARCHAR2(100) UNIQUE NOT NULL,
    CREATED_AT DATE DEFAULT SYSDATE
);

-- 게시글 테이블
-- drop table POSTS;
CREATE TABLE POSTS (
    POST_ID NUMBER PRIMARY KEY,
    USER_ID NUMBER REFERENCES USERS(USER_ID),
    TITLE VARCHAR2(200) NOT NULL,
    CONTENT CLOB,
    CREATED_AT DATE DEFAULT SYSDATE
);

-- 댓글 테이블
-- drop table COMMENTS;
CREATE TABLE COMMENTS (
    COMMENT_ID NUMBER PRIMARY KEY,
    POST_ID NUMBER REFERENCES POSTS(POST_ID),
    USER_ID NUMBER REFERENCES USERS(USER_ID),
    CONTENT VARCHAR2(1000),
    CREATED_AT DATE DEFAULT SYSDATE
);

-- 상품 테이블
-- drop table PRODUCTS;
CREATE TABLE PRODUCTS (
    PRODUCT_ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(100) NOT NULL,
    DESCRIPTION CLOB,
    PRICE NUMBER(10,2) NOT NULL,
    STOCK NUMBER DEFAULT 0,
    CREATED_AT DATE DEFAULT SYSDATE
);

-- 장바구니 테이블
-- drop table CARTS;
CREATE TABLE CARTS (
    CART_ID NUMBER PRIMARY KEY,
    USER_ID NUMBER REFERENCES USERS(USER_ID),
    CREATED_AT DATE DEFAULT SYSDATE
);

-- 장바구니에 담긴 상품 (중간 테이블)
-- drop table CART_ITEMS;
CREATE TABLE CART_ITEMS (
    CART_ITEM_ID NUMBER PRIMARY KEY,
    CART_ID NUMBER REFERENCES CARTS(CART_ID),
    PRODUCT_ID NUMBER REFERENCES PRODUCTS(PRODUCT_ID),
    QUANTITY NUMBER DEFAULT 1
);

-- 주문 테이블
-- drop table ORDERS;
CREATE TABLE ORDERS (
    ORDER_ID NUMBER PRIMARY KEY,
    USER_ID NUMBER REFERENCES USERS(USER_ID),
    ORDER_DATE DATE DEFAULT SYSDATE,
    STATUS VARCHAR2(50)
);

-- 주문된 상품 (중간 테이블)
-- drop table ORDER_ITEMS;
CREATE TABLE ORDER_ITEMS (
    ORDER_ITEM_ID NUMBER PRIMARY KEY,
    ORDER_ID NUMBER REFERENCES ORDERS(ORDER_ID),
    PRODUCT_ID NUMBER REFERENCES PRODUCTS(PRODUCT_ID),
    QUANTITY NUMBER DEFAULT 1,
    PRICE NUMBER(10,2) NOT NULL
);

-- 결제 테이블
-- drop table PAYMENTS;
CREATE TABLE PAYMENTS (
    PAYMENT_ID NUMBER PRIMARY KEY,
    ORDER_ID NUMBER REFERENCES ORDERS(ORDER_ID),
    AMOUNT NUMBER(10,2) NOT NULL,
    PAYMENT_DATE DATE DEFAULT SYSDATE,
    PAYMENT_METHOD VARCHAR2(50)
);

-- 배송 테이블
-- drop table DELIVERIES;
CREATE TABLE DELIVERIES (
    DELIVERY_ID NUMBER PRIMARY KEY,
    ORDER_ID NUMBER REFERENCES ORDERS(ORDER_ID),
    ADDRESS VARCHAR2(300) NOT NULL,
    DELIVERY_STATUS VARCHAR2(50),
    DELIVERY_DATE DATE
);

-- (추가) 찜(위시리스트) 테이블
-- drop table WISHLISTS;
CREATE TABLE WISHLISTS (
    WISHLIST_ID NUMBER PRIMARY KEY,
    USER_ID NUMBER REFERENCES USERS(USER_ID),
    CREATED_AT DATE DEFAULT SYSDATE
);
-- drop table WISHLIST_ITEMS;
CREATE TABLE WISHLIST_ITEMS (
    WISHLIST_ITEM_ID NUMBER PRIMARY KEY,
    WISHLIST_ID NUMBER REFERENCES WISHLISTS(WISHLIST_ID),
    PRODUCT_ID NUMBER REFERENCES PRODUCTS(PRODUCT_ID)
);

-- 누락된 부분, 또는 테스트나 검증등을 해서 수정될 가능성이 있음. 
-- 예시
-- 제공 해준 테이블을 이용해서, 샘플 데이터를 추가하는 예시를 제공해줘 
-- 각각의 모든 테이블을 검사 할수 있는 샘플 데이터를 추가하는 예시코드 
-- 추가하는 명령어, 조회 명령어도 같이 첨부해줘 

-- 샘플 데이터 추가 예시 및 조회 예시

-- USERS
INSERT INTO USERS (USER_ID, USERNAME, PASSWORD, EMAIL) VALUES (1, 'USER1', 'PASS1', 'USER1@EXAMPLE.COM');
SELECT * FROM USERS;

-- PRODUCTS
INSERT INTO PRODUCTS (PRODUCT_ID, NAME, DESCRIPTION, PRICE, STOCK) VALUES (1, 'PRODUCT1', 'DESC1', 10000, 10);
SELECT * FROM PRODUCTS;

-- POSTS
INSERT INTO POSTS (POST_ID, USER_ID, TITLE, CONTENT) VALUES (1, 1, 'TITLE1', 'CONTENT1');
SELECT * FROM POSTS;

-- COMMENTS
INSERT INTO COMMENTS (COMMENT_ID, POST_ID, USER_ID, CONTENT) VALUES (1, 1, 1, 'COMMENT1');
SELECT * FROM COMMENTS;

-- CARTS
INSERT INTO CARTS (CART_ID, USER_ID) VALUES (1, 1);
SELECT * FROM CARTS;

-- CART_ITEMS
INSERT INTO CART_ITEMS (CART_ITEM_ID, CART_ID, PRODUCT_ID, QUANTITY) VALUES (1, 1, 1, 2);
SELECT * FROM CART_ITEMS;

-- ORDERS
INSERT INTO ORDERS (ORDER_ID, USER_ID, STATUS) VALUES (1, 1, 'ORDERED');
SELECT * FROM ORDERS;

-- ORDER_ITEMS
INSERT INTO ORDER_ITEMS (ORDER_ITEM_ID, ORDER_ID, PRODUCT_ID, QUANTITY, PRICE) VALUES (1, 1, 1, 2, 20000);
SELECT * FROM ORDER_ITEMS;

-- PAYMENTS
INSERT INTO PAYMENTS (PAYMENT_ID, ORDER_ID, AMOUNT, PAYMENT_METHOD) VALUES (1, 1, 20000, 'CARD');
SELECT * FROM PAYMENTS;

-- DELIVERIES
INSERT INTO DELIVERIES (DELIVERY_ID, ORDER_ID, ADDRESS, DELIVERY_STATUS) VALUES (1, 1, 'SEOUL', 'SHIPPED');
SELECT * FROM DELIVERIES;

-- WISHLISTS
INSERT INTO WISHLISTS (WISHLIST_ID, USER_ID) VALUES (1, 1);
SELECT * FROM WISHLISTS;

-- WISHLIST_ITEMS
INSERT INTO WISHLIST_ITEMS (WISHLIST_ITEM_ID, WISHLIST_ID, PRODUCT_ID) VALUES (1, 1, 1);
SELECT * FROM WISHLIST_ITEMS;

-- 검사 도구로, 다이어그램 등을 이용해서 그림으로 확인.

-- 아래 사이트에서, 그림 도식화 할 예정
-- https://gist.github.com/
-- .MD 파일에, MERMAID 라는 문법을 통해서, ERD 그림을 그리기

-- 예시, 연속적으로 작업 하는 중이라서, 이미 코파일럿 메모리에 작성된 테이블이 있다는 가정하에
-- 만약, 연속 작업이 아니라고 한다면, 실제 테이블을 같이 복사를 하고 물어보기

-- 현재는, 연속적인 상황이라서, 이렇게만 질의하기
-- 위에 작성된 ddl.sql 파일, create 테이블을 참고해서
-- mermaid 문법으로, erd 다이어그램 작성하는 코드 생성해줘

-- 1차 결과 코드에서, 앞쪽에 ` 백티 3개가 있고, 맨 마지막에도 ` 백티 3개있음
-- 여기서 마지막 백틱 3개는 삭제

```mermaid
erDiagram
    USERS {
        NUMBER USER_ID PK
        VARCHAR2 USERNAME
        VARCHAR2 PASSWORD
        VARCHAR2 EMAIL
        DATE CREATED_AT
    }
    POSTS {
        NUMBER POST_ID PK
        NUMBER USER_ID FK
        VARCHAR2 TITLE
        CLOB CONTENT
        DATE CREATED_AT
    }
    COMMENTS {
        NUMBER COMMENT_ID PK
        NUMBER POST_ID FK
        NUMBER USER_ID FK
        VARCHAR2 CONTENT
        DATE CREATED_AT
    }
    PRODUCTS {
        NUMBER PRODUCT_ID PK
        VARCHAR2 NAME
        CLOB DESCRIPTION
        NUMBER PRICE
        NUMBER STOCK
        DATE CREATED_AT
    }
    CARTS {
        NUMBER CART_ID PK
        NUMBER USER_ID FK
        DATE CREATED_AT
    }
    CART_ITEMS {
        NUMBER CART_ITEM_ID PK
        NUMBER CART_ID FK
        NUMBER PRODUCT_ID FK
        NUMBER QUANTITY
    }
    ORDERS {
        NUMBER ORDER_ID PK
        NUMBER USER_ID FK
        DATE ORDER_DATE
        VARCHAR2 STATUS
    }
    ORDER_ITEMS {
        NUMBER ORDER_ITEM_ID PK
        NUMBER ORDER_ID FK
        NUMBER PRODUCT_ID FK
        NUMBER QUANTITY
        NUMBER PRICE
    }
    PAYMENTS {
        NUMBER PAYMENT_ID PK
        NUMBER ORDER_ID FK
        NUMBER AMOUNT
        DATE PAYMENT_DATE
        VARCHAR2 PAYMENT_METHOD
    }
    DELIVERIES {
        NUMBER DELIVERY_ID PK
        NUMBER ORDER_ID FK
        VARCHAR2 ADDRESS
        VARCHAR2 DELIVERY_STATUS
        DATE DELIVERY_DATE
    }
    WISHLISTS {
        NUMBER WISHLIST_ID PK
        NUMBER USER_ID FK
        DATE CREATED_AT
    }
    WISHLIST_ITEMS {
        NUMBER WISHLIST_ITEM_ID PK
        NUMBER WISHLIST_ID FK
        NUMBER PRODUCT_ID FK
    }

    USERS ||--o{ POSTS : "writes"
    USERS ||--o{ COMMENTS : "writes"
    USERS ||--o{ CARTS : "has"
    USERS ||--o{ ORDERS : "places"
    USERS ||--o{ WISHLISTS : "has"
    POSTS ||--o{ COMMENTS : "has"
    PRODUCTS ||--o{ CART_ITEMS : "in"
    PRODUCTS ||--o{ ORDER_ITEMS : "ordered"
    PRODUCTS ||--o{ WISHLIST_ITEMS : "wished"
    CARTS ||--o{ CART_ITEMS : "contains"
    ORDERS ||--o{ ORDER_ITEMS : "contains"
    ORDERS ||--o{ PAYMENTS : "paid by"
    ORDERS ||--o{ DELIVERIES : "delivered by"
    WISHLISTS ||--o{ WISHLIST_ITEMS : "contains"

-- gist.github.com 사이트 접속, 로그인
-- README.md 파일을 만들어서
-- 위의 코드를 복사할 예정

-- 같은 형식으로
-- 2) DFD 다이어그램 코드 만들어줘
```mermaid
flowchart TD
    사용자((사용자))
    게시글((게시글))
    댓글((댓글))
    상품((상품))
    장바구니((장바구니))
    장바구니상품((장바구니에 담긴 상품))
    주문((주문))
    주문상품((주문된 상품))
    결제((결제))
    배송((배송))
    찜((찜))
    찜상품((찜한 상품))

    사용자 -- 게시글 작성 --> 게시글
    사용자 -- 댓글 작성 --> 댓글
    게시글 -- 댓글 포함 --> 댓글
    사용자 -- 장바구니 생성 --> 장바구니
    장바구니 -- 상품 담기 --> 장바구니상품
    장바구니상품 -- 상품 정보 --> 상품
    사용자 -- 주문 생성 --> 주문
    주문 -- 주문상품 포함 --> 주문상품
    주문상품 -- 상품 정보 --> 상품
    주문 -- 결제 요청 --> 결제
    주문 -- 배송 요청 --> 배송
    사용자 -- 찜 생성 --> 찜
    찜 -- 찜상품 포함 --> 찜상품
    찜상품 -- 상품 정보 --> 상품

-- 3) 시퀀스 다이어그램 코드 만들어줘 
-- 앞쪽에 (`) 백티 3개 있고, 맨 마지막에도 (`) 백티 3개 있음
-- 여기서 마지막 백틱 3개는 삭제 .
```mermaid
sequenceDiagram
    participant 사용자
    participant 웹사이트
    participant 장바구니
    participant 상품
    participant 주문
    participant 결제
    participant 배송

    사용자->>웹사이트: 상품 목록 조회
    웹사이트->>상품: 상품 정보 요청
    상품-->>웹사이트: 상품 정보 반환
    웹사이트-->>사용자: 상품 목록 표시

    사용자->>장바구니: 상품 담기 요청
    장바구니->>상품: 상품 정보 확인
    상품-->>장바구니: 상품 정보 반환
    장바구니-->>사용자: 장바구니 담기 완료

    사용자->>주문: 주문 생성 요청
    주문->>장바구니: 장바구니 상품 확인
    장바구니-->>주문: 장바구니 상품 정보 반환
    주문-->>사용자: 주문 생성 완료

    사용자->>결제: 결제 요청
    결제->>주문: 주문 정보 확인
    결제-->>사용자: 결제 완료

    사용자->>배송: 배송 요청
    배송->>주문: 주문 정보 확인
    배송-->>사용자: 배송 진행 및 완료 안내


-- gist.github.com 사이트 접속, 로그인 
-- README.md 파일을 만들어서, 
-- 위의 코드를 복사 할 예정. 

-- 깃스트에서, 임베디드 코드, 링크  복사해서, 
-- ex_gist.html 파일 생성후 
-- 코드 붙여 넣고 확인해보기. 