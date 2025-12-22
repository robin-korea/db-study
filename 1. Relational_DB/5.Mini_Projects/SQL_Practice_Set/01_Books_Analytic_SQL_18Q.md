```markdown
# 📚 Books DB Challenge: Advanced Analytics (18 Questions)

## 📌 Introduction
단일 테이블(`books`) 구조이지만, 데이터 내의 통계적 특징을 찾아내기 위해 **Subquery**, **CTE**, **Window Functions** 등 고급 SQL 기법을 적극 활용한 18가지 문제입니다.

```sql
-- 1. 페이지 수가 가장 많은 책 상위 10권 조회
SELECT title, pages FROM books 
ORDER BY pages DESC LIMIT 10;

-- 2. 2020년에 출판된 모든 도서 조회
SELECT * FROM books 
WHERE published_date LIKE '2020%';

-- 3. 평점이 4.5 이상 5.0 이하인 도서 조회
SELECT title, average_rating FROM books 
WHERE average_rating BETWEEN 4.5 AND 5.0;

-- 4. 전체 도서의 평균 페이지 수 계산
SELECT AVG(pages) FROM books;

-- 5. 2015년부터 2023년까지 연도별 출판 도서 수 계산
SELECT published_date, COUNT(*) 
FROM books 
WHERE published_date BETWEEN '2015' AND '2023'
GROUP BY published_date;

-- 6. 500페이지 이상인 도서들의 평균 평점 계산
SELECT AVG(average_rating) 
FROM books 
WHERE pages > 500;

-- 7. 가장 많은 책을 쓴 작가 상위 10명 조회
SELECT author, COUNT(*) as book_count
FROM books
GROUP BY author
ORDER BY book_count DESC LIMIT 10;

-- 8. 5권 이상 출판했으면서 평균 평점이 4.0 이상인 작가 조회
SELECT author, AVG(average_rating) as author_rating
FROM books
GROUP BY author
HAVING COUNT(*) >= 5 AND author_rating > 4.0;

-- 9. 연간 출판된 책이 1,000권 이상인 해의 평균 페이지 수 조회
SELECT published_date, AVG(pages)
FROM books
GROUP BY published_date
HAVING COUNT(*) > 1000;

-- 10. 전체 평균 페이지 수보다 긴 책들 조회
SELECT title, pages FROM books
WHERE pages > (SELECT AVG(pages) FROM books);

-- 11. 작가의 평균 평점이 전체 도서 평균 평점보다 높은 작가 조회
SELECT author, AVG(average_rating)
FROM books
GROUP BY author
HAVING AVG(average_rating) > (SELECT AVG(average_rating) FROM books);

-- 12. 역대 최고 평점 책과 같은 해에 출판된 다른 책들 조회
SELECT title, published_date
FROM books
WHERE published_date = (
    SELECT published_date FROM books ORDER BY average_rating DESC LIMIT 1
);

-- 13. 20권 이상 쓴 다작 작가들(CTE) 중에서, 그들의 최고 평점작을 조회
WITH ProlificAuthors AS (
    SELECT author FROM books GROUP BY author HAVING COUNT(*) > 20
)
SELECT b.title, b.author, b.average_rating
FROM books b
JOIN ProlificAuthors p ON b.author = p.author
WHERE b.average_rating = (
    SELECT MAX(average_rating) FROM books b2 WHERE b2.author = b.author
);

-- 14. 책을 Short, Medium, Long으로 분류하고(CTE) 각 그룹의 평균 평점 조회
WITH BookCategories AS (
    SELECT average_rating,
    CASE 
        WHEN pages < 200 THEN 'Short'
        WHEN pages BETWEEN 200 AND 400 THEN 'Medium'
        ELSE 'Long'
    END as category
    FROM books
)
SELECT category, AVG(average_rating)
FROM BookCategories
GROUP BY category;

-- 15. 2010~2023년 사이 각 연도별 최고 평점 도서 조회 (10페이지 미만 제외, Window Function)
WITH RankedBooks AS (
    SELECT title, published_date, average_rating,
    RANK() OVER (PARTITION BY published_date ORDER BY average_rating DESC) as rnk
    FROM books
    WHERE pages >= 10 AND published_date BETWEEN '2010' AND '2023'
)
SELECT * FROM RankedBooks WHERE rnk = 1;

-- 16. 10권 이상 썼으며, 모든 책의 평점 편차가 0.5 이내인 '기복 없는' 작가 찾기
WITH AuthorStats AS (
    SELECT author, AVG(average_rating) as avg_rating
    FROM books GROUP BY author HAVING COUNT(*) >= 10
)
SELECT a.author
FROM AuthorStats a
JOIN books b ON a.author = b.author
GROUP BY a.author
HAVING MAX(ABS(b.average_rating - a.avg_rating)) <= 0.5;

-- 17. '연도별 평균보다 짧지만', '평점은 평균 이상'이고, '주로 장편을 쓰는 작가'의 책 찾기
WITH YearAvg AS (
    SELECT published_date, AVG(pages) as y_avg_page FROM books GROUP BY published_date
),
LongBookAuthors AS (
    SELECT author FROM books GROUP BY author HAVING AVG(pages) > 400
)
SELECT b.title, b.author
FROM books b
JOIN YearAvg y ON b.published_date = y.published_date
WHERE b.pages < y.y_avg_page -- 조건 1: 그 해 평균보다 짧음
  AND b.pages < 300 AND b.average_rating > (SELECT AVG(average_rating) FROM books) -- 조건 2
  AND b.author IN (SELECT author FROM LongBookAuthors); -- 조건 3: 장편 작가

-- 18. 1950, 60년대 등 10년 단위(Decade)로 평점 4.0 이상 책을 가장 많이 낸 '시대의 지배자' 작가 찾기
WITH HighRatedBooks AS (
    SELECT author, FLOOR(published_date / 10) * 10 as decade
    FROM books
    WHERE average_rating >= 4.0
),
DecadeCounts AS (
    SELECT decade, author, COUNT(*) as cnt
    FROM HighRatedBooks
    GROUP BY decade, author
),
RankedAuthors AS (
    SELECT decade, author, cnt,
    RANK() OVER (PARTITION BY decade ORDER BY cnt DESC) as rnk
    FROM DecadeCounts
)
SELECT decade, author, cnt
FROM RankedAuthors
WHERE rnk = 1
ORDER BY decade;
