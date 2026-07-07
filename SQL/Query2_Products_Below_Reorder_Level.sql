-- Query 2: Products Below Reorder Level
-- Identifies products where current stock has fallen below the reorder threshold,
-- ranked by the size of the shortfall to prioritise restocking urgency.

select
	row_number() over (order by Reorder_Level - Stock_Quantity desc) as 'Row_ID'
	,Product_Name
	,Supplier_Name
	,Catagory
	,Stock_Quantity
	,Reorder_Level
	,Reorder_Level - Stock_Quantity as 'Stock_Shortfall'
	,Reorder_Quantity
from InventoryData
where Stock_Quantity < Reorder_Level
	and Catagory is not null
order by Stock_Shortfall desc

-- FINDINGS: Heavy Cream is the most critical product with a shortfall of 85 units
-- (Stock: 14, Reorder Level: 99). Dairy and Fruits & Vegetables dominate the critical
-- shortfall list, consistent with Query 1 findings. Large reorder quantities across
-- top products suggest high-volume, fast-moving lines are most at risk.
-- Simplified approach used -- WHERE clause replaces CASE WHEN for cleaner filtering.
