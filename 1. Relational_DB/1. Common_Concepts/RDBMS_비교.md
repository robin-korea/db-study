# RDBMS 비교: Oracle vs PostgreSQL vs MySQL

이 문서는 주요 관계형 데이터베이스의 핵심적인 문법 및 기능 차이점을 한눈에 비교하고 정리합니다.

---

## 📝 주요 차이점 비교표

| 구분 | Oracle | PostgreSQL | MySQL |
| :--- | :--- | :--- | :--- |
| **라이선스/비용** | 상용(유료) | 오픈소스(무료) | **오픈소스(무료)** |
| **핵심 데이터 타입** | `VARCHAR2`, `NUMBER` | `VARCHAR`, `INTEGER` | **`VARCHAR`, `INT`, `DECIMAL`** |
| **자동 증가** | `SEQUENCE` / `IDENTITY` | `SERIAL` / `IDENTITY` | **`AUTO_INCREMENT`** |
| **현재 시간 함수** | `SYSDATE` | `NOW()` | **`NOW()`**, `SYSDATE()` |
| **NULL 처리 함수** | `NVL(A, B)` | `COALESCE(A, B)` | **`IFNULL(A, B)`**, `COALESCE(A, B)` |
| **절차적 언어** | `PL/SQL` | `PL/pgSQL` | **Stored Procedures** |
| **DDL 트랜잭션** | Auto Commit (롤백 불가) | **Transactional (롤백 가능)** | Auto Commit (롤백 불가) |
| **객체 이름 규칙** | `" "` (큰따옴표) | `" "` (큰따옴표) | **`` ` `` (백틱)** |

---

## 🚀 학습 전략

- **공통점**: `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `JOIN`, `GROUP BY` 등 대부분의 표준 SQL 문법은 동일하다.
- **차이점**: 위 표에 정리된 데이터 타입, 내장 함수, 트랜잭션 정책 등의 차이점 위주로 학습한다.
