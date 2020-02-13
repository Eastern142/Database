# Database
Homework for Database

## HW_1 (Webinar)

Напишите ответы на вопросы в комментарий при сдаче практического задания:

1. Какие у вас ожидания от курса? Есть ли конкретные вопросы по теме Базы данных?

2. В какой сфере работаете сейчас?

3. Если в IT, то какой у вас опыт (инструменты, технологии, языки программирования)?

Рекомендуемый способ организации данных в репозитории: создать отдельные папки по темам и помещать в них отдельные файлы для каждой задачи с правильным расширением.

Например: topic3/do_something.sql

## HW_2 (Video tutorial)

1. Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке.

2. Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.

3. Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.

4. (По желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.

## HW_3 (Webinar)

1. Написать скрипт, добавляющий в БД vk, которую создали на занятии, 3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей).

## HW_4 (Webinar)

1. Заполнить все таблицы БД vk данными (по 10-100 записей в каждой таблице).

2. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке.

3. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1).

4. Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней).

5. Написать название темы курсового проекта (в комментарии).

## HW_5 (Video tutorial)

#### Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”:

1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.
```
value         value
0             1
2500          30
0       =>    500
30            2500
500           0
1             0
```
4. (По желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august').

5. (По желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

#### Практическое задание по теме “Агрегация данных”:

1. Подсчитайте средний возраст пользователей в таблице users.

2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

3. (По желанию) Подсчитайте произведение чисел в столбце таблицы.
```
value
1
2
3   =>   120
4
5
```

## HW_6 (Webinar)

1. Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.

3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

## HW_7 (Video tutorial)
```
flights                cities
id  from      to       label      name
1   moscow    omsk     moscow     Москва
2   novgorod  kazan    irkutsk    Иркутск
3   irkutsk   moscow   novgorod   Новгород
4   omsk      irkutsk  kazan      Казань
5   moscow    kazan    omsk       Омск
```
1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет-магазине.

2. Выведите список товаров products и разделов catalogs, который соответствует товару.

3. (По желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
