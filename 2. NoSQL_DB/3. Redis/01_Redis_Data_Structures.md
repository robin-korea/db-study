# 01. Redis 데이터 타입과 필수 명령어 (Commands)

## 1. String (문자열)
가장 기본이 되는 1:1 키-값 쌍입니다.

```bash
# 데이터 저장 (SET key value)
SET user:email "gildong@test.com"

# 데이터 조회 (GET key)
GET user:email

# 값이 없으면 저장 (SET if Not Exists) - 분산 락 구현에 사용
SETNX lock:order 1 

# 여러 개 한 번에 저장/조회 (MSET, MGET)
MSET user:1 "Alice" user:2 "Bob"
MGET user:1 user:2

# 숫자 증가/감소 (Atomic 보장 - 조회수 카운터에 사용)
SET views:video:100 10
INCR views:video:100        # 11이 됨
DECR views:video:100        # 다시 10이 됨
INCRBY views:video:100 10   # 20이 됨

# 왼쪽(Head)에 데이터 삽입
LPUSH notifications "Message 1"
LPUSH notifications "Message 2"

# 오른쪽(Tail)에 데이터 삽입
RPUSH notifications "Message 3"

# 조회 (인덱스 0부터 -1(끝)까지 전체 조회)
LRANGE notifications 0 -1
# 결과: 1) "Message 2" 2) "Message 1" 3) "Message 3"

# 데이터 꺼내기 (Pop - 실제 데이터가 삭제됨)
LPOP notifications  # 왼쪽에서 꺼냄
RPOP notifications  # 오른쪽에서 꺼냄

# 데이터 추가 (중복된 값은 무시됨)
SADD visits:today "user1"
SADD visits:today "user2"
SADD visits:today "user1"  # 무시됨

# 전체 조회
SMEMBERS visits:today

# 특정 멤버가 있는지 확인 (있으면 1, 없으면 0)
SISMEMBER visits:today "user3"

# 집합의 크기(개수) 확인
SCARD visits:today

# 요소 삭제
SREM visits:today "user2"

# 데이터 추가 (ZADD key score member)
ZADD leaderboard 100 "PlayerA"
ZADD leaderboard 200 "PlayerB"
ZADD leaderboard 150 "PlayerC"

# 순위 조회 (점수 낮은 순)
ZRANGE leaderboard 0 -1
# 결과: PlayerA, PlayerC, PlayerB

# 순위 조회 (점수 높은 순 - 내림차순)
ZREVRANGE leaderboard 0 -1
# 결과: PlayerB, PlayerC, PlayerA

# 특정 사용자의 순위 확인 (0부터 시작)
ZRANK leaderboard "PlayerC"

# 점수 업데이트 (PlayerA의 점수에 50점 추가)
ZINCRBY leaderboard 50 "PlayerA"

# 해시 저장 (HSET key field value)
HSET user:100 name "Robin" age "30" job "Developer"

# 특정 필드값 조회
HGET user:100 name

# 모든 필드와 값 조회
HGETALL user:100

# 특정 필드 삭제
HDEL user:100 job

# 키 삭제
DEL user:email

# 키가 존재하는지 확인 (있으면 1, 없으면 0)
EXISTS user:email

# 만료 시간 설정 (Expire - 초 단위)
# user:session 키를 60초 뒤에 자동 삭제
EXPIRE user:session 60

# 남은 만료 시간 확인 (Time To Live)
TTL user:session
# 결과: 50 (50초 남음), -1 (만료시간 없음), -2 (키 없음)

# 키 이름 변경
RENAME old_name new_name

# 모든 데이터 삭제 (주의! 복구 불가)
FLUSHALL
