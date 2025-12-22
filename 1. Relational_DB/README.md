# 1. 관계형 데이터베이스 (Relational DB) 학습

이 저장소는 관계형 데이터베이스(RDBMS)의 핵심 개념을 학습하고, 다양한 RDBMS(Oracle, PostgreSQL, MySQL 등)를 직접 설치하고 실습한 내용을 정리한 공간입니다.

---

## 📚 학습 내용

### 1. 공통 개념 (Common Concepts)
데이터베이스의 종류와 관계없이 반드시 알아야 할 핵심 이론들을 정리했습니다.
- 정규화 (Normalization)
- 트랜잭션 (Transaction)
- 인덱스 (Index)
- 잠금 (Lock)
- 실행 계획 (Execution Plan)

### 2. 데이터베이스별 실습 (Database-Specific Practice)
각 데이터베이스의 문법과 아키텍처적 특징을 실습한 내용을 포함하고 있습니다.
- **Oracle**: 가장 먼저 깊이 있게 학습한 데이터베이스로, SQL 기초부터 PL/SQL 프로그래밍, 고급 분석 함수까지 폭넓은 내용을 다룹니다.
- **MySQL**: 단순한 문법 학습을 넘어, **Oracle과의 아키텍처 차이(Pluggable Storage Engine)**와 **InnoDB 엔진의 내부 동작 원리(Clustered Index, Gap Lock, MVCC)**를 심도 있게 학습했습니다. 또한 실무적인 성능 튜닝을 위한 **실행 계획(Explain)** 분석과 고가용성을 위한 **복제(Replication)** 구조를 정리했습니다.
- **PostgreSQL**: Oracle과의 차이점을 중심으로 `SERIAL`, 고급 데이터 타입(`ARRAY`, `JSONB`), `PL/pgSQL`, 트랜잭셔널 DDL, GIN 인덱스 등 PostgreSQL 고유의 강력한 기능들을 학습했습니다.

### 3. 미니 프로젝트 (Mini Projects)
학습한 개념들을 총동원하여 실제 동작하는 시스템을 구현하거나, 복잡한 실무 문제를 해결한 기록입니다.
- **Oracle 기반 도서 대출 관리 시스템**: 테이블 설계(DDL)부터 초기 데이터 세팅(DML), 핵심 기능(Procedure), 분석 리포트(View)까지의 전체 개발 과정을 담고 있습니다.
- **PostgreSQL 기반 상품 리뷰 시스템**: `SERIAL`, `ARRAY`, `JSONB` 등 PostgreSQL의 고유 기능을 적극 활용하여 유연한 데이터 구조를 설계했습니다. 트리거 로직을 통해 평점이 자동 업데이트되는 시스템을 구현했습니다.
- **실전 SQL 쿼리 트레이닝 (Spotify & Books)**: 실제 서비스와 유사한 대용량/복잡한 관계의 데이터를 기반으로 **N:M 조인 해결**, **CTE 및 Window Function**을 활용한 고급 데이터 분석 등 총 36개의 비즈니스 시나리오를 SQL로 해결했습니다.
