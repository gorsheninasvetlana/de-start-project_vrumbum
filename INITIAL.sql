CREATE SCHEMA IF NOT EXISTS raw_data;
create table if not exists raw_data.sales(
id integer,
auto text,
gasoline_consumption text,
price numeric(9,2),
date date,
person_name text,
phone text,
discount integer,
brand_origin text);

/copy raw_data.sales from '/Users/cars.csv' with csv header null 'null'
