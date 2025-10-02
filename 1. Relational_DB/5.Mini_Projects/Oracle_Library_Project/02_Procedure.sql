SET SERVEROUTPUT ON;

-- 대출 프로시저 생성
CREATE OR REPLACE PROCEDURE sp_rent_book(
    p_book_id IN NUMBER,
    p_member_id IN NUMBER
)
IS
    v_book_status VARCHAR2(20);
BEGIN
    -- 1. 책의 현재 상태를 조회해서 변수에 저장
    SELECT status
    INTO v_book_status
    FROM Book
    WHERE book_id = p_book_id;
    
    -- 2. 책의 상태에 따라 다른 작업 수행
    IF v_book_status = '대출가능' THEN
        -- 2.1 대출 기록 추가
        INSERT INTO RENTALS (rental_id, book_id, member_id)
        VALUES (seq_rental_id.NEXTVAL, p_book_id, p_member_id);
        
        -- 2.2 책 상태를 '대출중'으로 변경
        UPDATE Book
        SET status = '대출중'
        WHERE book_id = p_book_id;
        
        DBMS_OUTPUT.PUT_LINE('성공 : 도서 ID ' || p_book_id || ' 대출이 완료되었습니다.');
        
    ELSE
        DBMS_OUTPUT.PUT_LINE('실패: 해당 도서는 이미 대출 중입니다.');
    END IF;
    
    COMMIT;
END;
/

EXECUTE sp_rent_book (1001, 2001);

SELECT * FROM Book WHERE book_id = 1001;
SELECT * FROM RENTALS;

-- 반남 프로시저 생성
CREATE OR REPLACE PROCEDURE sp_return_book(
    p_book_id IN NUMBER
)
IS
    v_book_status VARCHAR2(20);
BEGIN
    -- 1. 책의 현재 상태를 확인
    SELECT status
    INTO v_book_status
    FROM Book
    WHERE book_id = p_book_id;
    
    -- 2. 대출중인 책일 경우에만 반납 처리
    IF v_book_status = '대출중' THEN
        -- 2-1. 책 상태를 '대출가능'으로 변경
        UPDATE Book
        SET status = '대출가능'
        WHERE book_id = p_book_id;
        
         -- 2-2. 대출 기록에 반납일 업데이트 (아직 반납일이 기록되지 않은 가장 최근 대출 건)
         UPDATE RENTALS
         SET return_date = SYSDATE
         WHERE book_id = p_book_id AND return_date IS NULL;
         
         DBMS_OUTPUT.PUT_LINE('성공: 도서 ID ' || p_book_id || ' 반납이 완료되었습니다.');
         
    ELSE
        DBMS_OUTPUT.PUT_LINE('실패: 해당 도서는 대출중 상태가 아닙니다.');
    END IF;
    
    COMMIT;
END;
/

EXECUTE sp_return_book(1001);

SELECT * FROM Book WHERE book_id = 1001;
SELECT * FROM RENTALS WHERE book_id = 1001;

EXECUTE sp_rent_book(1001,2001);
SELECT * FROM Book WHERE book_id = 1001;
SELECT * FROM RENTALS WHERE book_id = 1001;

EXECUTE sp_return_book(1001);
SELECT * FROM Book WHERE book_id = 1001;
SELECT * FROM RENTALS WHERE book_id = 1001;

         
         