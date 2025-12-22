백엔드 인프라에서 DB 서버 한 대로 서비스를 운영하는 경우는 드물다. MySQL의 가장 강력하고 대중적인 기능인 **복제(Replication)** 구조를 이해해야 한다.

## 1. 개념 및 목적
Master(Source) 서버의 데이터를 Slave(Replica) 서버로 실시간 동기화하는 기술.

* **부하 분산 (Load Balancing):** 읽기 작업과 쓰기 작업을 분리하여 성능 향상.
* **고가용성 (High Availability):** Master 서버가 죽었을 때 Slave를 승격시켜 서비스 지속.
* **데이터 백업:** Slave에서 백업을 수행하여 Master 성능 영향 최소화.

---

## 2. 동작 원리 (Binlog & Relay Log)
MySQL 복제는 **비동기(Asynchronous)** 방식이 기본이다.

1.  **Master:** 트랜잭션이 커밋되면 변경 내용을 **Binary Log (Binlog)** 파일에 기록한다.
2.  **Slave (I/O Thread):** 마스터의 Binlog를 가져와서 자신의 **Relay Log**에 기록한다.
3.  **Slave (SQL Thread):** Relay Log를 읽어서 SQL을 다시 실행(Replay)하여 데이터를 반영한다.

### 💡 Oracle Redo Log vs MySQL Binlog
* **Oracle Redo Log:** 물리적인 디스크 변경 사항 기록 (복구 중심).
* **MySQL Binlog:** 논리적인 SQL 문장 혹은 행(Row) 변경 기록 (복제 및 데이터 변경 추적 중심).

---

## 3. Read/Write Splitting (실무 패턴)
애플리케이션(Spring Boot 등) 레벨에서 쿼리 종류에 따라 DB 연결을 분리한다.

* **Master DB:** `INSERT`, `UPDATE`, `DELETE` (데이터 조작)
* **Slave DB:** `SELECT` (단순 조회)

> **주의점 (Replication Lag):** > 비동기 복제이므로 Master에 데이터를 넣자마자 Slave에서 조회하면 데이터가 아직 안 넘어왔을 수 있다. 중요한 데이터는 Master에서 바로 조회하도록 라우팅해야 한다.
