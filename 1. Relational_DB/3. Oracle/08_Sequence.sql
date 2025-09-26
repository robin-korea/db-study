-- 시퀀스 : Oracle 데이터베이스에서 중복되지 않는 숫자를 순서대로 생성해주는 객체
CREATE TABLE MEMBERS(
    member_id NUMBER(8) PRIMARY KEY,
    member_name VARCHAR2(50) NOT NULL
);

-- 실습 : 회원 ID를 자동으로 만들어주는 시퀀스를 생성하고, INSERT 할 때 사용해보기

CREATE SEQUENCE seq_member_id
    INCREMENT BY 1
    START WITH 1001
    NOCACHE; -- 임시 저장 공간을 사용하지 않는다

-- .NEXTVAL : 시퀀스에서 다음 번호를 하나 꺼내줌
-- .CURRVAL : 현재 세션에서 마지막으로 꺼내온 번호를 다시 보여줌

INSERT INTO MEMBERS (member_id, member_name) VALUES (seq_member_id.NEXTVAL, '홍길동');
INSERT INTO MEMBERS (member_id, member_name) VALUES (seq_member_id.NEXTVAL, '김유신');
INSERT INTO MEMBERS (member_id, member_name) VALUES (seq_member_id.NEXTVAL, '이순신');

COMMIT;

SELECT * FROM MEMBERS;

SELECT seq_member_id.CURRVAL FROM DUAL;

-- Sequence 수정

ALTER SEQUENCE seq_member_id
    INCREMENT BY 10;
    
SELECT seq_member_id.NEXTVAL FROM DUAL;

-- NOCACHE : 번호를 요청할 때마다 DB에 접근해서 다음 번호를 가져온다
-- CACHE 숫자 ex) CACHE 20 : 한 번에 20개의 번호를 미리 메모리에 올려두고 사용
-- 성능을 위해 사용하지만 DB를 재시작하면 메모리에 미사용했던 번호들이 사라져 중간에 번호가 건너띄어질 수 있다 


DROP SEQUENCE seq_member_id;
