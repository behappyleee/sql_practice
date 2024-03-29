-- https://en.wikibooks.org/wiki/SQL_Exercises/Movie_theatres
-- 4.1 Select the title of all movies.
SELECT * FROM movies m;

-- 4.2 Show all the distinct ratings in the database.
SELECT DISTINCT(m.rating) FROM movies m;

-- 4.3  Show all unrated movies.
SELECT m.title FROM movies m WHERE ISNULL(m.rating);

-- 4.4 Select all movie theaters that are not currently showing a movie.
SELECT m.Name FROM movietheaters m WHERE ISNULL(m.movie);

-- 4.5 Select all data from all movie theaters 
    -- and, additionally, the data from the movie that is being shown in the theater (if one is being shown).
     SELECT m.name, m2.title  
       FROM movietheaters m 
 INNER JOIN movies m2
  		 ON m.movie = m2.code 
 ;

SELECT * FROM movies m;
SELECT * FROM movietheaters m;


-- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
          SELECT  m.title
                , m2.name
            FROM movies m
 LEFT OUTER JOIN movietheaters m2 
              ON m.code = m2.movie;  
         
-- TODO 여기서 부터 진행 하기 !!!!!!!!!!!!!!!!!!! 2022 12 26 ~ !!!!! 여기서부터 진행 하기 !!!!!!!!!!!!!!!!!    
             
-- 4.7 Show the titles of movies not currently being shown in any theaters.
		SELECT 
				m.title
			,	m2.movie 
		  FROM movies m
	 LEFT JOIN movietheaters m2 
		    ON m.code = m2.movie
		WHERE m2.Movie IS NULL;  
             
-- 4.8 Add the unrated movie "One, Two, Three".
SELECT * FROM movies m;
INSERT INTO movies (code, title) VALUES(9, 'One');
INSERT INTO movies (code, title) VALUES(10, 'Two');
INSERT INTO movies (code, title) VALUES(11, 'Three');
	
-- 4.9 Set the rating of all unrated movies to "G".
UPDATE movies SET rating = 'G' WHERE rating IS NULL;

-- TODO DELETE 안 됨 !! 확인하여보기 CASCADE 문제 같음 !
-- 4.10 Remove movie theaters projecting movies rated "NC-17".
DELETE FROM movies WHERE rating = 'NC-17' CASCADE;


