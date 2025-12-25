# 📂 1. NoSQL 공통 개념 (Common Concepts)

## 📖 Introduction
특정 NoSQL 제품(MongoDB, Redis 등)을 다루기 전에, **NoSQL이 왜 등장했는지**와 **분산 데이터베이스 시스템의 핵심 이론**을 먼저 정리한 디렉토리입니다.

RDBMS의 한계인 **확장성(Scalability)** 문제를 해결하기 위한 접근 방식과, 분산 환경에서 필연적으로 발생하는 **트레이드오프(Trade-off)** 관계를 이해하는 것을 목표로 합니다.

---

## 📝 Study Content

### [01. NoSQL의 등장 배경과 RDBMS 비교](./01_NoSQL_vs_RDBMS.md)
* **핵심 내용:** 데이터의 정합성(ACID)보다 가용성과 확장성을 우선시하는 NoSQL의 철학.
* **Key Learnings:**
    * **Scale-Up vs Scale-Out:** RDBMS는 고비용의 수직적 확장을, NoSQL은 저비용의 수평적 확장을 지향함.
    * **ACID vs BASE:** 즉각적인 일관성(Strong Consistency) 대신, **최종 일관성(Eventual Consistency)**을 추구하는 BASE 모델 이해.
    * **Schema-less:** 고정된 스키마 없이 데이터를 유연하게 저장하는 구조.

### [02. CAP 이론 (Distributed System Theory)](./02_CAP_Theorem.md)
* **핵심 내용:** 분산 시스템에서 3마리 토끼(Consistency, Availability, Partition Tolerance)를 다 잡을 수는 없다는 이론.
* **Key Learnings:**
    * **CP 시스템:** 일관성 우선 (예: 금융 시스템, HBase).
    * **AP 시스템:** 가용성 우선 (예: SNS 피드, Cassandra).
    * **PACELC:** 네트워크 장애가 없을 때(E)는 지연시간(L)과 일관성(C) 중 무엇을 선택할 것인가에 대한 확장 이론.

### [03. NoSQL 데이터 모델 유형](./03_NoSQL_Data_Models.md)
* **핵심 내용:** 저장 방식과 목적에 따른 NoSQL의 4가지 분류.
* **Key Learnings:**
    * **Key-Value:** 단순하고 빠른 조회가 필요할 때 (Redis).
    * **Document:** 계층적인 데이터를 직관적으로 저장할 때 (MongoDB).
    * **Wide-Column:** 대량의 데이터를 쓰기 작업할 때 (Cassandra, HBase).
    * **Graph:** 복잡한 관계망을 탐색할 때 (Neo4j).

---

## 💡 Summary
NoSQL은 단순히 SQL을 안 쓰는 것이 아니라, **"비즈니스 요구사항(빠른 응답속도, 대용량 트래픽 등)에 맞춰 데이터의 일관성을 일부 포기하고 확장성을 얻는 전략적인 선택"**임을 이해했습니다.
