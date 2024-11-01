/*добавьте сюда запрос для решения задания 2*/
SELECT 
    b.brand_name AS brand_name,               -- Название бренда
    EXTRACT(YEAR FROM s.date) AS year,        -- Год продажи
    ROUND(AVG(s.price * (1 - COALESCE(s.discount, 0) / 100.0)), 2) AS price_avg -- Средняя цена с учетом скидки, округленная до 2 знаков
FROM 
    car_shop.sale s
JOIN 
    car_shop.model m ON s.model_id = m.model_id  -- Присоединяем таблицу моделей
JOIN 
    car_shop.brand b ON m.brand_id = b.brand_id  -- Присоединяем таблицу брендов
GROUP BY 
    b.brand_name,                               -- Группируем по бренду
    EXTRACT(YEAR FROM s.date)                   -- и по году
ORDER BY 
    b.brand_name ASC,                           -- Сортировка по бренду
    year ASC;                                   -- и по году
