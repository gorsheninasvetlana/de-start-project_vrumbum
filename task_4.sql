/*добавьте сюда запрос для решения задания 4*/
SELECT 
    c.person_name AS person,                                         -- Имя пользователя
    STRING_AGG(b.brand_name || ' ' || m.model_name, ', ') AS cars    -- Список машин, купленных пользователем, через запятую
FROM 
    car_shop.sale s
JOIN 
    car_shop.customer c ON s.customer_id = c.customer_id             -- Присоединяем таблицу customer для получения имени пользователя
JOIN 
    car_shop.model m ON s.model_id = m.model_id                      -- Присоединяем таблицу моделей
JOIN 
    car_shop.brand b ON m.brand_id = b.brand_id                      -- Присоединяем таблицу брендов
GROUP BY 
    c.person_name                                                    -- Группируем по имени пользователя
ORDER BY 
    c.person_name ASC;                                               -- Сортировка по имени пользователя
