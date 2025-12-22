# 📂 2. MySQL Deep Dive (Architecture & Internals)

## 📖 Introduction
Oracle 및 PostgreSQL 등 다른 RDBMS를 먼저 학습한 상태에서, **MySQL(특히 InnoDB 엔진)만이 가진 고유한 아키텍처와 내부 동작 원리**를 중점적으로 정리한 디렉토리입니다.

---

## 📝 Study Content (Table of Contents)

### [01. 아키텍처와 스토리지 엔진 (Storage Engine)](./01_Storage_Engine_Architecture.md)
* **핵심 내용:** MySQL의 **Pluggable Storage Engine** 구조 이해.
* **주요 학습:**
    * MySQL Engine vs Storage Engine의 역할 분리.
    * **InnoDB vs MyISAM** 비교 (트랜잭션 지원, 잠금 수준 등).
    * 왜 현대 웹 서비스에서는 InnoDB를 표준으로 사용하는가?

### [02. InnoDB와 Clustered Index](./02_InnoDB_Clustered_Index.md)
* **핵심 내용:** Oracle의 Heap Table과 대비되는 InnoDB의 **Clustered Index** 구조.
* **주요 학습:**
    * PK(Primary Key)가 데이터의 물리적 저장 위치를 결정하는 방식.
    * 보조 인덱스(Secondary Index)가 물리 주소(ROWID) 대신 PK 값을 참조하는 이유.
    * **커버링 인덱스(Covering Index)**가 MySQL 성능 튜닝에서 중요한 이유.

### [03. 트랜잭션과 잠금 (Transaction & Lock)](./03_Transaction_Isolation_Locks.md)
* **핵심 내용:** MySQL의 기본 격리 수준(`REPEATABLE READ`)과 동시성 제어.
* **주요 학습:**
    * **MVCC (Multi-Version Concurrency Control):** Undo Log를 활용한 잠금 없는 일관된 읽기.
    * **Gap Lock & Next-Key Lock:** Phantom Read를 방지하기 위해 레코드 사이의 간격을 잠그는 특수한 메커니즘.

### [04. 복제 (Replication)](./04_Replication_Basic.md)
* **핵심 내용:** 서버 이중화 및 부하 분산을 위한 Master-Slave 구조.
* **주요 학습:**
    * **Binary Log (Binlog)**와 Relay Log를 이용한 비동기 복제 프로세스.
    * 실무에서의 Read/Write Splitting(읽기/쓰기 분리) 패턴.
    * Oracle의 Redo Log와 MySQL Binlog의 차이점.

---

## 💡 Key Takeaways (요약)
1. **아키텍처:** MySQL은 스토리지 엔진을 교체할 수 있으며, OLTP 환경에서는 트랜잭션과 Row-level Locking을 지원하는 **InnoDB**가 필수적이다.
2. **인덱스:** InnoDB 테이블은 **PK 순서대로 저장(Clustered)**되므로, PK 설계가 성능에 지대한 영향을 미친다.
3. **동시성:** MySQL은 **MVCC**를 통해 높은 동시성을 보장하며, **Gap Lock**을 통해 `REPEATABLE READ` 수준에서도 Phantom Read를 방지한다.
4. **확장성:** **Replication**을 통해 읽기 트래픽을 분산시키고 데이터 가용성을 높이는 것이 일반적인 MySQL 운영 방식이다.
