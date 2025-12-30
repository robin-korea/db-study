# 📂 3. Redis

## 📖 Introduction
가장 널리 사용되는 **In-Memory Data Store**인 Redis의 핵심 기능과 운영 전략을 정리한 디렉토리입니다.
단순한 개념 학습을 넘어, **실무에서 자주 사용하는 CLI 명령어(Commands)**를 직접 정리하고, 싱글 스레드 아키텍처의 특성에 따른 **성능 최적화 포인트**를 학습했습니다.

---

## 📝 Study Content

### [01. 데이터 타입과 필수 명령어 (Commands)](./01_Redis_Data_Structures.md)
* **핵심 내용:** String, List, Set, Sorted Set, Hash 등 5대 자료구조의 특징과 **실전 명령어 예제**.
* **Key Learnings:**
    * **기본 조작:** `SET`, `GET`, `INCR`, `DEL` 등 필수 커맨드 사용법.
    * **Sorted Set:** `ZADD`, `ZRANK` 등을 활용한 **실시간 랭킹(Leaderboard)** 구현 로직.
    * **List:** `LPUSH`, `RPOP`을 활용한 **메시지 큐(Message Queue)** 패턴.
    * **Key 관리:** `EXPIRE`, `TTL`을 이용한 캐시 만료 시간 관리.

### [02. 캐싱 전략과 영속성 (Caching & Persistence)](./02_Caching_Strategies_Persistence.md)
* **핵심 내용:** Look-aside 패턴과 데이터 백업 방식(RDB vs AOF).
* **Key Learnings:**
    * **LRU(Least Recently Used)** 알고리즘을 통한 메모리 관리 및 데이터 축출 정책.
    * 데이터 유실 방지를 위한 **RDB(스냅샷)**와 **AOF(로그)**의 장단점 비교 및 운영 전략.

### [03. 아키텍처와 싱글 스레드 (Internal)](./03_Architecture_Single_Threaded.md)
* **핵심 내용:** Redis의 고성능 비결인 싱글 스레드 이벤트 루프 모델과 확장성.
* **Key Learnings:**
    * Context Switching 비용 제거를 통한 성능 이점.
    * **O(N)** 명령어(`KEYS *`, `FLUSHALL`) 사용 시 발생하는 **Blocking 이슈**와 주의사항.
    * **Sentinel(고가용성)**과 **Cluster(분산 저장)**의 차이점 이해.

---

## 💡 Summary
Redis는 단순한 캐시 저장소가 아니라, **"다양한 자료구조를 지원하는 인메모리 데이터베이스"**임을 이해했습니다. 특히 **적절한 자료구조 선택(예: 랭킹엔 Sorted Set)**과 **명령어의 시간 복잡도**를 고려하는 것이 Redis 성능 최적화의 핵심임을 배웠습니다.
