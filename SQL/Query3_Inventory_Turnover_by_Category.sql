-- Query 3: Inventory Turnover Rate by Category
-- Calculates average inventory turnover rate per category to identify
-- fast vs slow moving stock. High turnover = healthy demand, low turnover
-- = deadstock or overstocking risk.

select
	Catagory
	,count(*) as 'Total_Products'
	,cast(avg(Inventory_Turnover_Rate) as decimal(5,2)) as 'AVG_Turnover_Rate'
	,cast(max(Inventory_Turnover_Rate) as decimal(5,2)) as 'MAX_Turnover_Rate'
	,cast(min(Inventory_Turnover_Rate) as decimal(5,2)) as 'MIN_Turnover_Rate'
from InventoryData
where Catagory is not null
group by Catagory
order by AVG_Turnover_Rate desc

-- FINDINGS: Seafood leads turnover at 53.73 avg despite being a smaller category.
-- Dairy's high turnover (53.43) combined with high backorder rates from Query 1
-- confirms strong demand is outpacing supply. Oils & Fats is the slowest mover
-- at 45.22 -- potential deadstock risk. Turnover Rate appears to be an indexed
-- score (1-100) rather than a traditional ratio. MAX/MIN included to show score range.