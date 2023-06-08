--======Задание №1===== Создание и заполнение таблдлицы жанров==================
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
insert into Track(track_name, track_time, album_id) values ('Моя игра (my game)', 271, 1);
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
insert into Digest(digest_name, digest_year) values ('Сборник поп музыки', 2019);
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


--=========Задание №2==============SELECT ЗАПРОСЫ===================================


select track_name, track_time from track
where track_time = (select MAX(track_time) from track);

select track_name from track
where track_time >= 210;

select digest_name from digest
where digest_year between 2018 and 2020;

select artist_name from artist
where artist_name not like '% %';

select track_name from track
where track_name like '%(my %' or track_name like 'my %' or track_name like 'my %' or track_name like '% my %' or track_name like '% my' or track_name like '% my)' or track_name like '%(мой %' or track_name like 'мой %' or track_name like 'мой %' or track_name like '% мой %' or track_name like '% мой' or track_name like '% мой)';
 

--=========Задание №3======================================================


select genre_name, count(GenerArtist.artist_id) as cnt from Genre 
left join GenerArtist on Genre.genre_id = GenerArtist.genere_id
group by genre_name;

select album_name, count(track.album_id) as cnt from Album 
left join Track on Album.album_id = Track.album_id
where album_year between 2019 and 2020 
group by album_name;

select album_name, avg(track.track_time) from Album 
left join Track on Album.album_id = Track.album_id 
group by album_name;

select artist_name, album_year from Artist 
left join ArtistAlbum on Artist.artist_id = ArtistAlbum.artist_id
left join Album on ArtistAlbum.album_id = Album.album_id
where album_year != 2020
group by artist_name, album_year;

select digest_name, artist_name from Digest 
left join TrackDigest on Digest.digest_id = TrackDigest.digest_id
left join Track on TrackDigest.track_id = Track.track_id
left join Album on Track.album_id = Album.album_id
left join ArtistAlbum on Album.album_id = ArtistAlbum.album_id
left join Artist on ArtistAlbum.artist_id = Artist.artist_id
where artist_name = 'Баста'
group by digest_name, artist_name;

