-- 1. CASE

-- Изчислява input expression и започва да търси последователно 
-- WHEN_expression, чиято стойност съвпада.

-- Резултатът от CASE е стойността на RESULT_expression съответстващ 
-- на намерената алтернатива.

-- ELSE секцията не е задължителна

-- CASE input_expression 
-- WHEN WHEN_expression_1 THEN RESULT_expression_1 
-- WHEN WHEN_expression_2 THEN RESULT_expression_2 
-- ... 
-- WHEN WHEN_expression_N THEN RESULT_expression_N 
-- [ ELSE else_result_expression ] 
-- END

-- Съкратен вариант, при който алтернативите са булеви изрази. 
-- RESULT_expression на първият намерен със стойност TRUE формира резултата на CASE

-- CASE 
-- WHEN BOOL_expression_1 THEN RESULT_expression_1 
-- WHEN BOOL_expression_2 THEN RESULT_expression_2 
-- ... 
-- WHEN BOOL_expression_N THEN RESULT_expression_N 
-- [ ELSE else_result_expression ] 
-- END

-- 2. COALESCE ( expression1, expression2, ..., expressionN )

-- Пресмята последователно аргументите и връща текущата стойност на 
-- първия израз, който при проверката е бил различен от NULL.

-- SELECT COALESCE(NULL, NULL, 'third_value', 'fourth_value')

-- Връща 'third value'

-- COALESCE е кратък запис на следния CASE:

-- CASE 
-- WHEN (expression1 IS NOT NULL) THEN expression1 
-- WHEN (expression2 IS NOT NULL) THEN expression2 
-- ... 
-- ELSE expressionN 
-- END

-- 3. ISNULL function

-- ISNULL (CHECK, REPLACEMENT)

-- Проверява дали CHECK е NULL. Ако да - резултата е REPLACEMENT. 
-- Ако CHECK не е NULL - връща неговата стойност.

-- SELECT ISNULL(NULL, 2 + 2)

-- SELECT ISNULL(1, 2)

-- 4. Функции за извличане на компонент на дата

-- DAY(some_date) - връща деня за подадената като параметър дата 
-- MONTH(some_date) - връща месеца за подадената като параметър дата 
-- YEAR(some_date) - връща годината за подадената като параметър дата

-- Пример:

USE SHIPS

SELECT NAME, DATE, DAY(DATE) BattleDay, MONTH(DATE) BattleMonth, YEAR(DATE) BattleYear
FROM BATTLES

-- Демонстрационна задача:

-- От базата PC, да се извлече в таблица със описаните по-долу колони,
-- следната информация за компютри и лаптопи:

-- 1. Модел на устройство (MODEL)
-- 2. Тип на устройството (device_type) със стойности:
--      'P' за компютри 
--      'L' за лаптопи
-- 3. Честота на процесора (SPEED)
-- 4. Оптично устройство (CD); за лаптопи да има стойност NULL
-- 5. Екран (SCREEN); за компютри да има стойност NULL

USE PC

-- Едно решение с използване на материала от предишните упражнения би изглеждало така:

SELECT MODEL, 'P' AS TYPE, SPEED, CD, NULL AS SCREEN
FROM PC
UNION
SELECT MODEL, 'L' AS TYPE, SPEED, NULL AS CD, SCREEN
FROM LAPTOP

-- Предвид това, че няма общи модели между PC-та и лаптопи, също така 
-- бихме могли да направиме следното:

SELECT COALESCE(PC.MODEL, LAPTOP.MODEL) AS MODEL, CASE  WHEN PC.MODEL IS NULL THEN 'L' 
                                                        WHEN LAPTOP.MODEL IS NULL THEN 'P' END AS TYPE, 
                                                  CASE  WHEN PC.SPEED IS NOT NULL THEN PC.SPEED 
                                                        WHEN LAPTOP.SPEED IS NOT NULL THEN LAPTOP.SPEED END AS SPEED, CD, SCREEN
FROM PC
    FULL OUTER JOIN LAPTOP ON PC.MODEL = LAPTOP.MODEL

-- Решения на задачите от упражненията:

-- 1.1. Напишете заявка, която за всеки филм, по-дълъг от 120 минути, 
-- извежда заглавие, година, име и адрес на студио.

USE MOVIES

SELECT TITLE, YEAR, NAME, ADDRESS
FROM MOVIE
    JOIN STUDIO ON STUDIONAME = NAME
WHERE LENGTH > 120

-- 1.2. Напишете заявка, която извежда името на студиото и имената на 
-- актьорите, участвали във филми, произведени от това студио, подредени по име на студио.

USE MOVIES

SELECT DISTINCT STUDIONAME, STARNAME
FROM MOVIE
    JOIN STARSIN ON TITLE = MOVIETITLE AND YEAR = MOVIEYEAR
ORDER BY STUDIONAME

-- 1.3. Напишете заявка, която извежда имената на продуцентите на филмите, 
-- в които е играл Harrison Ford.

USE MOVIES

SELECT DISTINCT e.NAME
FROM MOVIE m
    JOIN STARSIN s ON m.TITLE = s.MOVIETITLE AND m.YEAR = s.MOVIEYEAR
    JOIN MOVIEEXEC e ON e.CERT# = m.PRODUCERC# 
WHERE STARNAME = 'Harrison Ford'

-- 1.4. Напишете заявка, която извежда имената на актрисите, играли във филми на MGM.

USE MOVIES

SELECT DISTINCT ms.NAME
FROM MOVIE m
    JOIN STARSIN s ON m.TITLE = s.MOVIETITLE AND m.YEAR = s.MOVIEYEAR
    JOIN MOVIESTAR ms ON s.STARNAME = ms.NAME
WHERE STUDIONAME = 'MGM' AND ms.GENDER = 'F'

-- 1.5. Напишете заявка, която извежда името на продуцента и имената на 
-- филмите, продуцирани от продуцента на 'Star Wars'.

USE MOVIES

SELECT *
FROM MOVIE m
    JOIN MOVIEEXEC e ON e.CERT# = m.PRODUCERC#
WHERE m.PRODUCERC# = (  SELECT PRODUCERC#
                        FROM MOVIE
                        WHERE TITLE = 'Star Wars' AND YEAR = 1977)

SELECT e.NAME, m.TITLE
FROM MOVIE m
    JOIN MOVIEEXEC e ON e.CERT# = m.PRODUCERC#
    JOIN MOVIE m2 ON m2.TITLE = 'Star Wars' AND m2.YEAR = 1977
WHERE m.PRODUCERC# = m2.PRODUCERC#

-- 1.6. Напишете заявка, която извежда имената на актьорите не участвали в нито един филм.

USE MOVIES

SELECT NAME
FROM MOVIESTAR
    LEFT OUTER JOIN starsin ON NAME = STARNAME
WHERE STARNAME IS NULL

-- 2.1. Напишете заявка, която извежда производител, модел и тип на продукт 
-- за тези производители, за които съответния продукт не се продава 
-- (няма го в таблиците PC, лаптоп или принтер).

USE PC

SELECT p.MAKER, p.MODEL, TYPE
FROM PRODUCT p
    LEFT OUTER JOIN (SELECT MODEL FROM PC 
                    UNION
                    SELECT MODEL FROM LAPTOP
                    UNION
                    SELECT MODEL FROM PRINTER) ct ON p.MODEL = ct.MODEL
WHERE ct.MODEL IS NULL

SELECT MAKER, MODEL, TYPE
FROM PRODUCT
WHERE MODEL NOT IN (SELECT MODEL FROM PC) AND MODEL NOT IN (SELECT MODEL FROM LAPTOP) 
                                          AND MODEL NOT IN (SELECT MODEL FROM PRINTER)

USE SHIPS

-- 3.1. Напишете заявка, която за всеки кораб извежда името му, държавата, 
-- броя оръдия и годината на пускане (launched).

SELECT s.NAME, c.COUNTRY, c.NUMGUNS, s.LAUNCHED
FROM SHIPS s
    JOIN CLASSES c ON s.CLASS = c.CLASS

-- 3.2. Напишете заявка, която извежда имената на корабите, участвали в битка от 1942г.

SELECT DISTINCT SHIP
FROM OUTCOMES o
    JOIN BATTLES b ON o.BATTLE = b.NAME
WHERE YEAR(date) = 1942

-- 3.3. За всяка страна изведете имената на корабите, които никога не са участвали в битка.

SELECT c.COUNTRY, s.NAME
FROM CLASSES c
    JOIN SHIPS s ON c.class = s.class
    LEFT OUTER JOIN OUTCOMES o ON s.NAME = o.SHIP
WHERE o.SHIP IS NULL

-- Допълнителна задача

-- Имената на класовете, за които няма кораб, пуснат на вода 
-- (launched) след 1921 г. Ако за класа няма пуснат никакъв кораб, 
-- той също трябва да излезе в резултата.

SELECT CLASS
FROM CLASSES
WHERE CLASS NOT IN (SELECT CLASS FROM SHIPS WHERE LAUNCHED > 1921)

SELECT c.CLASS
FROM CLASSES c
    LEFT OUTER JOIN SHIPS s ON c.CLASS = s.CLASS AND s.LAUNCHED > 1921
WHERE s.NAME IS NULL