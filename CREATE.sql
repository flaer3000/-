create table if not exists Artists (
	id_artist serial primary key,
	artist_name VARCHAR (100) not null
);


create table if not exists Albums (
	id_album integer primary key,
	album_name varchar (100) not null,
	album_release_year date not null
);


create table if not exists Tracks (
	id_track integer primary key,
	track_name varchar (100) not null,
	track_duration time not null,
	id_album integer references Albums(id_album) not null
);


create table if not exists Genres (
	id_genre serial primary key,
	genre_name varchar (100) not null unique
);


create table if not exists Artists_Genres (
	id_artist integer references Artists(id_artist) not null,
	id_genre integer references Genres(id_genre) not null,
	constraint pk primary key (id_artist, id_genre)
);


create table if not exists Artists_Album (
	id_artist integer references Artists(id_artist) not null,
	id_album integer references Albums(id_album) not null,
	constraint pk_ primary key (id_artist, id_album)
);


create table if not exists Collections (
	id_collection serial primary key,
	collection_title varchar (100) not null,
	collection_date date not null
);


create table if not exists Collection_Tracks (
	id_collection integer references Collections(id_collection) not null,
	id_track integer references Tracks(id_track) not null,
	constraint pk__ primary key (id_collection, id_track)
);

