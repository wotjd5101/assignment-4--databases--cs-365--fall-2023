SELECT CONCAT(artist.artist_name," ","recorded"," ",album.album_name) AS Recording
FROM artist
JOIN album
WHERE (artist.artist_id = album.artist_id);

SELECT artist_name, album_name
FROM artist, album
WHERE album.artist_id = (
    SELECT MAX(artist_id)
    FROM album
    WHERE artist.artist_id = album.artist_id
);

SELECT artist_name, album_name
FROM artist, album
WHERE album.artist_id = (
    SELECT MAX(artist_id)
    FROM compiles
    WHERE artist.artist_id = compiles.artist_id
);

SELECT album_name, track_name
FROM album, track
WHERE track.album_id = (
  SELECT MAX(album_id)
  FROM  contains
  WHERE album.album_id = contains.album_id
)
AND track.artist_id = (
  SELECT  MAX(artist_id)
  FROM contains
  WHERE album.artist_id = contains.artist_id
);

SELECT track_name, time
FROM track
INNER JOIN wasPlayedAt ON
(track.track_id = wasPlayedAt.track_id AND track.artist_id = wasPlayedAt.artist_id);
