/*добавьте сюда запрос для решения задания 5*/
SELECT 
    COALESCE(ct.country_name, 'Unknown') AS brand_origin,               -- Страна бренда или 'Unknown', если страна не указана
    ROUND(MAX(s.price / (1 - COALESCE(s.discount, 0) / 100.0)), 2) AS price_max, -- Максимальная цена без учета скидки
    ROUND(MIN(s.price / (1 - COALESCE(s.discount, 0) / 100.0)), 2) AS price_min  -- Минимальная цена без учета скидки
FROM 
    car_shop.sale s
JOIN 
    car_shop.model m ON s.model_id = m.model_id                        -- Присоединяем таблицу моделей
JOIN 
    car_shop.brand b ON m.brand_id = b.brand_id                        -- Присоединяем таблицу брендов
LEFT JOIN 
    car_shop.country ct ON b.country_id = ct.country_id                -- Присоединяем таблицу стран с учетом NULL
GROUP BY 
    COALESCE(ct.country_name, 'Unknown')                               -- Группируем по стране, заменяя NULL на 'Unknown'
ORDER BY 
    brand_origin ASC;                                                  -- Сортировка по стране
