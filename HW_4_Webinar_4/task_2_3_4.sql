USE vk;

/* Задача №1. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке */

SELECT DISTINCT firstname FROM users;

/* Еще варианты
SELECT DISTINCT firstname FROM users ORDER BY firstname;

SELECT firstname FROM users GROUP BY firstname ORDER BY firstname;
*/

/* Задача №2. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false).
   Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1). */

ALTER TABLE profiles
-- DROP COLUMN is_active;
ADD is_active BOOl DEFAULT true;

UPDATE profiles
SET
	is_active = false
WHERE (YEAR(CURRENT_DATE) - YEAR(birthday)) < 18;

SELECT birthday FROM profiles
WHERE (YEAR(CURRENT_DATE) - YEAR(birthday)) < 18;

/* Еще варианты
ALTER TABLE profiles
-- DROP COLUMN is_active;
ADD COLUMN is_active BIT DEFAULT 1;

UPDATE profiles
SET
	is_active = 0
WHERE (birthday + INTERVAL 18 YEAR) > NOW();

SELECT * FROM profiles
WHERE is_active = 0
ORDER BY birthday;
*/

/* Задача №3. Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней) */

INSERT INTO `messages` VALUES ('1','1','1','Expedita consequatur et in sit est. Distinctio quibusdam voluptatem qui porro. Dolore aperiam molestias ut corrupti corrupti sint aut. Et voluptates quam dicta dolor aut natus et.','2000-03-16 18:04:11'),
('2','2','2','Et vero nisi architecto asperiores hic voluptate. Enim perspiciatis vero officiis sequi quidem eius. Numquam aliquam sunt molestiae dolor enim. Ipsam aliquam quis officia aut non ut est.','2012-02-20 20:33:06'),
('3','3','3','Nesciunt ipsa atque animi sed. Et aspernatur qui dolor itaque voluptatem. A eos aspernatur perspiciatis nemo earum sit.','1992-11-24 21:08:34'),
('4','4','4','Perspiciatis architecto neque expedita fugiat et et sunt minima. Voluptatem aliquid reprehenderit quis aut est.','2006-03-04 05:48:09'),
('5','5','5','Error quo praesentium eaque consequatur ut. Numquam praesentium quibusdam dolore vel eum nemo reiciendis. Iure ut ab alias voluptatem dolor consequatur porro qui. Commodi nobis nobis voluptates ea ipsa ut expedita.','2012-02-11 02:32:34'),
('6','6','6','Quia natus tenetur tempore ipsa. Alias rerum accusantium a odio optio incidunt. Rerum adipisci alias facere in repellat sit nihil. Ut et ipsum at ipsum nihil.','1980-02-02 04:50:13'),
('7','7','7','Adipisci ut sed ut qui dolor doloribus. Nemo impedit amet officia ut tempora laboriosam. Id corrupti cupiditate voluptatem aperiam accusantium. Ea in aut qui porro voluptatem.','2018-10-12 22:08:55'),
('8','8','8','Id eos corrupti cupiditate quia veritatis quae corrupti. Sint ea ducimus minima laborum sit aliquid ad. Consequatur rerum dolore dolores omnis eius quaerat. Quasi tempora vel laboriosam explicabo.','1971-02-07 18:49:15'),
('9','9','9','Iusto voluptas et voluptas. Quaerat nihil sit repellat vel nihil. Ea sit aut nulla.','1974-03-16 03:28:43'),
('10','10','10','Distinctio fugit debitis et corrupti est soluta. Non sequi ratione consequuntur qui. Voluptatum veniam aspernatur expedita nihil accusamus suscipit nemo. Aut fugiat animi eveniet voluptatibus odio quaerat. Cupiditate nostrum tenetur est est eum autem quae.','1989-07-20 19:01:51'),
('11','1','1','Vel assumenda dolores rerum consectetur repellat nisi. Repellat maiores eaque recusandae quisquam reprehenderit amet ut atque. Eum ipsam pariatur nihil qui nobis distinctio quo.','2013-08-30 12:16:14'),
('12','2','2','Quasi quo et sed et omnis repellat. Aperiam molestiae vel perferendis odio. Voluptate expedita itaque consequuntur porro. Repellat dolore eos recusandae omnis. Aperiam nesciunt eligendi ut ut.','2002-08-03 08:55:57'),
('13','3','3','Qui officiis asperiores sed. Dolor neque sint eveniet optio. Dolorem aut in quia sed quia tempora. Et dolor ullam debitis eligendi aut.','2002-01-09 19:12:24'),
('14','4','4','Porro asperiores quia ratione dicta. Delectus quam ea similique debitis repellat. Autem ut assumenda natus minus magni non. Sit et ut qui qui ut nihil doloremque.','1999-10-10 08:47:15'),
('15','5','5','Ut voluptas officiis in labore nesciunt magni dicta. Et tenetur autem sequi eaque nam consequatur.','1985-08-31 13:59:03'),
('16','6','6','Aspernatur corporis cumque reiciendis. Expedita voluptas omnis voluptatem dicta. Quidem qui ut dolores atque accusamus sit doloribus. Quo et accusamus fuga cum fuga et cupiditate qui.','1982-06-24 12:16:22'),
('17','7','7','Doloribus nobis eius dolorem commodi est. Rerum voluptatem dolor possimus quos culpa. Veniam id quo sequi. Odio qui ut placeat minima facilis vel.','2010-05-31 18:29:18'),
('18','8','8','Nihil deleniti vitae quibusdam aut tempora. Et provident aliquid non occaecati error dolores omnis. Quia ea repellendus reiciendis et et. Temporibus at esse totam totam pariatur error.','1999-05-15 11:34:54'),
('19','9','9','Odio reprehenderit maiores omnis aut odio sit est qui. Aut quo autem sed sequi ut. Sunt placeat sapiente facere nam aliquid qui porro animi.','1977-06-01 04:17:53'),
('20','10','10','Reprehenderit ea alias quos. Nostrum error expedita vero atque.','1978-03-13 16:13:57'),
('21','1','1','Voluptatem rerum in quos sit soluta reiciendis. Totam praesentium praesentium tempore et. Fugit doloremque animi officia et sapiente. Quia labore debitis porro dolore iste praesentium eveniet.','1994-07-30 19:39:30'),
('22','2','2','Officiis aut sit aperiam fugit. Quo accusamus soluta in temporibus sint. Inventore molestias illum quo dolore aliquam quasi soluta dicta. Rem consequuntur amet numquam omnis sed rem.','1971-03-06 13:20:47'),
('23','3','3','Qui ut cupiditate soluta facere assumenda est tempore. Sequi sunt voluptas et. Illo alias provident sit illum aut quibusdam. Quis eaque repellat facere ipsum ut. Nulla aliquid sint cumque quas qui.','2012-08-24 08:11:59'),
('24','4','4','Distinctio atque nihil doloremque vel. Eos dolorem et molestias voluptatum veritatis voluptatem enim. Velit voluptates voluptate ducimus velit aut dolorum labore voluptatibus. Accusamus natus sapiente eveniet eos accusantium.','1972-03-21 22:57:58'),
('25','5','5','Voluptas et qui suscipit architecto veritatis aspernatur. Ea explicabo magnam similique saepe nihil. Tempore ut omnis nesciunt et quisquam est.','2017-11-18 15:16:37'),
('26','6','6','Sed facilis repudiandae occaecati in possimus. Ea temporibus a quia nisi nisi corrupti. Quia aut perspiciatis nemo.','1988-01-13 11:38:20'),
('27','7','7','Vero quia est nihil nobis exercitationem sunt. Ex sit iusto temporibus cumque temporibus. Dolor iusto deleniti id facere excepturi aliquid. Aliquid suscipit in voluptate quis cumque.','2001-07-19 16:23:56'),
('28','8','8','Quasi odit labore repellendus molestias. Consequuntur quam et et ut sit sed. Id aperiam laborum et veritatis officia qui accusamus.','1999-10-21 04:55:27'),
('29','9','9','Molestiae fuga omnis veniam aperiam ut. Qui molestiae quia architecto rerum. Quae a temporibus veniam est soluta voluptatem est.','2013-10-21 23:50:45'),
('30','10','10','Sint quasi eos velit commodi omnis. Consequatur molestiae voluptatem quis. Suscipit architecto sint ullam porro ipsam. Omnis et repudiandae dolor omnis commodi voluptatem laborum.','1979-04-13 16:22:49'),
('31','1','1','Hic officia ut aut a eligendi est occaecati. Aut velit eius dicta autem magni laboriosam. Et rerum et voluptates eos. Provident expedita ex deserunt quasi quis cupiditate.','1984-07-20 08:24:50'),
('32','2','2','Modi error fugiat autem voluptatum voluptas odio numquam. Distinctio non a libero. Accusamus et aspernatur consequuntur molestiae. Nostrum non illum et expedita ab enim est sed. Sequi doloremque consequuntur omnis eveniet ut accusantium.','2014-02-18 07:34:20'),
('33','3','3','Accusamus corrupti sed magni aut. Aut recusandae est assumenda voluptatem nisi magni soluta consequatur. Dolor tenetur ut quibusdam quis laborum sequi veniam.','1971-09-27 11:22:37'),
('34','4','4','Impedit optio officia amet magni provident architecto nobis totam. Ea recusandae placeat vero est fugiat. Cupiditate mollitia ducimus sed itaque vel.','1975-10-18 06:37:16'),
('35','5','5','Dolor quasi laboriosam aut est provident necessitatibus error. Et a aut aut est quas laborum veniam exercitationem. Asperiores quas ut eos dolore harum.','1998-12-28 02:19:33'),
('36','6','6','Et occaecati quibusdam illo et ex. Modi beatae et molestiae voluptate repudiandae voluptates.','2007-07-02 09:06:38'),
('37','7','7','Qui eum possimus ut sit. Eos quibusdam ducimus tempore quia aliquid soluta sapiente voluptatem. Quia recusandae voluptatibus iure rem et sunt vel. Et qui suscipit maxime velit optio.','2016-08-08 02:35:15'),
('38','8','8','Consequatur dolorum quia cumque omnis qui. Ea neque qui omnis optio. Ipsa et dolore amet quo. Voluptatem molestias nostrum ut inventore officiis delectus dicta nulla.','1994-12-03 19:30:05'),
('39','9','9','Debitis magnam molestiae nesciunt repellat. Doloremque rerum laborum omnis nihil totam dolor dolor. Sit optio magni vel facilis neque sit. Et et ullam et voluptatem minima cumque. Magnam tempora et dicta sed omnis alias excepturi.','1998-02-02 06:58:11'),
('40','10','10','Quo fugit qui culpa autem cumque. In voluptas voluptates quia dicta reiciendis ipsum commodi. Perferendis aut provident possimus distinctio. Cum et aut nemo ut. Similique consequatur ratione in dolor.','2001-04-16 17:30:47'),
('41','1','1','Dolor sunt sequi ratione praesentium. Vitae quia autem exercitationem. Commodi quaerat aut architecto impedit praesentium debitis inventore.','1985-05-29 20:02:51'),
('42','2','2','Adipisci non cumque velit explicabo. Quisquam enim laboriosam et et possimus et maxime. Et ratione et nemo nihil eos nulla fugit ratione.','1999-01-05 17:07:55'),
('43','3','3','Quam et aut deleniti id placeat quo. Cum asperiores possimus rerum aliquam qui alias repudiandae.','2003-10-28 00:34:29'),
('44','4','4','Accusantium expedita distinctio tempora deleniti expedita. Sunt sunt asperiores repudiandae qui nesciunt praesentium. Voluptatibus iure ipsam at rerum consequatur consequatur. Qui porro nam nostrum a.','1973-03-13 05:31:01'),
('45','5','5','Aliquid doloribus non tenetur eveniet. Aut rerum velit quia sit laborum. Rerum perferendis non qui et maxime consectetur.','1986-04-05 14:14:08'),
('46','6','6','Et maiores tempore error. Voluptatem ut eligendi voluptatum totam id. Quibusdam a ullam ullam natus odio.','1975-11-04 01:26:17'),
('47','7','7','Libero quia facere voluptate animi repellat. Itaque aut itaque tempora est molestiae ducimus. Aliquam quod quia ullam natus adipisci.','1992-02-06 22:46:13'),
('48','8','8','Id autem qui veniam rerum rerum ut. Est non aspernatur dolores enim et. Explicabo est quo maxime omnis autem. Odit rerum et excepturi modi. Earum excepturi dignissimos est fuga et accusantium.','1991-10-10 17:53:34'),
('49','9','9','Ut dolor qui officiis quaerat est sapiente. Et sequi excepturi consequatur ut veritatis adipisci maiores dolores. Optio ratione qui esse est est rem vitae. Dolor quam in nam enim dolorum et dolores rerum.','2019-07-04 17:17:18'),
('50','10','10','Reprehenderit aspernatur totam et inventore ut ut. Quidem aliquid autem fugiat dignissimos consequatur error. Non aut omnis reprehenderit aut magni.','2020-02-01 03:38:27');

SELECT * FROM messages;

DELETE FROM messages
WHERE created_at < CURRENT_TIMESTAMP();

/* Еще варианты
-- добавим флаг is_deleted 
ALTER TABLE messages 
ADD COLUMN is_deleted BIT DEFAULT 0;

-- Отметим пару сообщений неправильной датой
UPDATE messages
SET created_at = now() + INTERVAL 1 YEAR
LIMIT 2;

-- Отметим, как удаленные, сообщения "из будущего"
UPDATE messages
SET is_deleted = 1
WHERE created_at > NOW();


-- Физически удалим сообщения "из будущего"
-- DELETE FROM messages
-- WHERE created_at > NOW()

-- проверим
SELECT * FROM messages ORDER BY created_at DESC;
*/