-- 분석함수

DROP TABLE EMPLOYEES;

CREATE TABLE EMPLOYEES(
    emp_id NUMBER(8) PRIMARY KEY,
    emp_name  VARCHAR2(50),
    dept_name VARCHAR2(50),
    salary    NUMBER(8, 2)
);

INSERT INTO EMPLOYEES VALUES (1001, '김사장', '경영', 9000);
INSERT INTO EMPLOYEES VALUES (2001, '박부장', '영업', 6200);
INSERT INTO EMPLOYEES VALUES (2002, '이부장', '영업', 6200);
INSERT INTO EMPLOYEES VALUES (2003, '오차장', '영업', 6000);
INSERT INTO EMPLOYEES VALUES (3001, '최과장', '개발', 4800);
INSERT INTO EMPLOYEES VALUES (3002, '정대리', '개발', 4500);
INSERT INTO EMPLOYEES VALUES (3003, '강사원', '개발', 4500);
COMMIT;

/* 순위함수 
RANK : 공동이 있음 다음등수 넘어가기 ex) 1 2 2 4
DENSE_RANK : 공동이 있어도 다음등수 보여주기 ex) 1 2 2 3
ROW_NUMBER : 공동 순위 없이 고유한 번호 부여 ex) 1 2 3 4
*/

SELECT
    emp_name,
    dept_name,
    salary,
    RANK()  OVER (PARTITION BY dept_name ORDER BY salary DESC) AS "RANK",
    DENSE_RANK() OVER (PARTITION BY dept_name ORDER BY salary DESC) AS "DENSE_RANK",
    ROW_NUMBER() OVER (PARTITION BY dept_name ORDER BY salary DESC) AS "ROW_NUMBER"
FROM
    EMPLOYEES
ORDER BY
    dept_name;
    
/* LEAD & LAG
LEAD : 내 뒤에 오는 행의 값을 가져오는 함수
LAG : 내 앞에 오는 행의 값을 가져오는 함수
*/

-- 실습: 부서별 급여 순서상에서, 각 직원의 급여와 바로 다음 순위 직원의 급여를 함께 조회하여 급여 차이를 계산해보기
-- LEAD(salary, 1, 0) salary = 가지고 오고 싶은 컬럼 1 = 현재행에서 몇 칸 뒤 행을 볼지 0 = 다음 행이 없을 경우 기본값 지정
SELECT
    emp_name,
    dept_name,
    salary,
    LEAD(salary, 1, 0) OVER (PARTITION BY dept_name ORDER BY salary DESC) AS "다음 순위 급여",
    salary - LEAD(salary, 1, 0) OVER (PARTITION BY dept_name ORDER BY salary DESC) AS "급여 차이"
FROM
    EMPLOYEES;