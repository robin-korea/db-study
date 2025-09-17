--테이블 생성
CREATE TABLE STUDENTS (
    student_id      NUMBER(9),
    student_name    VARCHAR2(50),
    major           VARCHAR2(50),
    enroll_date     DATE
);

-- ALTER ADD 로 컬럼 추가
ALTER TABLE STUDENTS ADD(student_age NUMBER(5));

--INSERT INTO 로 값 추가            
INSERT INTO STUDENTS (student_id, student_name, major, enroll_date, student_age)
VALUES (202304053, '홍길동', '경영학과', SYSDATE, 20);

INSERT INTO STUDENTS (student_id, student_name, major, enroll_date, student_age)
VALUES (202506484, '이순신', '정경학부', SYSDATE, 20);

COMMIT;

SELECT * FROM STUDENTS;

-- UPDATE 로 데이터 수정
UPDATE STUDENTS
SET student_age =23
WHERE student_id =202304053;

SELECT * FROM STUDENTS;

ROLLBACK;

SELECT * FROM STUDENTS;

UPDATE STUDENTS
SET student_age =23
WHERE student_id =202304053;

SELECT * FROM STUDENTS;

COMMIT;

UPDATE STUDENTS
SET student_name = '김유신'
WHERE student_id = 202506484;

SELECT * FROM STUDENTS;

COMMIT;

--DELETE 로 데이터 삭제
DELETE FROM STUDENTS
WHERE major = '정경학부';

SELECT * FROM STUDENTS;

ROLLBACK;

SELECT * FROM STUDENTS;

COMMIT;

-- ALTER MODIFY 컬럼 수정
ALTER TABLE STUDENTS MODIFY (major VARCHAR2(100));

-- ALTER ADD 컬럼 추가
ALTER TABLE STUDENTS ADD (phonenumber NUMBER(15));

-- ALTER DROP COLUMN 컬럼 삭제 
ALTER TABLE STUDENTS DROP COLUMN phonenumber;

-- ALTER RENAME COLUMN 컬럼 이름 변경
ALTER TABLE STUDENTS RENAME COLUMN major to major_name;

UPDATE STUDENTS
SET major_name = '인공지능'
WHERE student_id = 202304053;

UPDATE STUDENTS
SET student_age = 21
WHERE student_id = 202506484;

-- 세이브포인트 sp1 설정
SAVEPOINT sp1;

UPDATE STUDENTS
SET major_name = '컴퓨터공학'
WHERE student_id = 202506484;

SELECT * FROM STUDENTS;

-- sp1으로 롤백
ROLLBACK TO sp1;

SELECT * FROM STUDENTS;

COMMIT;






