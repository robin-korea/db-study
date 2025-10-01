-- 1. 도서 ID를 위한 시퀀스 생성 (1001번부터 시작)
CREATE SEQUENCE seq_book_id
    START WITH 1001
    INCREMENT BY 1
    NOCACHE;
    
-- 2. 회원 ID를 위한 시퀀스 생성 (2001번부터 시작)
CREATE SEQUENCE seq_member_id
    START WITH 2001
    INCREMENT BY 1
    NOCACHE;
    
-- 3. 대출 ID를 위한 시퀀스 생성 (3001번부터 시작)
CREATE SEQUENCE seq_rental_id
    START WITH 3001
    INCREMENT BY 1
    NOCACHE;
    
-- BOOKS 테이블에 초기 데이터 3건 추가

INSERT INTO Book (book_id, title, author, status)
VALUES (seq_book_id.NEXTVAL, '어린 왕자', '앙투안 드 생텍쥐페리', '대출가능');

INSERT INTO Book (book_id, title, author, status)
VALUES (seq_book_id.NEXTVAL, '개미', '베르나르 베르베르', '대출가능');

INSERT INTO Book (book_id, title, author, status)
VALUES (seq_book_id.NEXTVAL, '해리 포터', 'J.K.롤링', '대출가능');

-- MEMBERS 테이블에 초기 데이터 2건 추가

INSERT INTO MEMBERS (member_id, member_name)
VALUES (seq_member_id.NEXTVAL, '이순신');

INSERT INTO MEMBERS (member_id, member_name)
VALUES (seq_member_id.NEXTVAL, '강감찬');

COMMIT;