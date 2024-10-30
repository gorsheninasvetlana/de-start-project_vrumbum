-- Создаем схему car_shop
CREATE SCHEMA IF NOT EXISTS car_shop;

-- Таблица стран
CREATE TABLE car_shop.country (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(50) UNIQUE NOT NULL /* VARCHAR(50) — название страны, должно быть уникальным и обязательным для заполнения */
);

-- Таблица брендов
CREATE TABLE car_shop.brand (
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(50) UNIQUE NOT NULL, /* VARCHAR(50) — название бренда должно быть уникальным и обязательным для заполнения */
    country_id INT, /* INT — внешний ключ на таблицу country, обязательное поле, нет ограничения на обязательность заполнения */
    CONSTRAINT fk_country FOREIGN KEY (country_id) REFERENCES car_shop.country(country_id) /* Ограничение целостности, обеспечивающее связь с таблицей country */
);

-- Таблица цветов
CREATE TABLE car_shop.color (
    color_id SERIAL PRIMARY KEY,
    color_name VARCHAR(50) UNIQUE NOT NULL /* VARCHAR(50) — название цвета, должно быть уникальным и обязательным для заполнения */
);

-- Таблица моделей автомобилей
CREATE TABLE car_shop.model (
    model_id SERIAL PRIMARY KEY,
    model_name VARCHAR(100) UNIQUE NOT NULL, /* VARCHAR(100) — название модели должно быть уникальным и обязательным для заполнения */
    gasoline_consumption NUMERIC(5, 2), /* NUMERIC(5, 2) — числовой тип с двумя знаками после запятой, позволяет хранить значения до 999.99, может быть NULL */
    brand_id INT NOT NULL, /* INT — внешний ключ на таблицу brand, обязательное поле */
    CONSTRAINT fk_brand FOREIGN KEY (brand_id) REFERENCES car_shop.brand(brand_id) /* Ограничение целостности, обеспечивающее связь с таблицей brand */
);

-- Таблица покупателей
CREATE TABLE car_shop.customer (
    customer_id SERIAL PRIMARY KEY,
    person_name VARCHAR(100) NOT NULL, /* VARCHAR(100) — имя покупателя должно быть обязательным для заполнения */
    phone VARCHAR(30) UNIQUE NOT NULL /* VARCHAR(30) — телефон покупателя, должен быть уникальным и обязательным для заполнения */
);

-- Таблица продаж
CREATE TABLE car_shop.sale (
    sale_id SERIAL PRIMARY KEY,
    date DATE NOT NULL, /* DATE — дата продажи, обязательное поле */
    price NUMERIC(9, 2) NOT NULL, /* NUMERIC(9, 2) — цена продажи, обязательное поле */
    discount INT DEFAULT 0, /* INT — скидка, по умолчанию 0 (если не указана) */
    model_id INT NOT NULL, /* INT — внешний ключ на таблицу model, обязательное поле */
    color_id INT NOT NULL, /* INT — внешний ключ на таблицу color, обязательное поле */
    customer_id INT NOT NULL, /* INT — внешний ключ на таблицу customer, обязательное поле */
    CONSTRAINT fk_model FOREIGN KEY (model_id) REFERENCES car_shop.model(model_id), /* Ограничение целостности, обеспечивающее связь с таблицей model */
    CONSTRAINT fk_color FOREIGN KEY (color_id) REFERENCES car_shop.color(color_id), /* Ограничение целостности, обеспечивающее связь с таблицей color */
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES car_shop.customer(customer_id) /* Ограничение целостности, обеспечивающее связь с таблицей customer */
);
