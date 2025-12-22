# 📂 SQL Practice Set (36 Real-world Challenges)

## 📖 Introduction
이 디렉토리는 실제 서비스와 유사한 데이터셋(**도서 데이터, 음원 스트리밍 데이터**)을 기반으로, 총 36개의 실무형 SQL 문제를 해결한 기록입니다.

단순한 문법 연습이 아니라, **복잡한 테이블 관계 연결(JOIN)**과 **심도 있는 데이터 분석(Analytics)** 능력을 향상시키는 데 중점을 두었습니다.

---

## 📂 Contents

### 1. [Books Analytics & Statistics](./01_Books_Analytic_SQL_18Q.md)
* **Dataset:** 수백만 권의 도서 정보가 담긴 단일 테이블 (`books`).
* **Focus:** 데이터 구조는 단순하지만 요구사항이 복잡한 **통계 및 분석**.
* **Key Skills:**
    * **CTE (Common Table Expressions):** 복잡한 쿼리를 논리적 단위로 분리하여 가독성 및 재사용성 확보.
    * **Window Functions:** `RANK()`, `PARTITION BY`를 활용한 연도별/장르별 순위 도출.
    * **Advanced Subqueries:** 평균값과 비교하거나 동적인 조건을 처리하기 위한 다중 서브쿼리 활용.
    * **Data Logic:** "기복 없는 작가(Consistency)", "시대의 지배자(Dominant Author)" 등 비즈니스 로직 구현.

### 2. [Spotify Complex Joins](./02_Spotify_Complex_Joins_18Q.md)
* **Dataset:** 아티스트, 앨범, 트랙, 장르가 정규화(Normalization)된 음원 DB.
* **Focus:** 다수의 테이블이 얽혀 있는 **N:M(다대다) 관계 해소 및 데이터 조회**.
* **Key Skills:**
    * **Complex JOINs:** 5개 이상의 테이블(`Artists` ↔ `Albums` ↔ `Tracks` ↔ `Genres`)을 연결하는 쿼리 작성.
    * **Relationship Handling:** 교차 테이블(Link Table)을 통과하여 데이터를 추출하는 정규화 스키마 이해.
    * **Aggregation with JOIN:** 조인된 결과셋에서 그룹핑(`GROUP BY`) 및 집계(`HAVING`) 수행.
    * **Filtering:** 특정 연도 발매, 특정 오디오 특징(Energy, Danceability) 등 복합 조건 필터링.

---

## 💡 Tech Stack & Learnings
* **Database:** MySQL 8.0
* **Core Concepts:**
    * `INNER JOIN` vs `LEFT JOIN` (NULL Handling)
    * `GROUP BY` & `HAVING` vs `WHERE`
    * `WITH` clause (CTE)
    * `RANK()` / `DENSE_RANK()`
    * Performance Consideration (Subquery Optimization)

---

## 📝 Review Note
이 프로젝트를 통해 **"정규화된 DB에서의 효율적인 데이터 추출(Spotify)"**과 **"데이터 인사이트 도출을 위한 분석적 쿼리 작성(Books)"** 두 가지 핵심 역량을 모두 경험할 수 있었습니다.
