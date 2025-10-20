-- 1. PRODUCTS (상품) 데이터 추가

INSERT INTO PRODUCTS (product_name, tags, specs) VALUES
(
	'Pro Mechanical Keyboard',
    ARRAY['기계식', '게이밍', 'RGB'],
    '{"color": "블랙", "switch": "청축", "layout": "104키"}'
);

INSERT INTO PRODUCTS (product_name, tags, specs) VALUES
(
	'Ultra-light Gaming Mouse',
	ARRAY['게이밍','무선','RGB'],
	'{"color" : "화이트", "dpi" : 16000, "weight" : "80g"}'
);

INSERT INTO PRODUCTS (product_name, tags, specs) VALUES
(
	'4K UHD Monitor',
	ARRAY['모니터','전문가용','4K'],
	'{"size" : "27인치", "panel" : "IPS", "resolution" : "3840x2160"}'
);

SELECT * FROM PRODUCTS;

-- 2. REVIEWS (리뷰) 데이터 추가
-- 1번 상품(키보드)에 대한 리뷰 2개

INSERT INTO REVIEWS (product_id, rating, comment) VALUES
(1, 5, '타건감이 정말 좋네요! 만족합니다.');

INSERT INTO REVIEWS (product_id, rating, comment) VALUES
(1, 4, 'LED 가 화려해서 좋은데, 소음이 조금 있는 편입니다.');

INSERT INTO REVIEWS (product_id, rating, comment) VALUES
(2, 5, '정말 가볍고 반응속도가 빨라요. 게임할 맛 납니다.');

COMMIT;

SELECT * FROM REVIEWS;
