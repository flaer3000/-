--Количество исполнителей в каждом жанре
select genre_name, count(id_artist_ag) from Genres 
join Artists_Genres on Genres.id_genre = Artists_Genres.id_genre_ag
group by genre_name

--Количество треков, вошедших в альбомы 2019-2020 годов
select count(album_name) from Tracks
join albums on Tracks.id_album_t = Albums.id_album
where album_release_year >= '20190101' and album_release_year <= '20201231'

--Средняя продолжительность треков по каждому альбому
select album_name, avg(track_duration) from Tracks
join Albums on Tracks.id_album_t = Albums.id_album
group by album_name

--Все исполнители, которые не выпустили альбомы в 2020 году
select artist_name from Artists 
join Artists_Album on Artists.id_artist = Artists_Album.id_artist_aa 
join Albums on Albums.id_album = Artists_Album.id_album_aa 
where album_release_year not between '20200101' and '20201231' 
group by artist_name

--Названия сборников, в которых присутствует конкретный исполнитель (выбрана Taylor Swift)
select collection_title from Collections
join Collection_Tracks on Collection_Tracks.id_collection_ct = Collections.id_collection
join Tracks on Collection_Tracks.id_track_ct = Tracks.id_track
join Albums on Tracks.id_album_t = Albums.id_album
join Artists_Album on Artists_Album.id_album_aa = Albums.id_album
join Artists on Artists_Album.id_artist_aa = Artists.id_artist
where artist_name = 'Taylor Swift'
group by collection_title

--Название альбомов, в которых присутствуют исполнители более 1 жанра
select album_name, count(genre_name) from Albums 
join Artists_Album on Albums.id_album = Artists_Album.id_album_aa 
join Artists on Artists_Album.id_artist_aa = Artists.id_artist 
join Artists_Genres on Artists.id_artist = Artists_Genres.id_artist_ag 
join Genres on Genres.id_genre = Artists_Genres.id_genre_ag 
group by album_name 
having count(genre_name) > 1

--Наименование треков, которые не входят в сборники
select track_name from Tracks
left join Collection_Tracks on Tracks.id_track = Collection_Tracks.id_track_ct
where id_collection_ct is null

--Исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько)
select artist_name, track_duration from Tracks
join Albums on Tracks.id_album_t = Albums.id_album
join Artists_Album on Artists_Album.id_album_aa = Albums.id_album
join Artists on Artists_Album.id_artist_aa = Artists.id_artist 
where track_duration = (select min(track_duration) from tracks)


select album_name, count(track_name) from Tracks
join Albums on Tracks.id_album_t = Albums.id_album
group by album_name

--Название альбомов, содержащих наименьшее количество треков
select distinct album_name from Albums
left join Tracks on Tracks.id_album_t = Albums.id_album
where Tracks.id_album_t in (
    select id_album_t from Tracks
    group by id_album_t
    having count(id_album_t) = (
         select count(id_track)
         from Tracks
         group by id_album_t
         order by count
         limit 1
)
)

