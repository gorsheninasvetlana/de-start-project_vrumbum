-- Создаем схему car_shop
CREATE SCHEMA IF NOT EXISTS car_shop;

-- Таблица стран
CREATE TABLE car_shop.country (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(50) UNIQUE /* VARCHAR(50) — название страны может содержать как буквы, так и символы, например, пробелы, поэтому используем VARCHAR. 50 символов достаточно для любых названий стран */
);

-- Таблица брендов
CREATE TABLE car_shop.brand (
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(50) UNIQUE /* VARCHAR(50) — название бренда может содержать только буквы (например, "BMW", "Toyota"), поэтому выбран тип данных VARCHAR. Ограничение длины до 50 символов. */,
    country_id INT REFERENCES car_shop.country(country_id) /* INT — используется для хранения внешнего ключа, который ссылается на таблицу country */
);

-- Таблица цветов
CREATE TABLE car_shop.color (
    color_id SERIAL PRIMARY KEY,
    color_name VARCHAR(50) UNIQUE /* VARCHAR(50) — название цвета автомобиля может включать буквы, цифры или даже специальные символы (например, пробелы или дефисы), поэтому VARCHAR. Ограничение 50 символов достаточно для хранения любых цветов */
);

-- Таблица моделей автомобилей
CREATE TABLE car_shop.model (
    model_id SERIAL PRIMARY KEY,
    model_name VARCHAR(100) UNIQUE /* VARCHAR(100) — название модели может включать буквы, цифры и символы, например, "X5" или "Model S". Ограничение 100 символов для учёта длинных названий моделей */,
    brand_id INT REFERENCES car_shop.brand(brand_id) /* INT — используется для хранения внешнего ключа, который ссылается на таблицу brand */
);

-- Таблица покупателей
CREATE TABLE car_shop.customer (
    customer_id SERIAL PRIMARY KEY,
    person_name VARCHAR(100) /* VARCHAR(100) — используется для хранения имени покупателя, которое может включать буквы, пробелы и символы, например, апострофы. Ограничение 100 символов для обеспечения гибкости */,
    phone VARCHAR(20) UNIQUE /* VARCHAR(20) — используется для хранения телефонного номера, который может содержать цифры, плюс, дефисы и другие символы. Ограничение 20 символов достаточно для всех международных форматов */
);

-- Таблица продаж
CREATE TABLE car_shop.sale (
    sale_id SERIAL PRIMARY KEY,
    date DATE /* DATE — используется для хранения даты продажи. Тип данных DATE идеально подходит для хранения дат без времени */,
    price NUMERIC(9, 2) /* NUMERIC(9, 2) — цена может содержать только сотые и не может быть больше девятизначной суммы (включая две дробные цифры). Используем NUMERIC для точных расчетов с дробными числами */,
    discount INT /* INT — используется для хранения целочисленного значения скидки, например, в процентах */,
    model_id INT REFERENCES car_shop.model(model_id) /* INT — внешний ключ, ссылающийся на таблицу model */,
    color_id INT REFERENCES car_shop.color(color_id) /* INT — внешний ключ, ссылающийся на таблицу color */,
    customer_id INT REFERENCES car_shop.customer(customer_id) /* INT — внешний ключ, ссылающийся на таблицу customer */
);
