CREATE OR REPLACE PROCEDURE sp_add_review(
	p_product_id INTEGER,
	p_rating INTEGER,
	p_comment TEXT
)
AS $$
DECLARE
	v_new_avg_rating NUMERIC;
BEGIN
	INSERT INTO REVIEWS (product_id, rating, comment)
	VALUES (p_product_id, p_rating, p_comment);

	SELECT AVG(rating)
    INTO   v_new_avg_rating
    FROM   REVIEWS
    WHERE  product_id = p_product_id;

	UPDATE PRODUCTS
    SET    avg_rating = v_new_avg_rating
    WHERE  product_id = p_product_id;

	-- RAISE NOTICE: pgAdmin에서 메시지를 출력하는 방법 (Oracle의 DBMS_OUTPUT.PUT_LINE과 유사)
    RAISE NOTICE '리뷰가 성공적으로 등록되었으며, 상품 ID %의 평균 평점이 갱신되었습니다.', p_product_id;

END;
$$ LANGUAGE plpgsql;

-- 2번 상품(마우스)에 새로운 리뷰 추가
CALL sp_add_review(2, 4, '디자인은 예쁜데 클릭감이 아쉬워요.');
COMMIT;

-- 결과 확인
-- REVIEWS 테이블에 새 리뷰가 추가되었는지 확인
SELECT * FROM REVIEWS WHERE product_id = 2;

--avg_rating 변경 되었는지 확인
SELECT product_id, product_name, avg_rating FROM PRODUCTS WHERE product_id = 2;



