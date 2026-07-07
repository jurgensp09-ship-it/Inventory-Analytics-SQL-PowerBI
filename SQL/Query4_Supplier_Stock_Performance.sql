-- Query 4: Supplier Stock Performance
-- Evaluates suppliers based on average stock levels maintained and total sales
-- volume generated. Identifies which suppliers keep shelves full vs which
-- are underperforming on stock availability.

select
	Supplier_Name
	,count(*) as 'Total_Products_Supplied'
	,avg(Stock_Quantity) as 'AVG Stock_Quantity'
	,sum(Sales_Volume) as 'Total_Sales_Volume'
	,cast(sum(Sales_Volume) * 1.0 / count(*) as decimal (10,2)) as 'Sales_per_Product'
from InventoryData
where Catagory is not null
group by Supplier_Name
order by Total_Sales_Volume desc

-- FINDINGS: Katz is the largest supplier (12 products, 800 total sales volume).
-- Browsetype is the most efficient supplier at 87.50 sales per product despite
-- only supplying 4 products. Twitterwire holds the highest avg stock (76) but
-- ranks 9th for sales volume -- overstocking risk. Quimm is the most concerning:
-- avg stock of 89 (near dataset high) but only 27 total sales -- significant
-- capital tied up in slow-moving inventory. Bottom 16 suppliers each supply
-- only 1 product, with Eamia and Muxo the weakest at 21 sales volume each.