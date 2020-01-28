/* Задача: Написать скрипт, добавляющий в БД vk, которую создали на занятии, 3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей) */

/* Никогда ранее не заходил во вкладку Товары соц.сети Вконтакте, зашел, ужаснулся) решил описать примерную предполагаемую структуру */

DROP DATABASE IF EXISTS `vk`;
CREATE DATABASE `vk`;
USE `vk`;

DROP TABLE IF EXISTS `goods_categories`;
CREATE TABLE `goods_categories` (
	`category_id` SERIAL PRIMARY KEY, -- Уникальный ID категории
	`category_name` VARCHAR(255) UNIQUE, -- Название категории товаров
	`created_at` DATETIME DEFAULT NOW(), -- Дата создания
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Дата обновления
    
    INDEX category_name_idx(category_name) -- Задумался, но решил оставить индекс для нужд поиска по категориям, под вопросом решение
    
) COMMENT = 'Таблица категорий товаров';

DROP TABLE IF EXISTS `goods_description`;
CREATE TABLE `goods_description` (
	`goods_id` SERIAL PRIMARY KEY, -- Уникальный ID товара
	`goods_name` VARCHAR(255), -- Название товара
	`goods_photo` VARCHAR(255) DEFAULT NULL, -- Изображение товара
	`goods_description` TEXT, -- Описание товара
	`goods_price` DECIMAL(10,2), -- Стоимость товара
	`goods_category` BIGINT UNSIGNED NOT NULL, -- Категория товара
	`user_posted_id` BIGINT UNSIGNED NOT NULL, -- Пользователь предлагающий товар/услугу
	`created_at` DATETIME DEFAULT NOW(), -- Дата создания
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Дата обновления
    
    /* Индексацию решил провести по этим полям для ускорения вывода наиболее свежих товаров  */
    INDEX goods_category_idx(goods_category),
    INDEX goods_updated_at_idx(updated_at),
    
    FOREIGN KEY fk_goods_category(goods_category) REFERENCES goods_categories(category_id),
    FOREIGN KEY (user_posted_id) REFERENCES users(id)
    
    /* Так же хотел попробовать связь с таблицами `photos` и `photo_albums` на случай загрузки изображений товара в пользовательский фотоальбом,
     * но совсем туго пошло с возможными вариантами решения данной задачи, отбросил, непонимаю как сделать, задумался и о целесообразности))) */
    
) COMMENT = 'Таблица с описанием товара';

/* Возникла идея описать таблицу новостной ленты, вместе с ней затянуло в такие тополяяя))) так и не додумался, запутался окончательно от куда ноги растут, очень много связей
 * с разными таблицами будет на мой взгляд, решил пойти по более простому пути, сомнения только в том, решается ли это при помощи БД?, можно и программно реализовать,
 * без ответа */

DROP TABLE IF EXISTS `activity status`;
CREATE TABLE `activity status` (
	`active_user_id` SERIAL PRIMARY KEY NOT NULL,
	`activity status` ENUM('Online', 'Offline'),
	`created_at` DATETIME DEFAULT NOW(), -- Дата создания, для отслеживания времени последней активности
	/* Дата обновления, для смены статуса в режиме реального времени, например графического отображения внутри приложения */
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX active_user_id_idx(active_user_id),
    /* Предположительно должно ускорить графический отклик и отображение */
    INDEX updated_at_idx(updated_at),
    
    FOREIGN KEY fk_active_user_id(active_user_id) REFERENCES users(id)

) COMMENT = 'Статус активности пользователей';