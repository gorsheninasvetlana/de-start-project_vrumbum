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
LEFT JOIN car_shop.country country ON s.brand_origin = country.country_name;

-- Заполнение таблицы color
INSERT INTO car_shop.color (color_name)
SELECT DISTINCT
    TRIM(BOTH ' ' FROM split_part(auto, ',', 2)) AS color_name
FROM raw_data.sales;

-- Заполнение таблицы model
INSERT INTO car_shop.model (model_name, brand_id, gasoline_consumption)
SELECT DISTINCT
    SUBSTR(SPLIT_PART(auto, ',', 1),(STRPOS(SPLIT_PART(auto, ',', 1),' ')+1)) AS model_name,
    brand.brand_id,
    s.gasoline_consumption::NUMERIC(5,2)
FROM raw_data.sales s
JOIN car_shop.brand brand ON SPLIT_PART(s.auto, ' ', 1) = brand.brand_name;

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
    m.model_id,
    cl.color_id,
    cus.customer_id
FROM raw_data.sales s
JOIN car_shop.model m ON SUBSTR(SPLIT_PART(auto, ',', 1),(STRPOS(SPLIT_PART(auto, ',', 1),' ')+1)) = m.model_name
JOIN car_shop.color cl ON TRIM(BOTH ' ' FROM split_part(s.auto, ',', 2)) = cl.color_name
JOIN car_shop.customer cus ON s.person_name = cus.person_name AND s.phone = cus.phone;
