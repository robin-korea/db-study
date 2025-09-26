/*  PL/SQL : Oracle이 SQL을 확장해서 만든 자신들만의 데이터베이스 프로그래밍 언어
    SQL이 데이터베이스에 던지는 하나의 단순 요청이라면,
    PL/SQL은 그 요청들을 포함하여 하나의 완성된 업무 처리 절차를 만드는 것
*/
--PL/SQL 실습하기

SET SERVEROUTPUT ON;

CREATE TABLE MESSAGE(
    msg VARCHAR2(100)
);

-- DBMS_OUTPUT.PUT_LINE : 화면에 메세지를 출력하는 함수 (Java 의 System.out.println 랑 같음)
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, PL/SQL World!');
END;
/

/*  변수
    DECLARE : 변수를 선언하는 부분 BEGIN 앞에 위치
    := : 변수에 값을 할당하는 연산자 ( = 가 아니라 := 을 씀)
*/

DECLARE
    v_name VARCHAR2(50);
    v_message VARCHAR2(100);
BEGIN
    v_name := '홍길동';
    v_message := '님 환영합니다!';
    
    DBMS_OUTPUT.PUT_LINE(v_name || v_message); -- ||는 문자열을 합치는 연산자
END;
/

-- PROCEDURE : 특정 작업을 수행하는 PL/SQL 코드 묶음에 이름을 붙여 데이터베이스에 저장해 둔 것 필요시 이름만 불러 재사용 가능 (예: 데이터 추가)
-- 프로시저 실습 : 메시지를 입력받아서 MESSAGES 테이블에 INSERT하는 프로시저 만들기

CREATE OR REPLACE PROCEDURE sp_add_message(
    p_message IN VARCHAR2
)
IS -- 위에는 선언부 아래는 실행부 를 구분해주는 역할
BEGIN
    INSERT INTO MESSAGE (msg) VALUES (p_message);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('메세지 추가 완료 : ' || p_message);
END;
/

-- EXECUTE : 저장된 프로시저를 실행하는 명령어

EXECUTE sp_add_message('첫 번째 메세지 입니다');
EXECUTE sp_add_message('PL/SQL 공부 중입니다');

SELECT * FROM MESSAGE;

-- FUNCTION : 특정 계산을 하고 결과값을 반환 (예: 이름으로 나이 찾기)
-- 함수 생성
CREATE OR REPLACE FUNCTION fn_get_major_name(
    p_major_id IN NUMBER
)
RETURN VARCHAR2
IS
    v_major_name VARCHAR2(50);
BEGIN
    SELECT major_name
    INTO v_major_name
    FROM MAJORS
    WHERE major_id = p_major_id;
    
    RETURN v_major_name;
END;
/

--함수 사용
SELECT
    student_id,
    fn_get_major_name(major_id) AS major_name
FROM
    STUDENTS;

--IF :  특정 조건이 참일 때만 코드를 실행하게 만드는 기능

CREATE OR REPLACE PROCEDURE sp_add_major(
    p_major_name IN VARCHAR2
)
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM MAJORS
    WHERE major_name = p_major_name;
    
    IF v_count = 0 THEN -- 숫자가 0이면
        INSERT INTO MAJORS (major_id, major_name) VALUES (seq_major_id.NEXTVAL, p_major_name);
        DBMS_OUTPUT.PUT_LINE(p_major_name || ' 학과를 새로 추가했습니다.');
    ELSE -- 숫자가 0이 아니면
        DBMS_OUTPUT.PUT_LINE(p_major_name || ' 학과는 이미 존재합니다.');
    END IF;
END;
/

CREATE SEQUENCE seq_major_id START WITH 103;

EXECUTE sp_add_major ('컴퓨터공학과');
EXECUTE sp_add_major ('물리학과');
    
    

