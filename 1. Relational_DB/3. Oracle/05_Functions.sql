DROP TABLE STUDENTS;
DROP TABLE MAJORS;

-- 테이블 생성 및 데이터 추가
CREATE TABLE MAJORS (major_id NUMBER(4) PRIMARY KEY, major_name VARCHAR2(50) NOT NULL UNIQUE);
INSERT INTO MAJORS VALUES (101, '컴퓨터공학과');
INSERT INTO MAJORS VALUES (102, '경영학과');

CREATE TABLE STUDENTS (
    student_id NUMBER(9) PRIMARY KEY,
    student_name VARCHAR2(50) NOT NULL,
    enroll_date DATE,
    major_id NUMBER(4) REFERENCES MAJORS(major_id)
);
INSERT INTO STUDENTS VALUES (20250001, '홍길동', TO_DATE('2025-03-02', 'YYYY-MM-DD'), 101);
INSERT INTO STUDENTS VALUES (20250002, '김유신', TO_DATE('2024-03-02', 'YYYY-MM-DD'), 102);
INSERT INTO STUDENTS VALUES (20250003, '이순신', NULL, 101);
INSERT INTO STUDENTS VALUES (20250004, '강감찬', TO_DATE('2025-09-02', 'YYYY-MM-DD'), NULL);
COMMIT;

--내장 함수 실습

--NVL : NULL 값 처리함수 , NVL(A, B)는 'A가 NULL이면 B를 보여주고, NULL이 아니면 A를 그대로 보여주라는 의미

SELECT  s.student_name,
        m.major_name,
        NVL(m.major_name, '미배정') AS "전공"
FROM
    STUDENTS s
LEFT JOIN
    MAJORS m ON s.major_id = m.major_id;
    
--TO_CHAR : 날짜(DATE), 숫자(NUMBER) 등의 데이터를 우리가 원하는 특정 형식의 문자열로 변환해 줌

SELECT
        student_name,
        enroll_date,
        TO_CHAR (enroll_date, 'YYYY"년" MM"월" DD"일" (DY)') AS "입학일"
FROM
    STUDENTS
WHERE enroll_date IS NOT NULL;

-- SUBSTR & LENGTH : SUBSTR은 문자열의 일부를 잘라낼 때, LENGTH는 문자열의 길이를 계산할 때 사용

SELECT
    student_name,
    SUBSTR(student_name,1,1) AS "성씨",   
    LENGTH(student_name) AS "이름 길이"
FROM 
    STUDENTS;

-- ROUND : 숫자를 지정한 소수점 자리에서 반올림할 때 사용

ALTER TABLE STUDENTS ADD (student_age NUMBER(3));

UPDATE STUDENTS SET student_age = 23 WHERE student_id = 20250001;
UPDATE STUDENTS SET student_age = 25 WHERE student_id = 20250002;
UPDATE STUDENTS SET student_age = 24 WHERE student_id = 20250003;
UPDATE STUDENTS SET student_age = 22 WHERE student_id = 20250004;
COMMIT;

SELECT
    AVG(student_age) AS "평균 나이(소수점)",
    ROUND(AVG(student_age)) AS "평균 나이(반올림)",
    ROUND(AVG(student_age), 1) AS "평균 나이(소수점 1자리)"
FROM
    STUDENTS;


--TRUNC : 자리수 밑을 그냥 버리는 역할 특히 날짜 데이터의 '시간' 부분을 없애고 싶을 때 자주 사용

SELECT
    TO_CHAR(SYSDATE,       'YYYY-MM-DD HH24:MI:SS') AS "현재 시간",
    TO_CHAR(TRUNC(SYSDATE), 'YYYY-MM-DD HH24:MI:SS') AS "오늘 날짜(시간 버림)"
FROM
    DUAL;

-- DECODE : Oracle 전용 (= 만 사용 가능)

SELECT
    student_name,
    major_id,
    DECODE
        (major_id,101,'공학계열',
                  102,'상경계열',
                    '기타 또는 미배정') AS "계열 구분"
FROM
    STUDENTS;
    
-- CASE : IF-ELSE 랑 같은 역할 (= 뿐만 아니라 >, <, BETWEEN, LIKE 등 다양한 조건을 사용 가능)

SELECT
    student_name,
    major_id,
    CASE
        WHEN major_id = 101 THEN '공학계열'
        WHEN major_id = 102 THEN '상경계열'
        ELSE '기타 또는 미배정'
    END AS "계열 구분"
FROM
    STUDENTS;
