DROP TABLE STUDENTS;
DROP TABLE MAJOR;

-- 부모 테이블 생성 및 데이터 추가
CREATE TABLE MAJORS(
    major_id NUMBER(10) CONSTRAINT pk_major_id PRIMARY KEY,
    major_name VARCHAR2(50) NOT NULL UNIQUE
);

INSERT INTO MAJORS (major_id, major_name)
VALUES (101, '컴퓨터공학과');
INSERT INTO MAJORS (major_id, major_name)
VALUES (102, '경영학과');
INSERT INTO MAJORS (major_id, major_name)
VALUES (103, '경제학과');

-- 자식 테이블 생성 및 데이터 추가
CREATE TABLE STUDENTS (
    student_id NUMBER(10) CONSTRAINT pk_student_id PRIMARY KEY,
    student_name VARCHAR2(50) NOT NULL,
    major_id NUMBER(4),
    CONSTRAINT fk_major_id FOREIGN KEY (major_id) REFERENCES MAJORS(major_id) 
)

INSERT INTO STUDENTS (student_id, student_name, major_id)
VALUES (20250001, '이순신', 101);
INSERT INTO STUDENTS (student_id, student_name, major_id)
VALUES (20250002, '강감찬', 102);
INSERT INTO STUDENTS (student_id, student_name, major_id)
VALUES (20250003, '김유신', 103);
INSERT INTO STUDENTS (student_id, student_name, major_id)
VALUES (20250004, '홍길동', NULL);

-- JOIN 해보기
--INNER JOIN은 두 테이블의 연결고리(major_id)가 정확히 일치하는 데이터만 보여줌
SELECT
    s.student_name,
    m.major_name
FROM 
    STUDENTS s
INNER JOIN
    MAJORS m ON s.major_id = m.major_id;
    
--OUTER JOIN은 특정 테이블을 기준으로, 그 테이블의 모든 데이터를 일단 다 보여주고, 짝이 맞는 데이터가 있으면 옆에 붙여주고 없으면 NULL로 표시
--LEFT JOIN (LEFT OUTER JOIN)
SELECT
    s.student_name,
    m.major_name
FROM
    STUDENTS s
LEFT JOIN
    MAJORS m ON s.major_id = m.major_id;

--RIGHT JOIN (RIGHT OUTER JOIN)
INSERT INTO MAJORS VALUES (104, '물리학과');
COMMIT;

SELECT
    s.student_name,
    m.major_name
FROM
    STUDENTS s
RIGHT JOIN
    MAJORS m ON s.major_id = m.major_id;
    

--FULL OUTER JOIN 양쪽의 모든 데이터 조회
SELECT
    s.student_name,
    m.major_name
FROM
    STUDENTS s
FULL OUTER JOIN
    MAJORS m ON s.major_id = m.major_id;
    
--SELF JOIN 하나의 테이블 안에 관계가 모두 포함된 경우, 그 테이블 자기 자신과 JOIN하는 것\
--SELF JOIN 용 테이블 생성
CREATE TABLE EMPLOYEES (
    emp_id   NUMBER(4) PRIMARY KEY,
    emp_name VARCHAR2(50),
    manager_id NUMBER(4)
);

INSERT INTO EMPLOYEES VALUES (1001, '김사장', NULL);
INSERT INTO EMPLOYEES VALUES (2001, '박부장', 1001);
INSERT INTO EMPLOYEES VALUES (2002, '이부장', 1001);
INSERT INTO EMPLOYEES VALUES (3001, '최과장', 2001);
COMMIT;

--SELF JOIN 실행
SELECT
    e.emp_name AS "직원 이름",
    m.emp_name AS "매니저 이름"
FROM
    EMPLOYEES e
LEFT JOIN -- 매니저가 없는 '김사장'도 나와야 하므로 LEFT JOIN 사용
    EMPLOYEES m ON e.manager_id = m.emp_id;