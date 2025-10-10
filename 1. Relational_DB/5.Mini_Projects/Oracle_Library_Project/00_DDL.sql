-- 도서 대출 DB 만들어보기

-- BOOK 테이블 생성
CREATE TABLE Book(
    book_id NUMBER(8) PRIMARY KEY,
    title VARCHAR2(50) NOT NULL,
    author VARCHAR2(50) NOT NULL,
    status VARCHAR2(50) CHECK (status IN ('대출가능', '대출중'))
);

DROP TABLE MEMBERS;

-- MEMBER 테이블 생성
CREATE TABLE MEMBERS(
    member_id NUMBER(8) PRIMARY KEY,
    member_name VARCHAR2(20) NOT NULL,
    join_date DATE DEFAULT SYSDATE
);

-- RENTALS 테이블 생성
CREATE TABLE RENTALS(
    rental_id NUMBER(8) PRIMARY KEY,
    book_id NUMBER REFERENCES BOOK(book_id),
    member_id NUMBER REFERENCES MEMBERS(member_id),
    rental_date DATE DEFAULT SYSDATE,
    return_date DATE
);

-- 인덱스 생성
CREATE INDEX idx_rentals_book_id ON RENTALS(book_id);
CREATE INDEX idx_rentals_member_id ON RENTALS(member_id);

