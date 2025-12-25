# 02. CAP 이론 (CAP Theorem)

## 1. 개요
분산 데이터베이스 시스템은 아래 **3가지 속성 중 최대 2가지만 만족할 수 있다**는 이론.

1.  **C (Consistency, 일관성):** 모든 노드가 동시에 같은 데이터를 보여주는가?
2.  **A (Availability, 가용성):** 일부 노드가 죽어도 응답을 받을 수 있는가?
3.  **P (Partition Tolerance, 파티션 감내):** 네트워크 단절(Partition)이 일어나도 시스템이 동작하는가?

> **현실적인 제약:** 네트워크 장애(P)는 언제든 발생할 수 있으므로, **P를 기본으로 깔고 C와 A 중에 하나를 선택(Trade-off)** 해야 한다.

## 2. CP vs AP 시스템

### CP (Consistency + Partition Tolerance)
* **특징:** 일관성을 위해 가용성을 포기함.
* **동작:** 네트워크 문제로 데이터 동기화가 실패하면, 차라리 **에러를 뱉고 응답을 거부**한다.
* **예시:** HBase, MongoDB (설정에 따라 다름), Redis (기본 설정), 은행 시스템.

### AP (Availability + Partition Tolerance)
* **특징:** 가용성을 위해 일관성을 포기함.
* **동작:** 최신 데이터가 아닐지라도(옛날 데이터라도) **일단 응답**한다. (Eventual Consistency)
* **예시:** Cassandra, DynamoDB, DNS 서버.

## 3. PACELC 이론 (CAP의 확장)
CAP는 "네트워크 장애 시(P)"의 선택만을 다루지만, **PACELC**는 장애가 없을 때도 고려한다.
* "장애 시(**P**)에는 **A**와 **C** 중 선택하고, 정상 시(**E**)에는 지연시간(**L**atency)과 일관성(**C**onsistency) 중 선택한다."
