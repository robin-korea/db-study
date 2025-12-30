# 2. NoSQL Database 학습

이 저장소는 관계형 데이터베이스(RDBMS)의 한계(확장성, 유연성)를 보완하기 위해 등장한 **NoSQL(Not Only SQL)**의 핵심 이론과 대표적인 솔루션들을 학습하고 정리한 공간입니다.

---

## 📚 학습 내용

### 1. [공통 개념 (Common Concepts)](./1.%20Common_Concepts)
특정 솔루션을 다루기 전에, NoSQL이 왜 필요한지와 분산 시스템의 이론적 배경을 먼저 정리했습니다.
- **NoSQL vs RDBMS**: Scale-Up(수직 확장)과 Scale-Out(수평 확장)의 차이, ACID와 BASE 트랜잭션 모델 비교.
- **CAP 이론**: 분산 시스템에서 일관성(C), 가용성(A), 파티션 감내(P) 중 두 가지만 선택해야 한다는 트레이드오프 이해.
- **데이터 모델**: Key-Value, Document, Wide-Column, Graph 등 NoSQL의 4가지 유형 정리.

### 2. [MongoDB (Document DB)](./2.%20MongoDB)
가장 대중적인 문서 지향(Document-Oriented) 데이터베이스인 MongoDB의 구조와 설계를 학습했습니다.
- **BSON 구조**: JSON과 유사하지만 바이너리 형태로 저장되는 내부 구조 및 ObjectId의 특징.
- **스키마 모델링**: RDBMS의 정규화 방식을 벗어나, 조회 성능을 높이는 **Embedding(내장)**과 유연성을 위한 **Referencing(참조)** 패턴 비교.
- **아키텍처**: 고가용성을 위한 **Replica Set**과 대용량 데이터 처리를 위한 **Sharding** 구조.

### 3. [Redis (Key-Value Store)](./3.%20Redis)
초고속 응답 속도를 자랑하는 인메모리(In-Memory) 기반 데이터 저장소입니다.
- **자료구조 활용**: 단순 String뿐만 아니라 List(큐), Set, Sorted Set(랭킹), Hash 등 다양한 자료구조를 실무 명령어와 함께 정리.
- **캐싱 & 영속성**: Look-aside 캐싱 전략과 메모리 데이터 유실 방지를 위한 RDB/AOF 백업 방식.
- **싱글 스레드 아키텍처**: Context Switching 비용을 없앤 고성능 설계 원리와 사용 시 주의사항(O(N) 명령어 금지).

---

## 💡 결론
NoSQL은 RDBMS를 대체하는 것이 아니라, **"데이터의 성격과 서비스의 목적(속도 vs 정합성)"**에 따라 상호 보완적으로 사용해야 함을 이해했습니다.
