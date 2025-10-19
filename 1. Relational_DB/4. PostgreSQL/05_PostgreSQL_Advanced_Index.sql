/*
----------------------------------------------------
-- 인덱스 종류 비교: 일반 인덱스(B-Tree) vs. GIN 인덱스
----------------------------------------------------
-- PostgreSQL은 다양한 종류의 인덱스를 지원하며, 데이터의 종류와 검색 방식에 따라
-- 적절한 인덱스를 선택하는 것이 중요

-- 1. 일반 인덱스 (B-Tree 인덱스)
--    - PostgreSQL에서 CREATE INDEX를 할 때 기본으로 생성되는 인덱스입니다. Oracle, MySQL의 일반 인덱스와 동일합니다.
--    - 비유: '가나다' 순으로 정렬된 '사전' 또는 '책 목차' 
--    - 핵심 대상: 하나의 컬럼에 하나의 값이 들어있는 '단일 값' 데이터 (INTEGER, VARCHAR, DATE 등)
--    - 작동 원리: 데이터를 정렬된 트리 구조로 저장하여 특정 값을 빠르게 찾습니다.
--    - 최적의 상황: 크기 비교(=, >, <, BETWEEN)나 정확히 일치하는 값을 찾을 때 매우 빠릅니다.

-- 2. GIN 인덱스 (Generalized Inverted Index)
--    - 비유: 책 맨 뒤에 있는 '핵심 단어 찾아보기(색인)' 페이지 
--    - 핵심 대상: 하나의 컬럼에 여러 값이 포함된 '다중 값' 데이터 (ARRAY, JSONB 등)
--    - 작동 원리: 컬럼 안의 모든 값을 분해하여, 어떤 값이 어떤 행에 들어있는지를 역으로 추적하는 목록을 만듭니다.
--    - 최적의 상황: "이 값을 포함하고 있는 모든 행을 찾아줘" 형태의 검색에 특화되어 있습니다. (= ANY(), @> 등)
--    - 생성 방법: CREATE INDEX ... USING GIN (컬럼명); 처럼 명시적으로 지정해야 합니다.
*/

CREATE TABLE ITEMS (
	item_id SERIAL PRIMARY KEY,
	item_name VARCHAR(100),
	tags TEXT[]
);

-- PL/pgSQL로 10만 건의 데이터 삽입
DO $$
BEGIN
	FOR i IN 1..100000 LOOP
		INSERT INTO ITEMS (item_name, tags)
		VALUES ('아이템 ' || i, ARRAY['태그' || i, '공통태그' ,'세일']);
	END LOOP;
END $$;

-- '게이밍' 태그를 가진 특별한 상품 추가
INSERT INTO ITEMS (item_name, tags) VALUES ('특별 아이템', ARRAY['고급', '게이밍', '한정판']);
COMMIT;

-- 특정 태그('게이밍')를 가진 상품을 찾아보기
-- EXPLAIN ANALYZE를 앞에 붙이면 실제 실행 시간까지 확인할 수 있음

EXPLAIN ANALYZE
SELECT item_name FROM ITEMS WHERE '게이밍' = ANY(tags);

-- GIN 인덱스 생성하기

CREATE INDEX idx_items_tags_gin ON ITEMS USING GIN (tags);

-- 인덱스로 다시 검색해보기

EXPLAIN ANALYZE
SELECT item_name FROM ITEMS WHERE '게이밍' = ANY(tags);
