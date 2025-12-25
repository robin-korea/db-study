# 03. NoSQL 데이터 모델 유형

## 1. Key-Value Store (키-밸류)
* **구조:** 단순한 Map 구조 (Key 하나에 Value 하나).
* **특징:** 가장 빠르다. 단순한 조회/저장에 최적화.
* **대표 DB:** **Redis**, Memcached, AWS DynamoDB.
* **사용처:** 캐싱, 세션 저장, 실시간 랭킹.

## 2. Document Store (문서형)
* **구조:** JSON, XML 같은 계층적 데이터 구조를 그대로 저장.
* **특징:** 스키마가 유연하고, 개발자 친화적이다. JOIN 대신 내장(Embedding) 방식을 주로 사용.
* **대표 DB:** **MongoDB**, Couchbase.
* **사용처:** 로그 저장, 유저 프로필, 콘텐츠 관리 시스템(CMS), 카탈로그.

## 3. Wide-Column Store (컬럼 패밀리)
* **구조:** 행(Row)마다 다른 컬럼을 가질 수 있는 2차원 Map 구조. 대량의 데이터 쓰기에 강력함.
* **대표 DB:** Cassandra, HBase.
* **사용처:** 시계열 데이터, 센서 데이터, 채팅 이력 저장 (Write가 매우 많은 곳).

## 4. Graph Database (그래프)
* **구조:** 노드(Node)와 엣지(Edge)로 데이터 관계를 저장.
* **특징:** 데이터 간의 '관계'를 탐색하는 데 특화됨. (RDBMS의 JOIN보다 훨씬 빠름)
* **대표 DB:** Neo4j.
* **사용처:** SNS 친구 추천, 사기 탐지(Fraud Detection), 경로 탐색.
