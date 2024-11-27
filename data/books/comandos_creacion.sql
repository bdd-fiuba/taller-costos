CREATE TABLE Users (
user_id int PRIMARY KEY,
location varchar(100),
age int);

COPY Users
FROM '/docker-entrypoint-initdb.d/Users.csv'
DELIMITER ';'
CSV HEADER
ENCODING 'LATIN1';

--#####################################################################

CREATE TABLE Books (
ISBN varchar(20) PRIMARY KEY,
title varchar(300),
author varchar(500),
year int,
publisher varchar(150),
image_url_s varchar(100),
image_url_m varchar(100),
image_url_l varchar(100));

CREATE INDEX idx_book_author ON Books(author);

COPY Books
FROM '/docker-entrypoint-initdb.d/Books.csv'
DELIMITER ';'
CSV HEADER
ENCODING 'LATIN1';

--#####################################################################

CREATE TABLE Ratings (
user_id int,
ISBN varchar(20),
rating int,
PRIMARY KEY (user_id, ISBN),
FOREIGN KEY (user_id) REFERENCES Users,
FOREIGN KEY (ISBN) REFERENCES Books
);

CREATE INDEX idx_rating_isbn ON Ratings(isbn);

COPY Ratings
FROM '/docker-entrypoint-initdb.d/Book-Ratings.csv'
DELIMITER ';'
CSV HEADER
ENCODING 'LATIN1';

--#####################################################################

--#Para borrar alguna tabla...
--#DROP TABLE Ratings;
--#DROP TABLE Users;
--#DROP TABLE Books;
