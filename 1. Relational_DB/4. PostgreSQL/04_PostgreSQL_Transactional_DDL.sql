/*
----------------------------------------------------
-- 04. 트랜잭셔널 DDL (Transactional DDL)
----------------------------------------------------
-- PostgreSQL의 가장 강력하고 독특한 특징 중 하나로,
-- CREATE, ALTER, DROP 같은 DDL 명령어조차 트랜잭션 블록 안에서 실행하면
-- ROLLBACK으로 되돌릴 수 있는 기능을 의미합니다.

-- Oracle과의 비교
-- - Oracle: DDL 실행 즉시 '자동 커밋(Auto Commit)'되어 롤백이 불가능합니다.
-- - PostgreSQL: DDL도 DML처럼 명시적으로 COMMIT하기 전까지는 임시 상태로 남아있어 롤백이 가능합니다.
--   이는 여러 테이블 구조를 동시에 변경하는 복잡한 작업을 훨씬 더 안전하게 만들어 줍니다.

----------------------------------------------------
*/

-- 1. 트랜잭션 시작
BEGIN;

-- 2. 테이블 생성 및 데이터 추가
CREATE TABLE temp_rollback_test (id INT, description VARCHAR(50));
INSERT INTO temp_rollback_test VALUES (1, '이 데이터는 곧 사라질 예정입니다.');

-- 3. 테이블 존재 확인
SELECT * FROM temp_rollback_test;

-- 4. 모든 작업 취소
ROLLBACK;

-- 5. 최종 확인
SELECT * FROM temp_rollback_test;

-- 릴레이션이 없다는 오류문구와 함께 실행되지 않음
