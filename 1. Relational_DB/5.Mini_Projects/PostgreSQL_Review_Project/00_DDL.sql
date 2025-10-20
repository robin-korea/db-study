-- 1. PRODUCTS (상품 정보) 테이블 생성

CREATE TABLE PRODUCTS (
	product_id SERIAL PRIMARY KEY,
	product_name VARCHAR(50) NOT NULL,
	tags TEXT[],
	specs JSONB,
	avg_rating NUMERIC(2,1) DEFAULT 0.0
);

-- 2. REVIEWS (리뷰 정보) 테이블 생성

CREATE TABLE REVIEWS(
	review_id SERIAL PRIMARY KEY,
	product_id INTEGER REFERENCES PRODUCTS(product_id) ON DELETE CASCADE,
	rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
	comment text,
	created_at TIMESTAMP DEFAULT NOW()
);