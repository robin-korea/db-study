# 🎵 Spotify SQL Challenge: Complex JOINs (18 Questions)

## 📌 Introduction
Spotify 데이터베이스 구조(Artists, Albums, Tracks, Genres)를 기반으로 **N:M(다대다) 관계**를 해소하고, 복잡한 데이터 조회를 구현한 18가지 실전 예제입니다.

```sql
-- 1. 모든 앨범의 제목과 해당 아티스트의 이름을 조회 (r_albums_artists 연결 테이블 사용)
SELECT al.name AS album_title, ar.name AS artist_name
FROM albums al
JOIN r_albums_artists r ON al.id = r.album_id
JOIN artists ar ON r.artist_id = ar.id;

-- 2. 모든 트랙의 이름과 해당 트랙이 수록된 앨범 제목을 조회
SELECT t.name AS track_name, al.name AS album_title
FROM tracks t
JOIN r_albums_tracks r ON t.id = r.track_id
JOIN albums al ON r.album_id = al.id;

-- 3. 아티스트의 이름과 그들의 장르(Genre)를 조회
SELECT ar.name, g.id AS genre
FROM artists ar
JOIN r_artist_genre r ON ar.id = r.artist_id
JOIN genres g ON r.genre_id = g.id;

-- 4. 트랙명, 아티스트명, 앨범명을 한 번에 조회 (다중 조인)
SELECT t.name AS track, ar.name AS artist, al.name AS album
FROM tracks t
JOIN r_track_artist rta ON t.id = rta.track_id
JOIN artists ar ON rta.artist_id = ar.id
JOIN r_albums_tracks rat ON t.id = rat.track_id
JOIN albums al ON rat.album_id = al.id;

-- 5. 각 앨범에 참여한 모든 아티스트 목록 조회
SELECT al.name AS album, ar.name AS artist
FROM albums al
JOIN r_albums_artists r ON al.id = r.album_id
JOIN artists ar ON r.artist_id = ar.id
ORDER BY al.name;

-- 6. 트랙 이름과 해당 트랙의 오디오 특징(danceability, energy) 조회
SELECT t.name, af.danceability, af.energy
FROM tracks t
JOIN audio_features af ON t.id = af.id;

-- 7. 트랙이 5개 이상인 아티스트들의 평균 트랙 인기도(popularity) 조회
SELECT ar.name, AVG(t.popularity) AS avg_pop
FROM artists ar
JOIN r_track_artist r ON ar.id = r.artist_id
JOIN tracks t ON r.track_id = t.id
GROUP BY ar.name
HAVING COUNT(t.id) >= 5;

-- 8. 각 앨범에 수록된 트랙의 개수 카운트
SELECT al.name, COUNT(r.track_id) AS track_count
FROM albums al
JOIN r_albums_tracks r ON al.id = r.album_id
GROUP BY al.name;

-- 9. 앨범을 가장 많이 발매한 아티스트 상위 리스트 조회
SELECT ar.name, COUNT(r.album_id) AS album_count
FROM artists ar
JOIN r_albums_artists r ON ar.id = r.artist_id
GROUP BY ar.name
ORDER BY album_count DESC;

-- 10. 각 아티스트별로 가장 'Danceable'한(춤추기 좋은) 트랙 조회
SELECT ar.name, t.name, MAX(af.danceability)
FROM artists ar
JOIN r_track_artist rta ON ar.id = rta.artist_id
JOIN tracks t ON rta.track_id = t.id
JOIN audio_features af ON t.id = af.id
GROUP BY ar.name, t.name;

-- 11. 2020년에 발매된 앨범명과 아티스트 조회
SELECT al.name, ar.name
FROM albums al
JOIN r_albums_artists r ON al.id = r.album_id
JOIN artists ar ON r.artist_id = ar.id
WHERE al.release_date BETWEEN '2020-01-01' AND '2020-12-31';

-- 12. 앨범 트랙에는 피처링 등으로 참여했으나, 정작 본인의 앨범은 없는 아티스트 조회 (LEFT JOIN)
SELECT ar.name
FROM artists ar
JOIN r_track_artist rta ON ar.id = rta.artist_id
LEFT JOIN r_albums_artists raa ON ar.id = raa.artist_id
WHERE raa.album_id IS NULL;

-- 13. 보유한 트랙들의 평균 에너지(Energy) 수치가 가장 높은 아티스트 1명 조회
SELECT ar.name, AVG(af.energy) as avg_energy
FROM artists ar
JOIN r_track_artist r ON ar.id = r.artist_id
JOIN audio_features af ON r.track_id = af.id
GROUP BY ar.name
ORDER BY avg_energy DESC LIMIT 1;

-- 14. High Energy(>0.8) 곡과 Low Energy(<0.3) 곡을 모두 보유한 아티스트 조회 (Subquery)
SELECT distinct ar.name
FROM artists ar
JOIN r_track_artist r ON ar.id = r.artist_id
JOIN audio_features af ON r.track_id = af.id
WHERE af.energy > 0.8
AND ar.id IN (
    SELECT ar2.id FROM artists ar2
    JOIN r_track_artist r2 ON ar2.id = r2.artist_id
    JOIN audio_features af2 ON r2.track_id = af2.id
    WHERE af2.energy < 0.3
);

-- 15. 수록곡이 10곡을 초과하는 앨범만 조회
SELECT al.name, COUNT(r.track_id) as cnt
FROM albums al
JOIN r_albums_tracks r ON al.id = r.album_id
GROUP BY al.name
HAVING cnt > 10;

-- 16. 각 장르(Genre)별로 가장 인기도(popularity)가 높은 트랙 조회
SELECT g.id as genre, t.name, t.popularity
FROM genres g
JOIN r_artist_genre rag ON g.id = rag.genre_id
JOIN r_track_artist rta ON rag.artist_id = rta.artist_id
JOIN tracks t ON rta.track_id = t.id
WHERE (g.id, t.popularity) IN (
    SELECT g2.id, MAX(t2.popularity)
    FROM genres g2
    JOIN r_artist_genre rag2 ON g2.id = rag2.genre_id
    JOIN r_track_artist rta2 ON rag2.artist_id = rta2.artist_id
    JOIN tracks t2 ON rta2.track_id = t2.id
    GROUP BY g2.id
);

-- 17. 트랙들의 평균 인기도가 가장 높은 장르 찾기
SELECT g.id, AVG(t.popularity) as avg_pop
FROM genres g
JOIN r_artist_genre rag ON g.id = rag.genre_id
JOIN r_track_artist rta ON rag.artist_id = rta.artist_id
JOIN tracks t ON rta.track_id = t.id
GROUP BY g.id
ORDER BY avg_pop DESC LIMIT 1;

-- 18. 재생 시간이 5분(300,000ms) 이상인 대곡과 아티스트 조회
SELECT t.name, ar.name, t.duration_ms
FROM tracks t
JOIN r_track_artist rta ON t.id = rta.track_id
JOIN artists ar ON rta.artist_id = ar.id
WHERE t.duration_ms >= 300000;
