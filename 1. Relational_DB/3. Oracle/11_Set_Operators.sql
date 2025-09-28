/* 집합 연산자 주요 규칙
1. 컬럼의 갯수가 같아야 한다
2. 각 커럼의 데이터타입이 같거나 호환되어야 한다
3. 최종 결과의 컬럼 이름은 첫번째 SELECT문을 따라가야 한다
4. ORDER BY 는 마지막에 딱 한번만 사용 할 수 있다.
*/

-- 실습용 테이블 생성
CREATE TABLE CLASS_A (
    student_name VARCHAR2(50)
);
CREATE TABLE CLASS_B (
    student_name VARCHAR2(50)
);

-- 데이터 추가
INSERT INTO CLASS_A VALUES ('홍길동');
INSERT INTO CLASS_A VALUES ('김유신');
INSERT INTO CLASS_A VALUES ('이순신');

INSERT INTO CLASS_B VALUES ('강감찬');
INSERT INTO CLASS_B VALUES ('김유신');
INSERT INTO CLASS_B VALUES ('이순신');

COMMIT;

-- UNION: 두 결과 합치기 (중복 제거)

SELECT student_name FROM CLASS_A
UNION
SELECT student_name FROM CLASS_B;

-- UNION ALL : 두 결과 합치기 (중복 포함)

SELECT student_name FROM CLASS_A
UNION ALL
SELECT student_name FROM CLASS_B;

-- INTERSECT: 공통된 결과만 찾기 (교집합)

SELECT student_name FROM CLASS_A
INTERSECT
SELECT student_name FROM CLASS_B;

-- MINUS: 차이 나는 결과만 찾기 (차집합)

SELECT student_name FROM CLASS_A
MINUS
SELECT student_name FROM CLASS_B;