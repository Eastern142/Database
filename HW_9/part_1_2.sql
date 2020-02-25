					-- Практическое задание по теме “Транзакции, переменные, представления” --
					
	/* Задача №1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
 	 * Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции. */

-- Воспользуемся тестовой БД (different)
USE different;

-- Удалим таблицу если существует
DROP TABLE IF EXISTS users_from_shop_course_database;
-- Создадим копию таблицы если не ее существует
CREATE TABLE IF NOT EXISTS different.users_from_shop_course_database LIKE shop_course_database.users;

-- Скопируем все записи кроме первой (id = 1) в созданную таблицу
INSERT INTO different.users_from_shop_course_database
	SELECT * FROM shop_course_database.users WHERE id IN (2,3,4,5,6);

-- Выведем содержимое копии
SELECT * FROM users_from_shop_course_database;

-- Начало транзакции
START TRANSACTION;

-- Вставим запись с id = 1 в копию 
INSERT INTO different.users_from_shop_course_database
	SELECT * FROM shop_course_database.users WHERE id = 1;
-- Проверим правильность результата
SELECT * FROM users_from_shop_course_database;

-- Если все хорошо, подтвердим транзакцию
COMMIT;

	/* Задача №2. Создайте представление, которое выводит название name товарной позиции из таблицы products
	 * и соответствующее название каталога name из таблицы catalogs. */

-- Воспользуемся учебной БД (shop_course_database)
USE shop_course_database;

-- Решим задачу без представления
SELECT
	p.name,
	c.name
FROM
	products AS p
JOIN
	catalogs AS c
ON
	p.catalog_id = c.id;

-- Создадим представление
CREATE OR REPLACE VIEW products_catalogs AS
	SELECT
		p.name AS product,
		c.name AS catalog
FROM
	products AS p
JOIN
	catalogs AS c
ON
	p.catalog_id = c.id;

-- Обратимся к представлению
SELECT * FROM products_catalogs;

	/* Задача №3. (По желанию) Пусть имеется таблица с календарным полем created_at.
	 * В ней размещены разряженые календарные записи за август 2018 года
	 * '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.
	 * Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1,
	 * если дата присутствует в исходной таблице и 0, если она отсутствует. */

-- Воспользуемся тестовой БД (different)
USE different;

-- Создадим таблицу posts
CREATE TABLE IF NOT EXISTS posts (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	created_at DATE NOT NULL
);

-- Заполним таблицу posts
INSERT INTO posts VALUES
	(NULL, 'Первая запись', '2018-08-01'),
	(NULL, 'Вторая запись', '2018-08-04'),
	(NULL, 'Третья запись', '2018-08-16'),
	(NULL, 'Четвертая запись', '2018-08-17');

-- Выведем сожержимое таблицы posts
SELECT * FROM posts;

-- Создадим временную таблицу last_days которая позволит формировать список дней любого месяца в котором 31 день
CREATE TEMPORARY TABLE last_days (
	day INT
);

INSERT INTO last_days VALUES
	(0), (1), (3), (4), (5), (6), (7), (8), (9), (10),
	(11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
	(21), (22), (23), (24), (25), (26), (27), (28), (29), (30);

-- Сформируем календарь за август 2018 года
SELECT
	DATE(DATE('2018-08-31') - INTERVAL l.day DAY) AS day
FROM
	last_days AS l
ORDER BY
	day;

-- Сформируем результирующий запрос
SELECT
	DATE(DATE('2018-08-31') - INTERVAL l.day DAY) AS day,
	NOT ISNULL(p.name) AS order_exist
FROM
	last_days AS l
LEFT JOIN
	posts AS p
ON
	DATE(DATE('2018-08-31') - INTERVAL l.day DAY) = p.created_at
ORDER BY
	day;

	/* Задача №4 (По желанию) Пусть имеется любая таблица с календарным полем created_at.
	 * Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей. */

-- Воспользуемся таблицей posts только на этот раз вставим побольше записей
DROP TABLE IF EXISTS posts;

-- Создадим таблицу posts
CREATE TABLE IF NOT EXISTS posts (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	created_at DATE NOT NULL
);

-- Заполним таблицу posts
INSERT INTO posts VALUES
	(NULL, 'Первая запись', '2018-11-01'),
	(NULL, 'Вторая запись', '2018-11-02'),
	(NULL, 'Третья запись', '2018-11-03'),
	(NULL, 'Четвертая запись', '2018-11-04'),
	(NULL, 'Пятая запись', '2018-11-05'),
	(NULL, 'Шестая запись', '2018-11-06'),
	(NULL, 'Седьмая запись', '2018-11-07'),
	(NULL, 'Восьмая запись', '2018-11-08'),
	(NULL, 'Девятая запись', '2018-11-09'),
	(NULL, 'Десятая запись', '2018-11-10');

-- Выведем сожержимое таблицы posts
SELECT * FROM posts;

-- Начало транзакции
START TRANSACTION;

-- Сосчитаем количество записей в таблице posts
SELECT COUNT(*) FROM posts;
-- Выясним сколько записей нам предстоит удалить
SELECT 10 - 5;
-- Воспользуемся командой DELETE с ключевым словом LIMIT которому передадим значение 5
DELETE FROM posts ORDER BY created_at LIMIT 5;

-- Подтвердим транзакцию
COMMIT;

-- Проверим содержимое таблицы posts
SELECT * FROM posts;

	-- Решение с использованием динамических запросов
-- Восстановим содержимое таблицы posts
TRUNCATE posts;

INSERT INTO posts VALUES
	(NULL, 'Первая запись', '2018-11-01'),
	(NULL, 'Вторая запись', '2018-11-02'),
	(NULL, 'Третья запись', '2018-11-03'),
	(NULL, 'Четвертая запись', '2018-11-04'),
	(NULL, 'Пятая запись', '2018-11-05'),
	(NULL, 'Шестая запись', '2018-11-06'),
	(NULL, 'Седьмая запись', '2018-11-07'),
	(NULL, 'Восьмая запись', '2018-11-08'),
	(NULL, 'Девятая запись', '2018-11-09'),
	(NULL, 'Десятая запись', '2018-11-10');

-- Извлекаем сожержимое таблицы posts
SELECT * FROM posts;

-- Начало транзакции
START TRANSACTION;

-- Создаем динамический запрос с параметром в конструкции LIMIT
PREPARE postdel FROM 'DELETE FROM posts ORDER BY created_at LIMIT ?';
-- Значение для LIMIT подготовим в переменную total
SET @total = (SELECT COUNT(*) - 5 FROM posts);
-- Выполним динамический запрос при помощи команды EXECUTE
EXECUTE postdel USING @total;

-- Подтвердим транзакцию
COMMIT;

-- Посмотрим на результат
SELECT * FROM posts;

	-- Решение с использованием одного запроса
-- Восстановим содержимое таблицы posts
TRUNCATE posts;

INSERT INTO posts VALUES
	(NULL, 'Первая запись', '2018-11-01'),
	(NULL, 'Вторая запись', '2018-11-02'),
	(NULL, 'Третья запись', '2018-11-03'),
	(NULL, 'Четвертая запись', '2018-11-04'),
	(NULL, 'Пятая запись', '2018-11-05'),
	(NULL, 'Шестая запись', '2018-11-06'),
	(NULL, 'Седьмая запись', '2018-11-07'),
	(NULL, 'Восьмая запись', '2018-11-08'),
	(NULL, 'Девятая запись', '2018-11-09'),
	(NULL, 'Десятая запись', '2018-11-10');

-- Убедимся что таблица posts находится в исходном состоянии
SELECT * FROM posts;

-- Воспользуемся самообъединением таблиц и выполним многотабличный оператор DELETE
DELETE
	posts
FROM
	posts
JOIN
	(SELECT
		created_at
	FROM
		posts
	ORDER BY
		created_at DESC
	LIMIT 5, 1) AS delpst
ON
	posts.created_at <= delpst.created_at;

-- Проверим содержимое таблицы posts
SELECT * FROM posts;

					-- Практическое задание по теме “Хранимые процедуры и функции, триггеры" --
					
	/* Задача №1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
	 * С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
	 * с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
	 * с 18:00 до 00:00 — "Добрый вечер",
	 * с 00:00 до 6:00 — "Доброй ночи". */

/* Никак не мог решить проблему с данной ошибкой:
 * Error occurred during SQL script execution
 * Причина:
 * SQL Error [1418] [HY000]: This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable) */

-- Прочитал документацию и отключил проверку, только тогда проблема была решена, видеоурок просмотрел, законспектировал и все равно пока с трудом понимаю в чем проблема с этой проверкой:
SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER //
CREATE FUNCTION hello ()
RETURNS TEXT NOT DETERMINISTIC
BEGIN
	SET @nowtime = HOUR(NOW());
	CASE
		WHEN @nowtime BETWEEN 0 AND 5 THEN
			RETURN 'Доброй ночи';
		WHEN @nowtime BETWEEN 6 AND 11 THEN
			RETURN 'Доброе утро';
		WHEN @nowtime BETWEEN 12 AND 17 THEN
			RETURN 'Добрый день';
		WHEN @nowtime BETWEEN 18 AND 23 THEN
			RETURN 'Добрый вечер';
	END CASE;
END//

SELECT hello ()//

SHOW FUNCTION STATUS LIKE 'hello%';
DROP FUNCTION hello;

	/* Задача №2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
	 * Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
	 * Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
	 * При попытке присвоить полям NULL-значение необходимо отменить операцию. */

USE shop_course_database;

DELIMITER //
CREATE TRIGGER correct_name_description BEFORE INSERT ON products
FOR EACH ROW BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000'
		SET message_text = 'Поля name и description = NULL';
	END IF;
END//

INSERT INTO products
	(name, description, price, catalog_id)
VALUES
	(NULL, NULL, 1000, 1)//

SHOW TRIGGERS;
DROP TRIGGER correct_name_description;

-- При попытке присвоить полям NULL-значение необходимо отменить операцию
DELIMITER //

CREATE TRIGGER correct_name_description BEFORE UPDATE ON products
FOR EACH ROW BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000'
		SET message_text = 'Поля name и description = NULL';
	END IF;
END//