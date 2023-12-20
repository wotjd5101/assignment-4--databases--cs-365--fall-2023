CREATE TABLE IF NOT EXISTS artist (
  artist_id   INT          NOT NULL,
  artist_name VARCHAR(128) NOT NULL,
  PRIMARY KEY (artist_id)
);

CREATE INDEX idx_artist_id ON artist(artist_id);

CREATE TABLE IF NOT EXISTS album (
  artist_id  INT          NOT NULL,
  album_id   INT          NOT NULL,
  album_name VARCHAR(128) NOT NULL,
  FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
                          ON UPDATE CASCADE
                          ON DELETE CASCADE,
  PRIMARY KEY (artist_id, album_id)
);

CREATE INDEX idx_album_id ON album(album_id);

CREATE TABLE IF NOT EXISTS track (
  artist_id  INT          NOT NULL,
  album_id   INT          NOT NULL,
  track_id   INT          NOT NULL,
  track_name VARCHAR(128) NOT NULL,
  time       DECIMAL(5,2) NOT NULL,
  FOREIGN KEY (artist_id, album_id)  REFERENCES album(artist_id, album_id),
  PRIMARY KEY (artist_id, album_id, track_id)
);

CREATE INDEX idx_track_id ON track(artist_id,track_id);

CREATE TABLE IF NOT EXISTS contains (
  artist_id INT,
  album_id  INT,
  track_id  INT,
  FOREIGN KEY (artist_id, album_id, track_id) REFERENCES track(artist_id, album_id, track_id)
);

CREATE INDEX idx_contains_id ON contains(album_id, artist_id);

CREATE TABLE IF NOT EXISTS compiles (
  artist_id INT,
  album_id  INT,
  FOREIGN KEY (artist_id, album_id) REFERENCES album(artist_id, album_id)
);

CREATE INDEX idx_compiles_artist_id ON compiles(artist_id);

CREATE TABLE IF NOT EXISTS played (
  artist_id  INT,
  album_id   INT,
  track_id   INT,
  played     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (artist_id, album_id) REFERENCES track(artist_id, album_id),
  PRIMARY KEY (artist_id, album_id, played)
);

CREATE INDEX idx_played ON played(played);

CREATE TABLE IF NOT EXISTS wasPlayedAt (
  artist_id  INT,
  album_id   INT,
  track_id   INT,
  played     TIMESTAMP,
  FOREIGN KEY (artist_id, album_id, played) REFERENCES played(artist_id, album_id, played)
);

CREATE INDEX idx_wasPlayed ON wasPlayedAt(track_id, artist_id);

SET NAMES 'utf8mb4';

ALTER DATABASE music DEFAULT CHARACTER SET UTF8;

ALTER DATABASE music DEFAULT CHARACTER SET UTF8;
ALTER TABLE artist CONVERT TO CHARACTER SET UTF8;
ALTER TABLE artist CONVERT TO CHARACTER SET UTF8;
ALTER TABLE track CONVERT TO CHARACTER SET UTF8;
ALTER TABLE contains CONVERT TO CHARACTER SET UTF8;
ALTER TABLE compiles CONVERT TO CHARACTER SET UTF8;
ALTER TABLE played CONVERT TO CHARACTER SET UTF8;
ALTER TABLE wasPlayedAt CONVERT TO CHARACTER SET UTF8;
