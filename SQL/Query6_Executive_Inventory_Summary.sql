-- Query 6: Executive Inventory Summary
-- Single-row executive snapshot using scalar subqueries.
-- CTEs cannot be nested inside scalar subqueries in T-SQL -- TOP 1 with ORDER BY used instead.

select
    (select count(*) from InventoryData) AS 'Total_Products'

    ,(select cast(count(*) * 100.0 / 
        (select count(*) from InventoryData) as decimal(5,2))
     from InventoryData
     where Status = 'Backordered') as '%_Backordered'

    ,(select top 1 Catagory
     from InventoryData
     group by Catagory
     order by avg(Inventory_Turnover_Rate) desc) as 'Highest_Turnover_Category'

    ,(select top 1 Supplier_Name
     from InventoryData
     group by Supplier_Name
     order by avg(Stock_Quantity) desc, sum(Sales_Volume) asc) as 'Worst_Stock_Coverage_Supplier'

     -- FINDINGS: 990 total products with 32.83% backordered -- nearly 1 in 3 products
-- unavailable at any given time, representing a critical supply chain risk.
-- Seafood is the highest turnover category (confirmed by Query 3).
-- Fivespan is the worst stock coverage supplier -- high average stock holdings
-- relative to sales volume suggest poor inventory deployment or weak demand.
-- All six queries consistently point to the same conclusion: the business has
-- a systemic inventory management problem spanning overstock, understock,
-- and supplier performance simultaneously.