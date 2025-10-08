-- 대출 횟수가 많은 책 순서대로 순위를 매겨서 보여주는 '인기 도서 랭킹' 쿼리 만들어보기

EXECUTE sp_rent_book (1002, 2002);
EXECUTE sp_rent_book (1001, 2002);
EXECUTE sp_return_book(1001);
EXECUTE sp_rent_book (1001, 2001);
EXECUTE sp_return_book(1002);
EXECUTE sp_rent_book (1002, 2001);
EXECUTE sp_rent_book (1003, 2002);


-- 각 도서가 몇번 대출되었는지 확인
SELECT
    book_id,
    COUNT (*) AS rental_count
FROM
    RENTALS
GROUP BY
    book_id;
    
-- RANK 함수 사용하여 순위 매기기

WITH RENTAL_STATS AS (
    SELECT
        book_id,
        COUNT (*) AS rental_count
    FROM
        RENTALS
    GROUP BY
        book_id
)
SELECT
    b.title,
    b.author,
    rs.rental_count,
    RANK() OVER (ORDER BY rs.rental_count DESC) AS "대출 순위"
FROM
    RENTAL_STATS rs
JOIN
    Book b ON rs.book_id = b.book_id
ORDER BY
    "대출 순위";

-- View 로 만들어 사용해보기

CREATE OR REPLACE VIEW V_BEST_BOOKS AS
WITH RENTAL_STATS AS (
    SELECT
        book_id,
        COUNT(*) AS rental_count
    FROM
        RENTALS
    GROUP BY
        book_id
)
SELECT
    b.title,
    b.author,
    rs.rental_count,
    RANK() OVER (ORDER BY rs.rental_count DESC) AS rental_rank
FROM
    RENTAL_STATS rs
JOIN
    Book b ON rs.book_id = b.book_id;

-- 뷰 사용하기
SELECT * FROM V_BEST_BOOKS;
    
