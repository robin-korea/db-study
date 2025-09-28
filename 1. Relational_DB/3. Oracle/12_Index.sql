-- 실습용 테이블 생성
CREATE TABLE BIG_TABLE (
    id          NUMBER PRIMARY KEY,
    user_name   VARCHAR2(50),
    description VARCHAR2(100)
);

-- PL/SQL을 사용해 10만 건의 데이터 삽입
BEGIN
    FOR i IN 1..100000 LOOP
    INSERT INTO BIG_TABLE VALUES (i, 'USER_' || i, 'DESCRIPTION FOR ' || i);
    END LOOP;
    COMMIT;
END;
/

-- 인덱스가 없을때 성능 확인
-- TABLE ACCESS FULL COST = 164
SELECT * FROM BIG_TABLE WHERE user_name = 'USER_99999';

-- 인덱스 만들고 성능 비교

CREATE INDEX idx_big_table_username ON BIG_TABLE(user_name);

-- INDEX RANGE SCAN COST = 2
SELECT * FROM BIG_TABLE WHERE user_name = 'USER_99999';

/*
인덱스의 장점 : SELECT 성능 향상
인덱스의 단점 : INSERT, UPDATE, DELETE 성능 소폭 저하
모든 컬럼에 인덱스를 만드는 것이 아니라 WHERE 절에 자주 쓰이는 컬럼에만 전략적으로 인덱스를 만드는 것이 중요
 */