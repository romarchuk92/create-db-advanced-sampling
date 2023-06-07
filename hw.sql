--=========== Создание и заполнение таблдлицы жанров==================
create table if not exists Genre (
genre_id serial primary key,
	genre_name varchar(40) not null unique 
);

insert into Genre(genre_name) values ('rap');
insert into Genre(genre_name) values ('rock');
insert into Genre(genre_name) values ('pop');

--=========== Создание и заполнение таблицы исполнителей==================
create table if not exists Artist (
	artist_id serial primary key,
	artist_name varchar(40) not null unique
);

insert into Artist(artist_name) values ('Клава Кока');
insert into Artist(artist_name) values ('Ария');
insert into Artist(artist_name) values ('Баста');
insert into Artist(artist_name) values ('Каста');

create table if not exists GenerArtist (
	primary key(genere_id, artist_id),
	genere_id integer not null references Genre(genre_ID),
	artist_id integer not null references Artist(artist_ID)
);

--Настройка связей
insert into GenerArtist(genere_id, artist_id) values (1, 3);
insert into GenerArtist(genere_id, artist_id) values (1, 4);
insert into GenerArtist(genere_id, artist_id) values (2, 2);
insert into GenerArtist(genere_id, artist_id) values (3, 1);

--=========== Создание и заполнение таблицы альбомов==================
create table if not exists Album (
	album_id serial primary key,
	album_name varchar(40) not null,
	album_year integer check (album_year >= 1979 and album_year <= 2023)	
);

insert into Album(album_name, album_year) values ('Баста-40', 2020);
insert into Album(album_name, album_year) values ('Неприлично о личном', 2019);
insert into Album(album_name, album_year) values ('Герой Асфальта', 1987);
insert into Album(album_name, album_year) values ('Быль в глаза', 2008);

create table if not exists ArtistAlbum (
	primary key(album_id, artist_id),
	album_id integer not null references Album(album_ID),
	artist_id integer not null references Artist(artist_ID)
);

--Настройка связей
insert into ArtistAlbum(album_id, artist_id) values (1, 3);
insert into ArtistAlbum(album_id, artist_id) values (2, 1);
insert into ArtistAlbum(album_id, artist_id) values (3, 2);
insert into ArtistAlbum(album_id, artist_id) values (4, 4);

--=========== Создание и заполнение таблицы треков==================
create table if not exists Track (
	track_id serial primary key,
	track_name varchar(40) not null,
	track_time integer not null,
	album_id integer not null references Album(album_ID)	
);

insert into Track(track_name, track_time, album_id) values ('Вокруг шум', 214, 4);
insert into Track(track_name, track_time, album_id) values ('Ла Ла Ла', 178, 2);
insert into Track(track_name, track_time, album_id) values ('Моя игра', 271, 1);
insert into Track(track_name, track_time, album_id) values ('Осколок Льда', 327, 3);
insert into Track(track_name, track_time, album_id) values ('Выпускной', 344, 1);
insert into Track(track_name, track_time, album_id) values ('Покинула чат', 192, 2);

--=========== Создание и заполнение таблицы сборников==================
create table if not exists Digest (
	digest_id serial primary key,
	digest_name varchar(40) not null,
	digest_year integer check (digest_year >= 1979 and digest_year <= 2023)  
);

insert into Digest(digest_name, digest_year) values ('Сборник рока', 2005);
insert into Digest(digest_name, digest_year) values ('Сборник рэпа', 2015);
insert into Digest(digest_name, digest_year) values ('Сборник поп музыки', 2022);
insert into Digest(digest_name, digest_year) values ('Разное', 2023);

create table if not exists TrackDigest (
	primary key(track_id, digest_id),
	track_id integer not null references Track(track_ID),
	digest_id integer not null references Digest(digest_ID)
);

--Настройка связей
insert into TrackDigest(track_id, digest_id) values (1, 2);
insert into TrackDigest(track_id, digest_id) values (2, 3);
insert into TrackDigest(track_id, digest_id) values (3, 2);
insert into TrackDigest(track_id, digest_id) values (4, 1);
insert into TrackDigest(track_id, digest_id) values (5, 2);
insert into TrackDigest(track_id, digest_id) values (6, 3);
insert into TrackDigest(track_id, digest_id) values (1, 4);
insert into TrackDigest(track_id, digest_id) values (2, 4);
insert into TrackDigest(track_id, digest_id) values (3, 4);
insert into TrackDigest(track_id, digest_id) values (4, 4);
insert into TrackDigest(track_id, digest_id) values (5, 4);
insert into TrackDigest(track_id, digest_id) values (6, 4);

