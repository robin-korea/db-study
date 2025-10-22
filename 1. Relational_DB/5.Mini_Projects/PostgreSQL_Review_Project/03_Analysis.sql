-- 현재까지 등록된 상품들의 평균 평점을 기준으로 순위를 매겨서 보여주는 뷰 만들기.

CREATE OR REPLACE VIEW V_PRODUCT_RANKING AS
SELECT
	product_name,
	tags,
	specs,
	avg_rating,
	RANK() OVER (ORDER BY avg_rating DESC) AS rating_rank
FROM
    PRODUCTS;

SELECT *
FROM V_PRODUCT_RANKING
ORDER BY rating_rank;
	