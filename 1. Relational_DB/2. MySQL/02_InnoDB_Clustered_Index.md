## 1. 클러스터링 인덱스 (Clustered Index) 란?
Oracle은 기본적으로 데이터가 순서 없이 저장되는 **Heap Table** 방식이지만, MySQL(InnoDB)은 **PK 순서대로 데이터가 물리적으로 정렬되어 저장**되는 **Clustered Index** 방식을 기본으로 사용한다. (Oracle의 IOT - Index Organized Table과 동일)

### 1.1 특징
- **테이블 당 단 하나만 존재** (PK 그 자체가 데이터 파일임).
- PK 값이 변경되면 물리적인 데이터의 위치도 이동해야 함(오버헤드 발생).
- **장점:** PK를 이용한 범위 검색(Range Scan)이 매우 빠르다.
- **단점:** PK가 아닌 보조 인덱스(Secondary Index)를 사용할 때 한 단계 더 거쳐야 하므로 느릴 수 있다.

---

## 2. 인덱스 구조의 차이: MySQL vs Oracle

### 2.1 Oracle (Heap Table)의 보조 인덱스
* `Index(Key)` + `ROWID(물리적 주소)`
* 인덱스를 타면 `ROWID`를 통해 데이터 블록으로 **직접 점프**하여 접근.

### 2.2 MySQL (InnoDB)의 보조 인덱스 (Secondary Index)
* `Index(Key)` + **`PK 값(논리적 주소)`**
* 물리적인 주소(`ROWID`)를 가지지 않고, PK 값을 가지고 있다.
* **검색 과정:** 보조 인덱스 검색 → PK 값 획득 → **Clustered Index(PK 인덱스) 다시 검색** → 실제 데이터 접근.
* 즉, 보조 인덱스를 타면 **인덱스를 두 번 타게 된다.**

---

## 3. Covering Index (커버링 인덱스)의 중요성
MySQL은 위와 같은 구조(보조 인덱스가 PK를 가짐) 때문에 **커버링 인덱스**가 성능 튜닝의 핵심이 된다.

### 3.1 개념
쿼리에 필요한 모든 컬럼이 인덱스(보조 인덱스) 안에 다 포함되어 있어서, **실제 데이터 블록(Clustered Index)까지 찾아가지 않아도 되는 상태**.

### 3.2 예시
```sql
-- 상황: idx_emp_no (emp_no) 인덱스가 있음. PK는 id.

-- 1. 커버링 인덱스 X (느림)
SELECT * FROM employee WHERE emp_no = 100;
-- 과정: idx_emp_no 검색 -> PK(id) 획득 -> PK 인덱스 검색 -> 나머지 컬럼(*) 조회

-- 2. 커버링 인덱스 O (빠름)
SELECT emp_no, id FROM employee WHERE emp_no = 100;
-- 과정: idx_emp_no 검색 -> 필요한 emp_no와 PK(id)가 모두 여기 있음 -> 바로 반환 (종료)
