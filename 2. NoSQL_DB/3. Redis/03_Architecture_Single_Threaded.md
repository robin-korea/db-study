# 03. Redis 아키텍처와 싱글 스레드

## 1. 왜 싱글 스레드(Single Threaded)인가?
Redis는 사용자 요청을 처리하는 코어 엔진이 **싱글 스레드**로 동작한다.

### 1.1 그래도 빠른 이유
1.  **In-Memory:** 모든 데이터가 RAM에 있어 접근 속도가 매우 빠르다. (디스크 I/O 없음)
2.  **No Context Switch:** 멀티 스레드 환경에서 발생하는 문맥 교환(Context Switch) 비용이나 스레드 생성 비용이 없다.
3.  **No Lock Overhead:** 데이터에 접근할 때 동기화(Lock)를 신경 쓸 필요가 없다. (Race Condition 방지)

> **주의점:** 싱글 스레드이기 때문에 `KEYS *`나 `FLUSHALL` 같이 오래 걸리는 명령어를 실행하면, 그동안 **다른 모든 요청이 멈춘다(Block).** (절대 금지)

---

## 2. 고가용성 구성 (High Availability)

### 2.1 Sentinel (센티넬)
* **역할:** 모니터링 및 자동 페일오버(Failover).
* **동작:** Master가 죽으면 Sentinel이 감지하고, Slave 중 하나를 승격시켜 서비스 중단을 막는다.

### 2.2 Redis Cluster (클러스터)
* **역할:** 데이터 분산 저장 (Sharding).
* **동작:** 여러 노드에 데이터를 나눠 저장하여 메모리 용량의 한계를 극복하고 성능을 확장한다.

---

## 3. 분산 락 (Distributed Lock)
여러 서버가 공유 자원에 동시에 접근할 때 동시성 문제를 해결하기 위해 Redis를 사용한다.
* **Redlock 알고리즘:** Redis를 이용해 구현하는 가장 유명한 분산 락 알고리즘.
* `SETNX` (Set if Not Exists) 명령어를 활용하여 락을 획득한다.
