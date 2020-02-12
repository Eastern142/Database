/* Использовал структуру интернет-магазина из видеоуроков */
USE shop_course_database;

/* Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет-магазине. */

/* Так как таблица orders пуста, добавил в нее несколько записей */
INSERT INTO orders (user_id) VALUE (1),(3),(5);

SELECT name
FROM users
WHERE id IN (SELECT user_id FROM orders)
ORDER BY name;

/* Выведите список товаров products и разделов catalogs, который соответствует товару. */

SELECT products.name AS products_name, catalogs.name AS catalogs_name
FROM products, catalogs
WHERE products.catalog_id = catalogs.id;

/* (По желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
   Поля from, to и label содержат английские названия городов, поле name — русское.
   Выведите список рейсов flights с русскими названиями городов.
*/

CREATE DATABASE IF NOT EXISTS flights_cities;

USE flights_cities;

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
	`from` VARCHAR(50),
	`to` VARCHAR(50)
);

INSERT INTO flights (`from`, `to`) VALUES
	('moscow', 'omsk'),
	('novgorod', 'kazan'),
	('irkutsk', 'moscow'),
	('omsk', 'irkutsk'),
	('moscow', 'kazan');
	
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	id SERIAL PRIMARY KEY,
	label VARCHAR(50),
	name VARCHAR(50)
);

INSERT INTO cities (label, name) VALUES
	('moscow', 'Москва'),
	('irkutsk', 'Иркутск'),
	('nowgorod', 'Новгород'),
	('kazan', 'Казань'),
	('omsk', 'Омск');