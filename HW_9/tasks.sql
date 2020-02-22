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
	SELECT * FROM shop_course_database.users where id = 1;
-- Проверим правильность результата
SELECT * FROM users_from_shop_course_database;

-- Если все хорошо, подтвердим транзакцию
COMMIT;

	/* Задача №2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs. */

-- Воспользуемся учебной БД (shop_course_database)
USE shop_course_database;

-- Просмотрим содержимое таблиц
SELECT * FROM products, catalogs;

-- Создадим представление
CREATE VIEW prodcat AS
	SELECT
		p.name,
		c.name as catalogs
from products as p
join catalogs as c
on p.catalog_id = c.id;

-- Запросим список таблиц
SHOW TABLES;

-- Обратимся к представлению
SELECT * FROM prodcat;



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