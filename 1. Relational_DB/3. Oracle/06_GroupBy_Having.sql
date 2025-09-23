DROP TABLE EMPLOYEES;

CREATE TABLE EMPLOYEES (
    emp_id    NUMBER(4) PRIMARY KEY,
    emp_name  VARCHAR2(50),
    dept_name VARCHAR2(50),
    salary    NUMBER(8, 2)
);


INSERT INTO EMPLOYEES VALUES (1001, '김사장', '경영', 9000);
INSERT INTO EMPLOYEES VALUES (2001, '박부장', '영업', 6000);
INSERT INTO EMPLOYEES VALUES (2002, '이부장', '영업', 6200);
INSERT INTO EMPLOYEES VALUES (3001, '최과장', '개발', 4800);
INSERT INTO EMPLOYEES VALUES (3002, '정대리', '개발', 4500);
INSERT INTO EMPLOYEES VALUES (3003, '강사원', '개발', 4000);
COMMIT;

-- GROUP BY : 그룹별로 묶어서 계산하기

-- 각 부서별로 직원이 몇 명인지, 총 급여와 평균 급여는 얼마인지 알아보기.

SELECT
    dept_name,
    COUNT(*) AS "직원 수",
    SUM(salary) AS "총 급여",
    ROUND(AVG(salary)) AS "평균 급여"
FROM
    EMPLOYEES
GROUP BY
    dept_name;
    
-- HAVING :  그룹에 대한 조건 걸기 (WHERE가 일반 데이터를 필터링한다면, HAVING은 GROUP BY로 만들어진 그룹 자체를 필터링하는 역할)

-- 위에서 구한 부서별 통계 중, 평균 급여가 5000 이상인 부서만 골라서 보기.

SELECT
    dept_name,
    COUNT(*) AS "직원 수",
    SUM(salary) AS "총 급여",
    ROUND(AVG(salary)) AS "평균 급여"
FROM
    EMPLOYEES
GROUP BY
    dept_name
HAVING
     ROUND(AVG(salary)) >= 5000;
