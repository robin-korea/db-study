# 4. PostgreSQL 데이터베이스 실습

이 폴더는 PostgreSQL 데이터베이스의 주요 특징과 문법을 학습하고 실습한 SQL 스크립트를 포함하고 있습니다. Oracle 학습 경험을 바탕으로 PostgreSQL만의 차별점과 강력한 기능 위주로 실습을 진행했습니다.

---

## 📚 학습 순서 및 내용

* **01_PostgreSQL_기초.sql**:
    PostgreSQL의 기본 DDL, DML 문법을 실습합니다. 특히 Oracle과 다른 데이터 타입(`SERIAL`, `INTEGER`, `VARCHAR`)과 자동 증가 방식(`SERIAL`)의 차이점을 확인합니다.

* **02_PostgreSQL_Advanced_Types.sql**:
    PostgreSQL의 강력한 기능인 배열(`ARRAY`, `TEXT[]`)과 `JSONB` 데이터 타입을 컬럼에 직접 사용하고, 관련 연산자(`ANY`, `->>`)를 이용해 검색하는 방법을 실습합니다.

* **03_PostgreSQL_PL_pgSQL.sql**:
    PostgreSQL의 절차적 언어인 `PL/pgSQL`을 사용하여 함수를 생성하고, Oracle `PL/SQL`과의 문법적 차이점(`RETURNS`, `AS $$...$$`, `LANGUAGE`)을 비교하며 학습합니다.

* **04_PostgreSQL_Transactional_DDL.sql**:
    Oracle과 달리 PostgreSQL에서는 `CREATE TABLE` 같은 DDL 명령어조차 트랜잭션 블록 내에서 `ROLLBACK`이 가능하다는 특징을 실습으로 확인합니다.

* **05_PostgreSQL_Advanced_Index.sql**:
    `ARRAY`나 `JSONB` 같은 복합 데이터 타입의 검색 성능을 향상시키는 GIN(Generalized Inverted Index) 인덱스를 생성하고, 일반 인덱스(B-Tree)와의 차이점 및 성능 개선 효과를 `EXPLAIN ANALYZE`로 확인합니다.

---

## ✨ 주요 학습 포인트

* Oracle과의 데이터 타입 및 주요 함수 차이점 (`SERIAL`, `INTEGER`, `VARCHAR`, `NOW()`, `COALESCE`)
* 고급 데이터 타입 (`ARRAY`, `JSONB`) 활용 및 검색
* `PL/pgSQL` 함수 작성법
* 트랜잭셔널 DDL의 개념과 장점
* GIN 인덱스의 역할과 성능 개선 효과
