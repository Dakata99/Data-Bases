USE DANAIL

-- 1

    -- 1.1
    ALTER TABLE MOVIE ADD CONSTRAINT UNIQUE_LENGTH UNIQUE(LENGTH)
    -- Няма да работи, ако вече има два филма с еднаква дължина.

    -- 1.2
    ALTER TABLE MOVIE ADD CONSTRAINT UNIQUE_LENGTH_STUDIO UNIQUE(LENGTH) -- ???

-- 2
ALTER TABLE MOVIE DROP CONSTRAINT UNIQUE_LENGTH
ALTER TABLE MOVIE DROP CONSTRAINT UNIQUE_LENGTH_STUDIO

-- 3
CREATE TABLE STUDENT(
    FN INT NOT NULL PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    EGN CHAR(10) NOT NULL UNIQUE,
    EMAIL VARCHAR(100) NOT NULL UNIQUE,
    BIRTHDAY DATE NOT NULL,
    UNISTART DATE NOT NULL,
    CONSTRAINT valid_fn CHECK(FN >= 0 AND FN <= 99999),
    CONSTRAINT valid_email CHECK(EMAIL LIKE '%@%.%'), -- 3.1
    CONSTRAINT valid_age CHECK(DATEDIFF(year, BIRTHDAY, UNISTART) >= 18)
)

INSERT INTO STUDENT(FN, NAME, EGN, EMAIL, BIRTHDAY, UNISTART)
VALUES(4715, 'Ahmed Asparuhov', '1452775', 'ahmed.asparuhov@gmail.com', '2000-08-21', '2018-08-21')

SELECT * FROM STUDENT
DROP TABLE STUDENT

-- 3.2
CREATE TABLE SUBJECTS(
    ID INT UNIQUE,
    NAME VARCHAR(30) NOT NULL
)

DROP TABLE SUBJECTS

-- 4
CREATE DATABASE TEST GO

USE TEST

CREATE TABLE PRODUCT(
    MAKER CHAR(1),
    MODEL CHAR(4),
    TYPE VARCHAR(7)
)

CREATE TABLE PRINTER(
    CODE INT,
    MODEL CHAR(4),
    COLOR CHAR(1) DEFAULT 'n',
    PRICE DECIMAL(9, 2)
)

CREATE TABLE CLASSES(
    CLASS VARCHAR(50),
    TYPE CHAR(2) CHECK(TYPE IN('bb', 'bc'))
)

-- 4.1

INSERT INTO PRODUCT
VALUES ('a', 'abcd', 'printer')

INSERT INTO PRINTER (CODE, MODEL)
VALUES (1, 'abcd')

INSERT INTO CLASSES
VALUES ('Bismark', 'bb')

-- 4.2
ALTER TABLE CLASSES ADD BORE FLOAT

-- 4.3
ALTER TABLE PRINTER DROP COLUMN PRINCE

-- 4.4
DROP TABLE PRODUCT, PRINTER, CLASSES

-- 4.5
USE DANAIL GO

DROP DATABASE TEST GO