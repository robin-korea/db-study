## 1. MySQL의 전체 구조 (Pluggable Storage Engine)
Oracle과 MySQL의 가장 큰 차이점 중 하나는 **스토리지 엔진을 플러그인처럼 교체할 수 있다는 점**이다. MySQL은 크게 **MySQL 엔진**과 **스토리지 엔진**으로 나뉜다.

### 1.1 MySQL 엔진 (The Brain)
- 요청된 SQL 문장을 분석하고 최적화하는 역할을 담당.
- 클라이언트 접속 및 쿼리 요청을 처리하는 **커넥션 핸들러**.
- SQL 파서(Parser), 전처리, 옵티마이저(Optimizer).
- 표준 SQL(ANSI SQL) 문법 지원.

### 1.2 스토리지 엔진 (The Hands & Feet)
- 실제 데이터를 디스크에 저장하거나, 디스크로부터 데이터를 읽어오는 역할.
- 사용자가 테이블을 생성할 때 엔진을 지정할 수 있음.
- **대표 엔진:** InnoDB(기본), MyISAM, Memory, Archive 등.

> **핵심:** MySQL 엔진은 "어떻게 데이터를 가져올지(실행 계획)"를 고민하고, 스토리지 엔진은 "실제 데이터를 꺼내오는" 작업을 수행한다.

---

## 2. InnoDB vs MyISAM (면접 단골 질문)
과거(5.5 이전)에는 MyISAM이 기본이었으나, 현재는 **InnoDB**가 기본 엔진이다. 왜 InnoDB를 써야 하는지 아는 것이 핵심.

| 비교 항목 | InnoDB (Default) | MyISAM (Legacy) |
| :--- | :--- | :--- |
| **트랜잭션** | **지원함 (ACID 보장)** | 지원 안 함 |
| **잠금 레벨 (Locking)** | **Row-Level Lock (행 단위)** | Table-Level Lock (테이블 전체) |
| **참조 무결성 (FK)** | **Foreign Key 지원** | 지원 안 함 |
| **데이터 저장 구조** | **Clustered Index (PK 순서대로 저장)** | Heap Table (입력 순서대로 저장) |
| **MVCC** | **지원 (Lock 없는 일관된 읽기)** | 지원 안 함 |
| **주 사용처** | 일반적인 트랜잭션 처리가 필요한 모든 곳 | 읽기 전용(Read-only)의 로그성 데이터 (거의 안 씀) |

### 2.1 InnoDB의 핵심 특징
1.  **프라이머리 키(PK)에 의한 클러스터링 (Clustering):** PK 순서대로 데이터 파일에 저장된다. (Oracle의 IOT와 유사)
2.  **외래 키(Foreign Key) 지원:** 데이터 무결성을 DB 레벨에서 보장.
3.  **MVCC (Multi Version Concurrency Control):** 잠금을 사용하지 않고도 일관된 읽기를 제공 (Undo Log 활용).
4.  **자동 데드락 감지:** 데드락이 발생하면 감지하여 트랜잭션을 강제 종료(Rollback) 시킴.

---

## 3. 정리 및 면접 포인트
* **Q:** MySQL의 아키텍처적 특징은 무엇인가요?
    * **A:** MySQL 엔진과 스토리지 엔진이 분리되어 있어, 용도에 따라 엔진을 선택할 수 있는 구조입니다.
* **Q:** 왜 MyISAM 대신 InnoDB를 사용하나요?
    * **A:** 트랜잭션 지원(ACID)과 Row-level Locking을 통한 동시성 처리 성능이 월등하기 때문입니다. 또한 외래 키를 통한 무결성 보장도 InnoDB의 장점입니다.
