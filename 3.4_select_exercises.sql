USE albums;

DESCRIBE albums;

#The name of all albums by Pink Floyd
SELECT NAME AS "Albums from Pink Floyd" FROM albums
WHERE artist = "Pink Floyd";

#The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date FROM albums
WHERE NAME = "Sgt. Pepper's Lonely Hearts Club Band";


#The genre for the album Nevermind
SELECT genre FROM albums
WHERE NAME = "Nevermind";

#Which albums were released in the 1990s
SELECT NAME FROM albums
WHERE release_date BETWEEN 1990 AND 1999;

#Which albums had less than 20 million certified sales
SELECT NAME FROM albums
WHERE sales < 20.0;

/*ALL the albums WITH a genre of "Rock". Does NOT include "Hardrock or Progressive rock since they are treated different objects*/
SELECT NAME, genre FROM albums
WHERE genre = "Rock";

SELECT * FROM albums
WHERE genre LIKE "%rock%";
