SELECT * FROM PRODUCTS;

/*
----------------------------------------------------
-- PL/pgSQL 함수 (Functions)
----------------------------------------------------
-- PL/pgSQL은 PostgreSQL의 절차적 언어로, Oracle의 PL/SQL과 유사한 역할을 합니다.
-- 아래는 Oracle PL/SQL과의 주요 문법 차이점입니다.
-- 1. 함수 선언: RETURNS [타입] AS $$ ... $$ LANGUAGE plpgsql; 형태로 작성
-- 2. 블록 구분: BEGIN...END; 는 동일하지만, 전체를 AS $$ ... $$ 로 감쌈
----------------------------------------------------
*/

CREATE OR REPLACE FUNCTION fn_format_price(p_price NUMERIC)
RETURNS VARCHAR
AS $$
BEGIN
	RETURN '₩' || TO_CHAR(p_price, 'FM999G999G999');
END;
$$ LANGUAGE plpgsql;

SELECT
	product_name,
	price,
	fn_format_price(price) AS "포맷된 가격"
FROM
	PRODUCTS;

