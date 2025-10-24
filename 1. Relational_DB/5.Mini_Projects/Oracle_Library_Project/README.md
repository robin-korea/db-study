# Oracle 기반 도서 대출 관리 시스템 (미니 프로젝트)

이 프로젝트는 Oracle 데이터베이스를 사용하여 간단한 도서관 도서 대출 관리 시스템의 백엔드를 설계하고 구현한 미니 프로젝트입니다. Oracle SQL 및 PL/SQL 학습 내용을 종합적으로 적용하는 것을 목표로 합니다.

---

## 📚 주요 기능 및 구현 내용

* **테이블 설계 (DDL)**: `BOOKS`, `MEMBERS`, `RENTALS` 세 개의 테이블을 정의하고, `PRIMARY KEY`, `FOREIGN KEY`, `CHECK` 등의 제약조건을 설정하여 데이터 무결성을 확보했습니다. 또한, `WHERE` 절 및 `JOIN` 조건에 사용될 컬럼(`RENTALS.book_id`, `RENTALS.member_id`)에 인덱스(`INDEX`)를 생성하여 조회 성능을 고려했습니다.
* **초기 데이터 및 시퀀스 (DML & Sequence)**: 각 테이블의 `PRIMARY KEY` 자동 생성을 위해 `SEQUENCE` 객체를 사용하고, 초기 도서 및 회원 데이터를 `INSERT`했습니다.
* **핵심 기능 구현 (Procedure)**: 도서 '대출'(`sp_rent_book`) 및 '반납'(`sp_return_book`) 기능을 PL/SQL 저장 프로시저로 구현했습니다. 프로시저 내에서 책의 상태를 확인(`SELECT`, `IF`)하고, 대출 기록을 추가(`INSERT`)하며, 책 상태 및 반납일을 업데이트(`UPDATE`)하는 로직을 포함하여 트랜잭션의 원자성을 보장합니다.
* **분석 리포트 (Analysis & View)**: `GROUP BY`와 분석 함수(`RANK()`)를 사용하여 '인기 도서(대출 횟수) 랭킹'을 조회하는 쿼리를 작성하고, 이를 `V_BEST_BOOKS`라는 `VIEW`로 저장하여 재사용성을 높였습니다.

---

## 🗂️ 파일 구성

* **`00_DDL.sql`**: 테이블(`BOOKS`, `MEMBERS`, `RENTALS`) 생성 및 인덱스 생성 스크립트
* **`01_DML_Sequence.sql`**: 시퀀스(`seq_book_id` 등) 생성 및 초기 데이터(`INSERT`) 스크립트
* **`02_Procedure.sql`**: 도서 대출(`sp_rent_book`) 및 반납(`sp_return_book`) PL/SQL 프로시저 스크립트
* **`03_Analysis.sql`**: 인기 도서 랭킹 조회 쿼리 및 뷰(`V_BEST_BOOKS`) 생성 스크립트
