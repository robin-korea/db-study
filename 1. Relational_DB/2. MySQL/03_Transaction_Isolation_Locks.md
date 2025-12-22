## 1. MySQL의 격리 수준 (Isolation Level)
표준 SQL에는 4가지 격리 수준이 있다. Oracle의 기본값은 `READ COMMITTED`이지만, **MySQL(InnoDB)의 기본값은 `REPEATABLE READ`** 이다.

### 1.1 READ COMMITTED vs REPEATABLE READ

| 특징 | READ COMMITTED (Oracle, PostgreSQL) | REPEATABLE READ (MySQL Default) |
| :--- | :--- | :--- |
| **동작** | 커밋된 데이터만 읽음 | 트랜잭션이 시작된 시점의 상태를 계속 읽음 |
| **구현 방식** | Undo Log의 최신 커밋 데이터 참조 | **Undo Log**에 백업된 과거 데이터를 참조 (MVCC) |
| **특징** | 트랜잭션 내에서도 쿼리 실행 시점에 따라 결과가 다를 수 있음 (Non-Repeatable Read) | 트랜잭션 내에서는 항상 동일한 결과를 보장함 |

---

## 2. MVCC (Multi Version Concurrency Control)
> **"잠금 없는 일관된 읽기 (Non-Locking Consistent Read)"**

InnoDB는 잠금(Lock)을 걸지 않고도 읽기 작업을 수행할 수 있다. 어떻게? **Undo Log(언두 로그)** 덕분이다.

1.  A 트랜잭션이 데이터를 수정 중 (아직 커밋 안 함).
2.  이때 B 트랜잭션이 해당 데이터를 `SELECT` 함.
3.  MySQL은 변경 중인 데이터(Buffer Pool)가 아니라, 수정 전 값이 복사된 **Undo Log**의 데이터를 보여준다.
4.  결과적으로 A의 작업 방해 없이 B는 읽기가 가능하다.

---

## 3. MySQL만의 특이한 잠금: Gap Lock & Next-Key Lock
일반적으로 `REPEATABLE READ`에서는 **Phantom Read**(없던 데이터가 갑자기 조회되는 현상)가 발생할 수 있다. 하지만 MySQL은 **Gap Lock**을 통해 이를 방지한다.

### 3.1 Gap Lock (간격 잠금)
* 레코드 자체가 아니라, **레코드와 레코드 사이의 간격(Gap)**을 잠그는 것.
* 목적: 트랜잭션 도중에 새로운 데이터가 **끼어드는(INSERT)** 것을 막기 위함.

### 3.2 Next-Key Lock
* `Record Lock` (해당 행 잠금) + `Gap Lock` (앞뒤 간격 잠금)이 합쳐진 형태.
* InnoDB는 범위 검색(`BETWEEN`, `>`) 시 기본적으로 Next-Key Lock을 사용한다.

> **주의:** 이 때문에 불필요하게 넓은 범위를 잠가서 동시성 저하(Deadlock)가 발생할 수 있으니, 트랜잭션 안에서는 범위를 최소화해야 한다.
