/* Задача №1. Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем. */
USE vk;

SELECT 
	from_user_id,
	concat(u.firstname, ' ', u.lastname) as name,
	count(*) AS 'messages count'
FROM messages m
JOIN users u ON u.id = m.from_user_id
WHERE to_user_id = 1
GROUP BY from_user_id
ORDER BY count(*) DESC
LIMIT 1;

/* Задача №2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет. */

-- Вложенные запросы
SELECT count(*) -- Количество лайков
FROM likes
WHERE media_id IN ( -- Все медиа записи таких пользователей
	SELECT id 
	FROM media 
	WHERE user_id IN ( -- Все пользователи младше 10 лет
		SELECT 
			user_id -- , birthday
		FROM profiles AS p
		WHERE  YEAR(CURDATE()) - YEAR(birthday) < 10
	)
);

-- Объединением таблиц
SELECT count(*) -- Количество лайков
FROM likes l
JOIN media m ON l.media_id = m.id
JOIN profiles p ON p.user_id = m.user_id
WHERE  YEAR(CURDATE()) - YEAR(birthday) < 10;

/* Задача №3. Определить кто больше поставил лайков (всего) - мужчины или женщины? */
SELECT 
	gender,
	count(*)
FROM (
	SELECT 
		user_id AS USER,
		(
			SELECT gender 
			FROM vk.profiles
			WHERE user_id = user
		) AS gender
	FROM likes
) AS dummy
GROUP BY gender;