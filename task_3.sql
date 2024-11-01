/*добавьте сюда запрос для решения задания 3*/
SELECT 
    EXTRACT(MONTH FROM s.date) AS month,                -- Извлекаем месяц из даты
    EXTRACT(YEAR FROM s.date) AS year,                  -- Извлекаем год из даты
    ROUND(AVG(s.price * (1 - COALESCE(s.discount, 0) / 100.0)), 2) AS price_avg -- Средняя цена с учетом скидки
FROM 
    car_shop.sale s
WHERE 
    EXTRACT(YEAR FROM s.date) = 2022                    -- Фильтр для выборки только 2022 года
GROUP BY 
    EXTRACT(YEAR FROM s.date),                          -- Группировка по году
    EXTRACT(MONTH FROM s.date)                          -- Группировка по месяцу
ORDER BY 
    month ASC;                                          -- Сортировка по месяцу
