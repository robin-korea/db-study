# PostgreSQL 기반 상품 리뷰 시스템 (미니 프로젝트)

이 프로젝트는 PostgreSQL 데이터베이스를 사용하여 간단한 상품 리뷰 시스템의 백엔드를 설계하고 구현한 미니 프로젝트입니다. 특히 PostgreSQL의 고유하고 강력한 기능(JSONB, ARRAY, SERIAL 등)을 활용하는 데 중점을 두었습니다.

---

## ✨ 주요 기능 및 구현 내용

* **테이블 설계 (DDL)**: `PRODUCTS`와 `REVIEWS` 테이블을 정의했습니다.
    * `SERIAL` 타입을 사용하여 `PRIMARY KEY` 자동 증가를 간편하게 구현했습니다.
    * `PRODUCTS` 테이블에 `TEXT[]`(배열) 타입의 `tags` 컬럼과 `JSONB` 타입의 `specs` 컬럼을 사용하여 유연한 데이터 구조를 설계했습니다.
    * `REVIEWS` 테이블에 `CHECK` 제약조건으로 평점 범위를 제한하고, `TIMESTAMP`와 `NOW()` 함수로 리뷰 작성 시각을 자동으로 기록하도록 했습니다. 또한, `ON DELETE CASCADE` 옵션을 사용하여 상품 삭제 시 관련 리뷰가 자동으로 삭제되도록 설정했습니다.
* **초기 데이터 세팅 (DML)**: `ARRAY` 및 `JSONB` 형식에 맞게 초기 상품 및 리뷰 데이터를 `INSERT`했습니다.
* **핵심 기능 구현 (Procedure)**: 리뷰가 추가될 때 해당 상품의 평균 평점(`avg_rating`)을 자동으로 계산하여 `PRODUCTS` 테이블에 업데이트하는 로직을 PL/pgSQL 저장 프로시저(`sp_add_review`)로 구현했습니다.
* **분석 리포트 (Analysis & View)**: `PRODUCTS` 테이블의 `avg_rating`을 기준으로 `RANK()` 분석 함수를 사용하여 '상품 평점 랭킹'을 조회하는 쿼리를 작성하고, 이를 `V_PRODUCT_RANKING`이라는 `VIEW`로 저장하여 재사용성을 높였습니다.

---

## 🗂️ 파일 구성

* **`00_DDL.sql`**: 테이블(`PRODUCTS`, `REVIEWS`) 생성 스크립트
* **`01_DML.sql`**: 초기 데이터(`INSERT`) 스크립트 (배열, JSONB 데이터 포함)
* **`02_Procedure.sql`**: 리뷰 추가 및 평균 평점 업데이트 PL/pgSQL 프로시저(`sp_add_review`) 스크립트
* **`03_Analysis.sql`**: 상품 평점 랭킹 조회 쿼리 및 뷰(`V_PRODUCT_RANKING`) 생성 스크립트
