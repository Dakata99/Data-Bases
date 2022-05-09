<details>
    <summary>BG</summary>

# Модификация на БД - задачи

## Ограничения - задачи Резюме:

### PRIMARY KEY
<ul>
    <li>може от един или повече атрибути</li>
    <li>не се допускат повторения</li>
    <li>не се допускат NULL стойности</li>
    <li>в една релация не може да има повече от един PK (кажи за Identity)</li>
</ul>

### UNIQUE
<ul>
    <li>може от един или повече атрибути</li>
    <li>не се допускат повторения</li>
    <li>допуска се NULL, но зависи кое СУБД ползваме</li>
    <li>в една релация може да има много UNIQUE ограничения</li>
</ul>

### FOREIGN KEY
<ul>
    <li>реферира PK в друга или същата таблица (в презентацията има пропуск)</li>
    <li>броят и типът на съставящите го атрибути трябва да съвпада с тези на PK</li>
    <li>допускат се повторения</li>
    <li>допуска се NULL</li>
    <li>в една релация може да има много FK</li>
</ul>

NOT NULL

CHECK

-- Зад. 1. а) Да се направи така, че да не може два филма да имат еднаква дължина. alter table movie add constraint unique_length unique(length); -- горното няма да работи, ако вече има два филма с еднаква дължина -- б) Да се направи така, че да не може едно студио да има два филма с еднаква дължина

-- Зад. 2. Изтрийте ограниченията от първа задача от Movie.

-- Зад. 3.
-- а) За всеки студент се съхранява следната информация: -- фак. номер - от 0 до 99999, първичен ключ; -- име - до 100 символа; -- ЕГН - точно 10 символа, уникално; -- e-mail - до 100 символа, уникален; -- рождена дата; -- дата на приемане в университета - трябва да бъде поне 18 години след рождената; -- за всички атрибути задължително трябва да има зададена стойност (не може NULL)

-- б) добавете валидация за e-mail адреса - да бъде във формат <нещо>@<нещо>.<нещо>

-- в) създайте таблица за университетски курсове - уникален номер и име

-- всеки студент може да се запише в много курсове и във всеки курс -- може да има записани много студенти. -- При изтриване на даден курс автоматично да се отписват всички студенти от него.

-- 1. Създайте нова база от данни с име test

CREATE DATABASE test GO

USE test

-- 2. Дефинирайте следните релации: -- а) Product(maker, model, type), където моделът е низ от точно 4 символа, maker - един символ, -- а type - низ до 7 символа -- б) Printer(code, model, color, price), където code е цяло число, color е 'y' или 'n' и по -- подразбиране е 'n', price - цена с точност до два знака след десетичната запетая -- в) Classes(class, type), където class е до 50 символа, а type може да бъде 'bb' или 'bc'

CREATE TABLE Product ( maker char(1), model char(4), type varchar(7) )

CREATE TABLE Printer ( code int, model char(4), color char(1) DEFAULT 'n', price decimal(9,2) )

CREATE TABLE Classes ( class varchar(50), type char(2) CHECK (type IN ('bb', 'bc')) )

-- 2. Добавете кортежи с примерни данни към новосъздадените релации. Добавете информация за принтер, -- за когото знаем само кода и модела.

INSERT INTO Product VALUES ('a', 'abcd', 'printer')

INSERT INTO Printer (code, model) VALUES (1, 'abcd')

INSERT INTO Classes VALUES ('Bismark', 'bb')

-- 3. Добавете към Classes атрибут bore - число с плаваща запетая.

ALTER TABLE Classes ADD bore float

-- 4. Напишете заявка, която премахва атрибута price от Printer.

ALTER TABLE Printer DROP COLUMN price

-- 5. Изтрийте всички таблици, които сте създали в това упражнение.

DROP TABLE Classes DROP TABLE Printer DROP TABLE Product

-- 6. Изтрийте базата test

USE master GO

DROP DATABASE test GO
<ol>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
</ol>

</details>

<details>
    <summary>ENG</summary>

# Modification of DB - problems

</details>

<details>
    <summary>DATA BASES</summary>

# MOVIES
<img src="../MOVIES.png"
     alt="Markdown Monster icon"
     style="float: left; margin-right: 10px;" />

# PRODUCTS
<img src="../PRODUCTS.png"
     alt="Markdown Monster icon"
     style="float: left; margin-right: 10px;" />

# SHIPS
<img src="../SHIPS.png"
     alt="Markdown Monster icon"
     style="float: left; margin-right: 10px;" />

</details>