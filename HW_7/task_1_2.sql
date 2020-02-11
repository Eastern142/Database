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