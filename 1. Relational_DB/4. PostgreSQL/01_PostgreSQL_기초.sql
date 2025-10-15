-- PostgreSQL 기초 실습
CREATE TABLE STUDENTS (
    -- SERIAL: 1씩 자동 증가하는 정수 (Oracle의 SEQUENCE + PK 와 비슷)
    student_id   SERIAL PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    major        VARCHAR(50),
    -- CURRENT_DATE: 현재 날짜 (Oracle의 SYSDATE와 비슷)
    enroll_date  DATE DEFAULT CURRENT_DATE
);


INSERT INTO STUDENTS (student_name, major) VALUES ('홍길동', '컴퓨터공학과');
INSERT INTO STUDENTS (student_name, major) VALUES ('김유신', '경영학과');

COMMIT; -- PostgreSQL도 트랜잭션을 지원하므로 COMMIT이 필요합니다.

SELECT * FROM STUDENTS;




