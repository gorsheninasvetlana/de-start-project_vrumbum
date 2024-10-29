-- Создаем схему raw_data
CREATE SCHEMA IF NOT EXISTS raw_data;

-- Создаем таблицу sales в схеме raw_data
CREATE TABLE IF NOT EXISTS raw_data.sales (
    id INTEGER,
    auto TEXT, 
    gasoline_consumption TEXT,
    price NUMERIC(9, 2),
    date DATE,
    person_name TEXT,
    phone TEXT,
    discount INTEGER,
    brand_origin TEXT
);
