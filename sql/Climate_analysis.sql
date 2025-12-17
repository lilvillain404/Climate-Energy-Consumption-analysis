select
    count(*)-count(date) as nulls_in_column1,
	count(*)-count(country) as nulls_in_column2,
	count(*)-count(avg_temperature) as nulls_in_column3,
	count(*)-count(humidity) as nulls_in_column4,
	count(*)-count(co2_emissions) as nulls_in_column5,
	count(*)-count(energy_consumption) as nulls_in_column6,
	count(*)-count(renewable_energy) as nulls_in_column7,
	count(*)-count(urbanization_rate) as nulls_in_column8,
	count(*)-count(index_value) as nulls_in_column9,
	count(*)-count(avg_energy_price) as nulls_in_column10
FROM climate_data; -- Проверка на нулевые значения

select count (*) as total_rows 
from climate_data; -- Проверка на количество строк

select country,count(*)
FROM climate_data
group by country; -- Кол-во стран и значений для них

select min(date), max(date)
from climate_data;  -- Находим период, для которого есть значения

select country,
    count(*) as measurements,
    round(avg(avg_temperature),2) as avg_temp,
	round(avg(humidity),2) as avg_himidity,
    round(avg(co2_emissions),2) as avg_co2,
	
	round(avg(energy_consumption),2) as avg_energy_cons,
	round(avg(renewable_energy),2) as avg_ren_energy,
    round(avg(avg_energy_price),2) as avg_price
from climate_data
group by country
order by avg_temp desc;  -- Получаем средние значения о погоде и энергии для каждой страны 

select
    extract(year from date) as year,
    round(avg(avg_temperature),1) as global_avg_temp,
    round(avg(co2_emissions),1) as global_avg_co2,
	round(avg(humidity),1) as global_avg_himidity,

	round(avg(energy_consumption),1) as global_avg_energy_cons,
	round(avg(renewable_energy),1) as global_avg_ren_energy,
    round(avg(avg_energy_price),1) as global_avg_price
from climate_data
group by year
order by year;  -- Анализируем тренды по годам

select 
    country,
    round(corr(avg_temperature, co2_emissions)::numeric,2) as temp_co2_corr, -- Насколько выбросы влияют на температуру
    round(corr(energy_consumption, co2_emissions)::numeric,2) as energy_co2_corr, -- Насколько потреблении энергии связано с выбросами
	round(corr(urbanization_rate, co2_emissions)::numeric,2) as urban_co2_corr, -- Насколько промышленность влияет на выбросы
	round(corr(renewable_energy, co2_emissions)::numeric,2) as renewable_co2_corr, -- Насколько использование возобновляемой энергии влияет на выбросы
	round(corr(renewable_energy, avg_energy_price)::numeric,2) as renewable_price_corr -- Насколько использование возобновляемой энергии влияет на цену
from climate_data
group by country;

select country, round(avg(co2_emissions),2) as avg_co2
from  climate_data
group by country
order by (avg_co2) desc
limit 5;  -- Страны с самыми высокими средними показателями выбросов

select  country, round(avg(urbanization_rate), 2) as avg_urban_rate
FROM climate_data
GROUP BY country
ORDER BY avg_urban_rate DESC
LIMIT 5; -- Страны с самыми высокими средними показателями уровня промышленности

select 
    extract(month from date) as month,
    round(avg(energy_consumption),1) as avg_consump,
    round(avg(avg_temperature),1) as avg_temp
from climate_data
where country = 'Germany'
group by month
order by month; -- Как сезоны года  влияют на потребление энергии на примере Германии

-- Пожалуй, этого хватит для первичного осмотра данных и общего понимания тенденций. Дальнейшая работа 
-- над данными будет производиться в Power BI.



