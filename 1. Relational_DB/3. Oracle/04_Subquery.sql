--테이블 재 생성
DROP TABLE STUDENTS;
DROP TABLE MAJORS;

CREATE TABLE MAJORS(
    major_id NUMBER(5) CONSTRAINT pk_major_id PRIMARY KEY,
    major_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO MAJORS (major_id, major_name)
VALUES (101, '컴퓨터공학과');
INSERT INTO MAJORS (major_id, major_name)
VALUES (102, '경영학과');

CREATE TABLE STUDENTS(
    student_id NUMBER(10) CONSTRAINT pk_student_id PRIMARY KEY,
    student_name VARCHAR2(50) NOT NULL,
    student_age NUMBER(5) CONSTRAINT ck_age CHECK (student_age > 0),
    major_id NUMBER(5),
    CONSTRAINT fk_major_id FOREIGN KEY (major_id) REFERENCES MAJORS (major_id)
);

INSERT INTO STUDENTS (student_id, student_name,student_age, major_id)
VALUES (20250001, '홍길동', 23, 101);
INSERT INTO STUDENTS (student_id, student_name,student_age, major_id)
VALUES (20250002, '이순신', 22, 102);
INSERT INTO STUDENTS (student_id, student_name,student_age, major_id)
VALUES (20250003, '김유신', 25, 101);
INSERT INTO STUDENTS (student_id, student_name,student_age, major_id)
VALUES (20250004, '강감찬', 20, NULL);

COMMIT;

--서브쿼리 실습
-- WHERE 절 단일행 서브쿼리
SELECT * FROM STUDENTS WHERE student_age = (SELECT MAX(student_age) FROM STUDENTS);

SELECT * FROM STUDENTS WHERE student_age = 25;

--WHERE 절 다중행 서브쿼리 (IN, ANY, ALL 사용)
SELECT * FROM STUDENTS WHERE major_id IN (SELECT major_id FROM MAJORS WHERE major_name = '컴퓨터공학과'); 

--SELECT 절에서 사용 (JOIN 을 대체)
SELECT student_name, (SELECT major_name FROM MAJORS m WHERE m.major_id = s.major_id) AS major_name FROM STUDENTS s;

--FROM 절에서 사용
SELECT
    major_id,
    ROUND(AVG(student_age)) AS avg_age 
FROM
    STUDENTS
WHERE
    major_id IS NOT NULL
GROUP BY
    major_id;
    
-- FROM 절에 서브쿼리를 사용할 때는, 그 서브쿼리가 하나의 임시 테이블 역할을 하므로 반드시 별칭을 지정해줘야함
SELECT
    m.major_name,
    a.avg_age
FROM
    MAJORS m
INNER JOIN
    (SELECT
        major_id,
        ROUND(AVG(student_age)) AS avg_age
     FROM
        STUDENTS
     WHERE
        major_id IS NOT NULL
     GROUP BY
        major_id) a
ON
    m.major_id = a.major_id;
    
/* 상관 서브쿼리 vs 비상관 서브쿼리
    지금까지 한 실습이 비상관 서브쿼리
    비상관 서브쿼리 : 서브쿼리가 독립적으로 한 번만 실행되고, 그 결과를 메인 쿼리가 이어받아 사용하는 방법
    상관 서브쿼리 : 서브쿼리가 독립적으로 실행되지 못하고, 메인 쿼리의 한 행이 처리될 때마다 그 행의 값을 받아서 반복적으로 실행하는 방법
*/
-- 상관 서브쿼리 실습
--자신이 속한 전공의 평균 나이보다 나이가 많은 학생 찾아보기

SELECT
    s1.student_name,
    s1.student_age,
    (SELECT ROUND(AVG(s2.student_age)) FROM STUDENTS s2 WHERE s2.major_id = s1.major_id) AS "전공 평균 나이"
FROM
    STUDENTS s1
WHERE
    s1.student_age > (SELECT AVG(s2.student_age)
                      FROM STUDENTS s2
                      WHERE s2.major_id = s1.major_id);
