-- Заполнение таблицы country
INSERT INTO car_shop.country (country_name)
SELECT DISTINCT brand_origin
FROM raw_data.sales
WHERE brand_origin IS NOT NULL;

-- Заполнение таблицы brand
INSERT INTO car_shop.brand (brand_name, country_id)
SELECT DISTINCT
    split_part(auto, ' ', 1) AS brand_name,
    country.country_id
FROM raw_data.sales s
JOIN car_shop.country country ON s.brand_origin = country.country_name;

-- Заполнение таблицы color
INSERT INTO car_shop.color (color_name)
SELECT DISTINCT
    TRIM(BOTH ' ' FROM split_part(auto, ',', 2)) AS color_name
FROM raw_data.sales;

-- Заполнение таблицы model
INSERT INTO car_shop.model (model_name, brand_id)
SELECT DISTINCT
    split_part(auto, ' ', 2) AS model_name,
    brand.brand_id
FROM raw_data.sales s
JOIN car_shop.brand brand ON split_part(s.auto, ' ', 1) = brand.brand_name;

-- Заполнение таблицы customer
INSERT INTO car_shop.customer (person_name, phone)
SELECT DISTINCT person_name, phone
FROM raw_data.sales;

-- Заполнение таблицы sale
INSERT INTO car_shop.sale (date, price, discount, model_id, color_id, customer_id)
SELECT 
    date::DATE, 
    price, 
    discount,
    model.model_id,
    color.color_id,
    customer.customer_id
FROM raw_data.sales s
JOIN car_shop.model model ON split_part(s.auto, ' ', 2) = model.model_name
JOIN car_shop.color color ON TRIM(BOTH ' ' FROM split_part(s.auto, ',', 2)) = color.color_name
JOIN car_shop.customer customer ON s.person_name = customer.person_name AND s.phone = customer.phone;
