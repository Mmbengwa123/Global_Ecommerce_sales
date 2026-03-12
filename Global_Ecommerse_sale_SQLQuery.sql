SELECT TOP (1000) [Order_ID]
      ,[Country]
      ,[Category]
      ,[Unit_Price]
      ,[Quantity]
      ,[Order_Date]
      ,[Total_Amount]
  FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]

  SELECT * FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales];

--  Section 1: Customer Behavior & Segmentation

-- Country-Level Insights
--1.Which country generates the highest average order value?

SELECT Country,
       AVG(CAST(Total_Amount AS DECIMAL(18,2))) AS AvgOrderValue
FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]
WHERE TRY_CAST(Total_Amount AS DECIMAL(18,2)) IS NOT NULL
GROUP BY Country
ORDER BY AvgOrderValue DESC;

--2. Price Variance per Country 
SELECT Country,
       VAR(TRY_CAST(Unit_Price AS DECIMAL(18,2))) AS PriceVariance
FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]
WHERE TRY_CAST(Unit_Price AS DECIMAL(18,2)) IS NOT NULL
GROUP BY Country
ORDER BY PriceVariance DESC;

--3. Bulk Purchases by Country

SELECT Country,
       AVG(TRY_CAST(Quantity AS INT)) AS AvgQuantityPerOrder
FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]
WHERE TRY_CAST(Quantity AS INT) IS NOT NULL
GROUP BY Country
ORDER BY AvgQuantityPerOrder DESC; 

--Section 2: Operational Efficiency & Anomalies

--4. Negative or Zero Unit Prices

SELECT *
FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]
WHERE TRY_CAST(Unit_Price AS DECIMAL(18,2)) <= 0;

--5. Price Spread per Category

SELECT Category,
       MIN(TRY_CAST(Unit_Price AS DECIMAL(18,2))) AS MinPrice,
       MAX(TRY_CAST(Unit_Price AS DECIMAL(18,2))) AS MaxPrice,
       (MAX(TRY_CAST(Unit_Price AS DECIMAL(18,2))) - MIN(TRY_CAST(Unit_Price AS DECIMAL(18,2)))) AS PriceSpread
FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]
WHERE TRY_CAST(Unit_Price AS DECIMAL(18,2)) IS NOT NULL
GROUP BY Category
ORDER BY PriceSpread DESC;

--6. Bulk Purchases vs. Unit Price

SELECT TRY_CAST(Quantity AS INT) AS Quantity,
       AVG(TRY_CAST(Unit_Price AS DECIMAL(18,2))) AS AvgPrice
FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]
WHERE TRY_CAST(Quantity AS INT) IS NOT NULL
GROUP BY TRY_CAST(Quantity AS INT)
ORDER BY Quantity DESC;

--7. Return Rate per Category

SELECT Category,
       SUM(CASE WHEN TRY_CAST(Quantity AS INT) < 0 THEN 1 ELSE 0 END) AS ReturnCount,
       COUNT(*) AS TotalOrders,
       (SUM(CASE WHEN TRY_CAST(Quantity AS INT) < 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*)) AS ReturnRate
FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]
GROUP BY Category
ORDER BY ReturnRate DESC;

--8. Return Rate per Country

SELECT Country,
       SUM(CASE WHEN TRY_CAST(Quantity AS INT) < 0 THEN 1 ELSE 0 END) AS ReturnCount,
       COUNT(*) AS TotalOrders,
       (SUM(CASE WHEN TRY_CAST(Quantity AS INT) < 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*)) AS ReturnRate
FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]
GROUP BY Country
ORDER BY ReturnRate DESC;

--9. Returns by Month

SELECT MONTH(Order_Date) AS Month,
       SUM(CASE WHEN TRY_CAST(Quantity AS INT) < 0 THEN 1 ELSE 0 END) AS ReturnCount
FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]
GROUP BY MONTH(Order_Date)
ORDER BY ReturnCount DESC;

--Section 3: Strategic Insights & Trends
--10. Monthly Revenue

SELECT MONTH(Order_Date) AS Month,
       SUM(TRY_CAST(Total_Amount AS DECIMAL(18,2))) AS MonthlyRevenue
FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]
WHERE TRY_CAST(Total_Amount AS DECIMAL(18,2)) IS NOT NULL
GROUP BY MONTH(Order_Date)
ORDER BY MonthlyRevenue DESC;


--11. Category Revenue by Month
SELECT Category,
       MONTH(Order_Date) AS Month,
       SUM(TRY_CAST(Total_Amount AS DECIMAL(18,2))) AS Revenue
FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]
WHERE TRY_CAST(Total_Amount AS DECIMAL(18,2)) IS NOT NULL
GROUP BY Category, MONTH(Order_Date)
ORDER BY Category, Revenue DESC;


--12. Revenue by Day of Week
SELECT DATENAME(WEEKDAY, Order_Date) AS DayOfWeek,
       SUM(TRY_CAST(Total_Amount AS DECIMAL(18,2))) AS Revenue
FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]
WHERE TRY_CAST(Total_Amount AS DECIMAL(18,2)) IS NOT NULL
GROUP BY DATENAME(WEEKDAY, Order_Date)
ORDER BY Revenue ASC;

--13. Revenue per Order by Category

SELECT Category,
       SUM(TRY_CAST(Total_Amount AS DECIMAL(18,2))) AS Revenue,
       COUNT(*) AS OrderCount,
       (SUM(TRY_CAST(Total_Amount AS DECIMAL(18,2))) * 1.0 / COUNT(*)) AS RevenuePerOrder
FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]
WHERE TRY_CAST(Total_Amount AS DECIMAL(18,2)) IS NOT NULL
GROUP BY Category
ORDER BY RevenuePerOrder DESC;


--14. High-Value Countries

SELECT Country,
       SUM(TRY_CAST(Total_Amount AS DECIMAL(18,2))) AS Revenue,
       COUNT(*) AS OrderCount,
       (SUM(TRY_CAST(Total_Amount AS DECIMAL(18,2))) * 1.0 / COUNT(*)) AS AvgRevenuePerOrder
FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]
WHERE TRY_CAST(Total_Amount AS DECIMAL(18,2)) IS NOT NULL
GROUP BY Country
ORDER BY AvgRevenuePerOrder DESC;

--15. Loss Leader Categories

SELECT Category,
       AVG(TRY_CAST(Unit_Price AS DECIMAL(18,2))) AS AvgPrice,
       SUM(TRY_CAST(Total_Amount AS DECIMAL(18,2))) AS TotalRevenue
FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]
WHERE TRY_CAST(Unit_Price AS DECIMAL(18,2)) IS NOT NULL
GROUP BY Category
ORDER BY AvgPrice ASC, TotalRevenue DESC;

--Table results Visualisation

SELECT 
    Country,
    Category,
    MONTH(Order_Date) AS OrderMonth,
    DATENAME(WEEKDAY, Order_Date) AS OrderDay,

    -- Revenue metrics
    SUM(TRY_CAST(Total_Amount AS DECIMAL(18,2))) AS TotalRevenue,
    AVG(TRY_CAST(Total_Amount AS DECIMAL(18,2))) AS AvgOrderValue,
    COUNT(*) AS OrderCount,

    -- Quantity metrics
    SUM(TRY_CAST(Quantity AS INT)) AS TotalQuantity,
    AVG(TRY_CAST(Quantity AS INT)) AS AvgQuantityPerOrder,

    -- Pricing metrics
    MIN(TRY_CAST(Unit_Price AS DECIMAL(18,2))) AS MinUnitPrice,
    MAX(TRY_CAST(Unit_Price AS DECIMAL(18,2))) AS MaxUnitPrice,
    AVG(TRY_CAST(Unit_Price AS DECIMAL(18,2))) AS AvgUnitPrice,

    -- Return metrics
    SUM(CASE WHEN TRY_CAST(Quantity AS INT) < 0 THEN 1 ELSE 0 END) AS ReturnCount,
    (SUM(CASE WHEN TRY_CAST(Quantity AS INT) < 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*)) AS ReturnRate

FROM [Global_ECommerse_Sales].[dbo].[global_ecommerce_sales]
WHERE TRY_CAST(Total_Amount AS DECIMAL(18,2)) IS NOT NULL
  AND TRY_CAST(Unit_Price AS DECIMAL(18,2)) IS NOT NULL
  AND TRY_CAST(Quantity AS INT) IS NOT NULL
GROUP BY Country, Category, MONTH(Order_Date), DATENAME(WEEKDAY, Order_Date)
ORDER BY TotalRevenue DESC;

--END--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------



















 




