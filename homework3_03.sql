-- Задание 1
-- 1 Создайте таблицу city с колонками city_id и city_name.
CREATE TABLE city (
	city_id BIGSERIAL NOT NULL PRIMARY KEY,
	city_name VARCHAR(20) NOT NULL
);

-- 2 Добавьте в таблицу employee колонку city_id.
-- 3 Назначьте эту колонку внешним ключом. Свяжите таблицу employee с таблицей city.
ALTER TABLE employee 
ADD COLUMN city_id INT NOT NULL DEFAULT 1 
CONSTRAINT city_id REFERENCES city(city_id);

-- 4 Заполните таблицу city и назначьте работникам соответствующие города.
INSERT INTO city (city_name) VALUES ('не указан');
INSERT INTO city (city_name) VALUES ('Москва');
INSERT INTO city (city_name) VALUES ('Зеленоград');
INSERT INTO city (city_name) VALUES ('Солнечногорск');
INSERT INTO city (city_name) VALUES ('Клин');
INSERT INTO city (city_name) VALUES ('Тверь');
INSERT INTO city (city_name) VALUES ('Санкт-Петербург');

UPDATE employee SET city_id = 2 WHERE id = 1 OR id = 4;
UPDATE employee SET city_id = 3 WHERE id = 5 OR id = 6;

-- Задание 2
-- Создайте ряд запросов к созданной таблице.
-- 1 Получите имена и фамилии сотрудников, а также города, в которых они проживают.
SELECT first_name, last_name, city_name FROM employee
INNER JOIN city ON employee.city_id = city.city_id;

-- 2 Получите города, а также имена и фамилии сотрудников, которые в них проживают. 
-- Если в городе никто из сотрудников не живет, то вместо имени должен стоять null.
SELECT city_name, first_name, last_name FROM employee
RIGHT JOIN city on employee.city_id = city.city_id;

-- 3 Получите имена всех сотрудников и названия всех городов. 
-- Если в городе не живет никто из сотрудников, то вместо имени должен стоять null. 

SELECT first_name, city_name FROM employee
FULL JOIN city ON city.city_id = employee.city_id;

-- Аналогично, если города для какого-то из сотрудников нет в списке, должен быть получен null.

-- По идее null в данном случае можно было бы получить, если бы ссылок не было? 
-- Здесь ссылки сделаны через поля city_id.
-- При заполнении employee.city_id не даст выбрать несуществующий город, а удалить уже существующий, если на него сотрудник ссылается, тоже не даст.

-- 4 Получите таблицу, в которой каждому имени должен соответствовать каждый город.
SELECT first_name, city_name FROM employee
CROSS JOIN city;

-- 5 Получите имена городов, в которых никто не живет.
SELECT city_name FROM city
LEFT JOIN employee ON city.city_id=employee.city_id
WHERE employee.first_name IS NULL;