--실습 환경 구성 
CREATE TABLE PRODUCTS(
	product_id SERIAL PRIMARY KEY,
	product_name VARCHAR(50) NOT NULL,
	price NUMERIC (10, 2)
);

INSERT INTO PRODUCTS(product_name, price) VALUES
('고급 키보드' , 150000), ('게이밍 키보드', 85000);

COMMIT;

/*
----------------------------------------------------
-- PostgreSQL 고급 데이터 타입: ARRAY & JSONB
----------------------------------------------------
-- PostgreSQL은 관계형 DB임에도 NoSQL처럼 유연한 데이터 타입을 컬럼에 직접 저장할 수 있는 강력한 기능을 제공합니다.

-- 1. ARRAY (배열 타입)
--    - 하나의 컬럼에 여러 개의 값을 '배열' 형태로 저장합니다.
--    - 문법: 컬럼명 데이터타입[]  (예: tags TEXT[])

-- 2. JSONB (JSON 타입)
--    - JSON 형식의 데이터를 텍스트가 아닌 '이진(Binary)' 형태로 효율적으로 저장합니다.
--    - 텍스트 기반인 JSON 타입보다 인덱싱 및 검색 성능이 훨씬 뛰어납니다.
----------------------------------------------------
*/

--1. 테이블에 ARRAY, JSONB 컬럼 추가해보기

ALTER TABLE PRODUCTS ADD COLUMN tags TEXT[];
ALTER TABLE PRODUCTS ADD COLUMN attributes JSONB;

--2. 데이터 업데이트

UPDATE PRODUCTS
SET
	tags = ARRAY['기계식', '사무용',' LED'],
	attributes = '{"color" : "블랙", "warrenty_years" : 2}'
WHERE product_name = '고급 키보드';

UPDATE PRODUCTS
SET
	tags = ARRAY['광학', '게이밍'],
	attributes = '{"color" : "화이트", "dpi" : 16000}'
WHERE product_name = '게이밍 키보드';

COMMIT;

SELECT * FROM PRODUCTS;

--3. 고급 데이터 타입 검색
--ANY 연산자 : 배열에 특정 요소가 포함되어있는지 확인
SELECT product_name, tags FROM PRODUCTS WHERE '게이밍' = ANY(tags);

/*
----------------------------------------------------
-- JSONB 연산자: -> vs. ->>
----------------------------------------------------

-- 두 연산자 모두 JSON 데이터에서 특정 키(key)에 해당하는 값을 추출하는 역할을 합니다.
-- 가장 큰 차이점은 '반환하는 데이터 타입'입니다.

-- 1. -> (화살표 한 개)
--    - 역할: 키에 해당하는 값을 'JSONB' 타입 그대로 반환합니다.
--    - 비유: 선물 상자에서 내용물을 꺼내지 않고, '포장된 상태' 그대로 꺼내는 것.
--    - 주된 용도: 중첩된(nested) JSON 구조를 계속해서 탐색해 들어갈 때 사용합니다.
--    - 예시: attributes -> 'specs' ->> 'dpi'
--           (attributes에서 'specs'라는 JSON 객체를 먼저 꺼낸 후, 그 안에서 'dpi' 값을 텍스트로 최종 추출)

-- 2. ->> (화살표 두 개)
--    - 역할: 키에 해당하는 값을 최종적인 'TEXT' 타입으로 반환합니다.
--    - 비유: 선물 상자의 포장지를 완전히 뜯어 '내용물(알맹이)'만 꺼내는 것.
--    - 주된 용도: WHERE 절에서 특정 문자열과 값을 비교하거나, 최종 결과로 순수한 텍스트 값을 보고 싶을 때 사용합니다.
--    - 예시: WHERE attributes ->> 'color' = '블랙'
--           ('color'의 값을 텍스트로 꺼내와서, '블랙'이라는 텍스트와 비교)

-- 결론:
-- ->  : JSON 구조 안을 '탐색'할 때 사용.
-- ->> : 최종 값을 '텍스트'로 사용/비교할 때 사용.
----------------------------------------------------
*/

SELECT product_name, attributes ->> 'color' AS color FROM PRODUCTS WHERE attributes ->> 'color' = '블랙';
