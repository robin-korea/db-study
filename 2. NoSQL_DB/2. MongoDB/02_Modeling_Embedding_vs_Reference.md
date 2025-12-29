# 02. 스키마 디자인: Embedding vs Referencing

## 1. MongoDB 모델링의 대원칙
RDBMS는 중복을 제거하는 **정규화(Normalization)**가 절대 원칙이지만, MongoDB는 읽기 성능을 극대화하기 위해 데이터 중복을 허용하는 **반정규화(Denormalization)**를 적극 권장한다.

> **핵심 전략:** "데이터를 어떻게 저장할까?"가 아니라 **"애플리케이션이 데이터를 어떻게 조회(Query)하는가?"**에 맞춰 설계해야 한다.

---

## 2. Embedding (내장 방식)
문서 안에 또 다른 문서를 배열이나 객체 형태로 직접 넣는 방식. (1:1 또는 1:Few 관계)

### 예시: 게시글과 댓글 (댓글이 적을 때)
```json
{
  "_id": 1,
  "title": "MongoDB 모델링",
  "comments": [
    { "user": "user1", "content": "유익하네요" },
    { "user": "user2", "content": "감사합니다" }
  ]
}
