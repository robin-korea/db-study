# 01. NoSQL의 등장 배경과 RDBMS 비교

## 1. NoSQL (Not Only SQL) 이란?
단순히 "SQL이 없다"는 뜻이 아니라, **"RDBMS의 특성(ACID, 고정 스키마)을 일부 포기하는 대신, 분산 환경에서의 확장성과 성능을 확보한 데이터베이스"**를 의미한다.

## 2. RDBMS vs NoSQL 비교 (핵심)

| 특징 | RDBMS (MySQL, Oracle) | NoSQL (MongoDB, Redis) |
| :--- | :--- | :--- |
| **확장성 (Scaling)** | **Scale-Up** (서버 성능 업그레이드) 중심 | **Scale-Out** (서버 대수 늘리기) 중심 |
| **스키마 (Schema)** | 고정 스키마 (변경 어려움) | **Schema-less** (유연함, 자유로운 필드 추가) |
| **트랜잭션** | **ACID** (강력한 일관성 보장) | **BASE** (가용성 우선, 최종 일관성) |
| **데이터 관계** | JOIN을 통한 관계 표현 | JOIN이 없거나 제한적 (Denormalization 권장) |

## 3. ACID vs BASE

### 3.1 ACID (RDBMS)
* **A**tomicity (원자성): 트랜잭션은 전부 성공하거나 전부 실패해야 함.
* **C**onsistency (일관성): 데이터는 항상 미리 정해진 규칙을 만족해야 함.
* **I**solation (격리성): 트랜잭션끼리 서로 간섭하지 않음.
* **D**urability (지속성): 커밋된 데이터는 영구 저장됨.

### 3.2 BASE (NoSQL)
* **B**asically **A**vailable: 언제든지 시스템은 사용 가능해야 한다 (죽지 않는 것이 더 중요).
* **S**oft state: 데이터 상태가 시간에 따라 변할 수 있다 (일관성이 깨진 상태 허용).
* **E**ventually consistent: 시간이 지나면 언젠가는 데이터가 일치해진다 (즉각적인 일관성 포기).
