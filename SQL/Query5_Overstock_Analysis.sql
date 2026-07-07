-- Query 5: Overstock Analysis
-- Identifies products where current stock significantly exceeds the reorder level,
-- highlighting capital tied up in excess inventory and warehouse space inefficiency.
-- WHERE clause filters to overstocked products only

select
	Product_Name
	,Supplier_Name
	,Stock_Quantity
	,Reorder_Level
	,Stock_Quantity - Reorder_Level as 'Stock_Difference'
from InventoryData
where Stock_Quantity > Reorder_Level
	and Catagory is not null
order by Stock_Difference desc

-- FINDINGS: 524 of 990 products (52.9%) are overstocked, indicating poor reorder
-- level calibration across the catalogue. Top overstocked products have reorder
-- levels as low as 1-10 while carrying 90-100 units -- near-zero reorder triggers
-- allow stock to accumulate indefinitely. Combined with Query 2 (critical shortfalls),
-- the business faces a split inventory problem: simultaneous overstock and stockout
-- across different product lines. Duplicate product names reflect legitimate
-- multi-supplier sourcing strategy, not data quality issues.

