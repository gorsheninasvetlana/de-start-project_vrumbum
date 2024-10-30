/*добавьте сюда запрос для решения задания 1*/
SELECT 
    (COUNT(model_id) - COUNT(gasoline_consumption)) * 100.0 / COUNT(model_id) AS nulls_percentage_gasoline_consumption
FROM 
    car_shop.model;
