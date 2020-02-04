USE test_shop;

/* Задача №1. Подсчитайте средний возраст пользователей в таблице users. */

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS age FROM users;

/* Задача №2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
   Следует учесть, что необходимы дни недели текущего года, а не года рождения. */

SELECT
	DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day, COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC;

/* Задача №3. Подсчитайте произведение чисел в столбце таблицы. */

SELECT ROUND(EXP(SUM(LN(id)))) FROM users WHERE id < 6;