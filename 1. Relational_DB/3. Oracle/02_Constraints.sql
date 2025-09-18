/*
----------------------------------------------------
-- 02. 제약조건 (Constraints)
----------------------------------------------------
-- 목적: 테이블에 잘못된 데이터가 들어오는 것을 방지하고, 데이터의 무결성을 지키기 위한 '규칙'.
--       테이블 설계의 핵심 요소.

-- 1. PRIMARY KEY (기본 키)
--    - 테이블에서 각 행(row)을 유일하게 식별할 수 있는 대표값.
--    - 특징: NOT NULL + UNIQUE 속성을 자동으로 가짐. (즉, 비어있을 수 없고, 중복될 수 없음)
--    - 예시: 학생 테이블의 '학번', 직원 테이블의 '사원번호'.
--    - 하나의 테이블에는 오직 하나의 PRIMARY KEY만 설정 가능.

-- 2. NOT NULL
--    - 해당 컬럼에 NULL(값이 없음)을 허용하지 않음. 즉, 반드시 값을 입력해야 하는 컬럼.
--    - 예시: 학생 이름, 상품 가격 등 필수 정보.

-- 3. UNIQUE
--    - 해당 컬럼의 모든 값이 유일해야 함. 즉, 중복된 값을 허용하지 않음.
--    - 특징: NULL 값은 허용하지만, NULL 값 자체는 중복해서 입력할 수 없음. (Oracle 기준)
--    - 예시: 이메일 주소, 휴대폰 번호.

-- 4. FOREIGN KEY (외래 키)
--    - 다른 테이블의 PRIMARY KEY 컬럼을 참조하는 키. '관계형' 데이터베이스의 핵심.
--    - 두 테이블을 연결하는 다리 역할을 하며, 참조하는 테이블에 없는 값은 입력할 수 없도록 막아줌.
--    - 예시: 직원 테이블의 '부서번호'는 부서 테이블의 '부서번호(PK)'를 참조.

-- 5. CHECK
--    - 특정 조건을 만족하는 데이터만 입력할 수 있도록 하는 규칙.
--    - 예시: 나이는 0보다 커야 한다 (age > 0), 성별은 '남' 또는 '여'만 가능하다 (gender IN ('남', '여')).
----------------------------------------------------
*/

DROP TABLE STUDENTS;

CREATE TABLE STUDENTS (
    student_id NUMBER(9) CONSTRAINT pk_students PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    major VARCHAR(50),
    enroll_date DATE DEFAULT SYSDATE,
    student_age number(5) CONSTRAINT ck_students_age CHECK (student_age > 0)
);
 -- 정상적으로 데이터 삽입
INSERT INTO STUDENTS (student_id, student_name, major, student_age)
VALUES (202504086, '이순신', '경제학과', 20);

-- student_id(pk)는 유일해야되는데 이미 존재함
INSERT INTO STUDENTS (student_id, student_name, major, student_age)
VALUES (202504086, '홍길동', '영문학과', 23);

--NOT NULL 위반
INSERT INTO STUDENTS (student_id, major, student_age)
VALUES (202504089, '영문학과', 23);

--CHECK 위반
INSERT INTO STUDENTS (student_id, student_name, major, student_age)
VALUES (202504076, '강감찬', '컴퓨터학과', -5);

--커밋시 정상적으로 데이터가 삽입된 값만 저장됨
COMMIT;

--FOREIGN KEY 실습

CREATE TABLE MAJOR(
    major_id NUMBER(4) CONSTRAINT pk_major PRIMARY KEY,
    major_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO MAJOR VALUES(101, '컴퓨터공학과');
INSERT INTO MAJOR VALUES(102, '경제학과');
INSERT INTO MAJOR VALUES(103, '영문학과');

DROP TABLE STUDENTS;

CREATE TABLE STUDENTS(
    student_id NUMBER(9) CONSTRAINT pk_id PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    major_id NUMBER(5),
    CONSTRAINT fk_students_number FOREIGN KEY (major_id) REFERENCES MAJOR (major_id)
);

-- 정상적으로 값이 저장됨
INSERT INTO STUDENTS (student_id, student_name, major_id)
VALUES (202004056, '홍길동', 101);

-- 값 저장에 실패함 (부모키가 없음)
INSERT INTO STUDENTS (student_id, student_name, major_id)
VALUES (202004076, '김유신', 201);

COMMIT;
