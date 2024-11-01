/*добавьте сюда запрос для решения задания 6*/
SELECT 
    COUNT(*) AS persons_from_usa_count          -- Подсчитываем количество пользователей
FROM 
    car_shop.customer                            -- Таблица с пользователями
WHERE 
    phone LIKE '+1%'                             -- Условие для номеров, начинающихся с +1
;
