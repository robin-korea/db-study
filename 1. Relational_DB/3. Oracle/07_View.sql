DROP TABLE EMPLOYEES;

CREATE TABLE DEPARTMENTS(
    dept_id NUMBER(4) PRIMARY KEY,
    dept_name VARCHAR2(50)
);

CREATE TABLE EMPLOYEES (
    emp_id    NUMBER(4) PRIMARY KEY,
    emp_name  VARCHAR2(50),
    salary    NUMBER(8, 2),
    dept_id   NUMBER(4) REFERENCES DEPARTMENTS(dept_id)
);

INSERT INTO DEPARTMENTS VALUES (10, '경영');
INSERT INTO DEPARTMENTS VALUES (20, '영업');
INSERT INTO DEPARTMENTS VALUES (30, '개발');

INSERT INTO EMPLOYEES VALUES (1001, '김사장', 9000, 10);
INSERT INTO EMPLOYEES VALUES (2001, '박부장', 6000, 20);
INSERT INTO EMPLOYEES VALUES (3001, '최과장', 4800, 30);
INSERT INTO EMPLOYEES VALUES (3002, '강사원', 4000, 30);
COMMIT;

--View : 복잡한 SELECT 쿼리문을 데이터베이스에 저장해두고 진짜 테이블처럼 편리하게 사용할 수 있는 가상 테이블입니다.
--실습 : 직원 정보와 부서 이름을 JOIN해서 보여주는 복잡한 쿼리를 V_EMP_DEPT라는 간단한 뷰로 만들어 보기

CREATE OR REPLACE VIEW V_EMP_DEPT AS
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name,
    e.salary
FROM
    EMPLOYEES e
JOIN 
    DEPARTMENTS d ON d.dept_id = e.dept_id;

-- View 전체 조회    
SELECT * FROM V_EMP_DEPT;

-- Where 절 사용해보기
SELECT * FROM V_EMP_DEPT WHERE dept_name = '개발';

SELECT EMP_NAME, SALARY FROM V_EMP_DEPT WHERE SALARY >= 5000;

