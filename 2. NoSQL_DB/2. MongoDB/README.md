# 📂 2. MongoDB

## 📖 Introduction
가장 대중적인 **Document-Oriented NoSQL**인 MongoDB의 핵심 개념과 아키텍처를 학습한 디렉토리입니다.
RDBMS와의 차이점인 **BSON 저장 구조**와 **Schema-less 모델링** 기법, 그리고 대용량 처리를 위한 **샤딩(Sharding)** 아키텍처를 중점적으로 정리했습니다.

---

## 📝 Study Content

### [01. Document와 BSON (Structure)](./01_Document_BSON_Structure.md)
* **핵심 내용:** JSON과 유사하지만 더 빠르고 강력한 **BSON(Binary JSON)** 포맷의 특징.
* **Key Learnings:**
    * 분산 환경에서의 고유성을 보장하는 **ObjectId**의 구조.
    * RDBMS(Table, Row)와 MongoDB(Collection, Document)의 용어 매핑.

### [02. 모델링: Embedding vs Referencing](./02_Modeling_Embedding_vs_Reference.md)
* **핵심 내용:** MongoDB 성능의 90%를 결정하는 스키마 디자인 패턴.
* **Key Learnings:**
    * **Embedding:** 조회 성능 최적화를 위해 데이터를 내장하는 방식 (Join 회피).
    * **Referencing:** 데이터의 유연성과 정규화를 위해 ID로 참조하는 방식.
    * 애플리케이션의 **Access Pattern(조회 패턴)**에 따른 설계 전략.

### [03. 아키텍처: Replica Set & Sharding](./03_Architecture_Replica_Sharding.md)
* **핵심 내용:** 고가용성(HA)과 수평 확장(Scale-out)을 위한 시스템 구조.
* **Key Learnings:**
    * **Replica Set:** Primary-Secondary 구조와 Oplog를 이용한 자동 복구(Failover).
    * **Sharding:** Mongos, Config Server, Shard의 역할과 **Shard Key** 선정의 중요성.

---

## 💡 Summary
MongoDB는 단순한 JSON 저장소가 아니라, **"함께 읽는 데이터를 함께 저장한다"**는 모델링 원칙과 **Scale-Out**을 전제로 설계된 분산 데이터베이스임을 이해했습니다.
