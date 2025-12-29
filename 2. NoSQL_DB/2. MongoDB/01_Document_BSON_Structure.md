# 01. Document와 BSON (vs JSON)

## 1. Document 지향 (Document-Oriented)
MongoDB는 RDBMS의 `Table`-`Row` 구조 대신, **Collection**과 **Document**라는 개념을 사용한다.
데이터는 정해진 스키마가 없는(Schema-less) **비정형 데이터**이며, 필드를 자유롭게 추가하거나 삭제할 수 있다.

## 2. BSON (Binary JSON)
사용자 눈에는 JSON으로 보이지만, 실제 MongoDB가 디스크와 메모리에 데이터를 저장할 때는 **BSON(Binary JSON)** 포맷을 사용한다.

### 2.1 왜 JSON 대신 BSON을 쓰는가?
1.  **파싱 속도:** 텍스트 기반인 JSON은 구문 분석(Parsing)이 느리지만, BSON은 바이너리 형태라 기계가 읽는 속도가 훨씬 빠르다.
2.  **데이터 타입 지원:** JSON은 문자열, 숫자, 불리언 등 기본 타입만 지원하지만, BSON은 **Date, ObjectId, Binary Data(이미지 등)** 같은 다양한 타입을 지원한다.
3.  **공간 효율:** 텍스트보다 바이너리가 저장 공간을 효율적으로 사용할 수 있다 (단, 필드명 반복으로 인한 오버헤드는 존재).

### 2.2 ObjectId (Primary Key)
RDBMS의 `Auto Increment` (1, 2, 3...)와 달리, MongoDB는 **`_id`** 필드(ObjectId)를 기본 PK로 사용한다.

* **구조 (12바이트):** `타임스탬프(4)` + `기기 식별자(3)` + `프로세스 ID(2)` + `카운터(3)`
* **특징:** 중앙 서버와의 통신 없이도 **전 세계에서 유일한 값(Global Unique)** 생성을 보장한다. 이는 분산 데이터베이스 환경(Sharding)에서 데이터 충돌을 막는 핵심 요소다.

---

## 3. RDBMS vs MongoDB 용어 매핑

| RDBMS | MongoDB | 비고 |
| :--- | :--- | :--- |
| Table | **Collection** | 데이터의 집합 |
| Row | **Document** | 하나의 데이터 단위 |
| Column | **Field** | 데이터의 속성 |
| Primary Key | **ObjectId (_id)** | 고유 식별자 |
| Join | **$lookup** | 가급적 사용을 피하고 Embedding 권장 |
