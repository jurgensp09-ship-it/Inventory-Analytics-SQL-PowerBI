--Query 1 — Stock Status Overview by Category
--The business question: Which product categories have the most backordered or discontinued products, 
--and how does stock status break down across the business?

select 
	Catagory
	,Status
	,count(product_name) as [Total Products]
	,cast(count(*) * 100.0 / sum(count(*)) over (partition by catagory) as decimal(5,2)) as [Status_Percentage]
from InventoryData
where Catagory is not null
group by Catagory, Status
order by Catagory, Status

-- FINDINGS: No category exceeds 42% active stock, indicating a company-wide inventory
-- availability problem. Dairy is most critical with 65 discontinued (36.11%) and 59
-- backordered products (32.78%). Bakery has the highest backorder rate at 39.19%.
-- Fruits & Vegetables carries the highest absolute volume of problem stock (223 products).
-- PARTITION BY enabled per-category percentage calculation without collapsing rows.

