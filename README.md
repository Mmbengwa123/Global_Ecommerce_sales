# Global_Ecommerce_sales
Analysing Global Ecommerce Sales

*Project Overview*
This project focuses on analyzing a Kaggle‑style global e‑commerce dataset containing the following fields:  
- Country 
- Category  
- Unit_Price  
- Quantity 
- Order_Date 
- Total_Amount 

The goal was to move beyond standard descriptive analytics (e.g., top products, total sales) and uncover --hidden inefficiencies, anomalies, and profitability drivers.I designed 15 analytical questions grouped into 5 themes, then consolidated them into a single SQL query for streamlined Power BI integration.

---
Data Challenges
During query execution, i encountered errors such as:  
- “Operand data type nvarchar is invalid for sum/avg operator” 

This revealed that numeric fields (`Unit_Price`, `Quantity`, `Total_Amount`) were stored as **nvarchar (text)**. To address this, I applied `TRY_CAST` to safely convert values into numeric types (`DECIMAL` or `INT`) while ignoring invalid entries. This ensured queries executed successfully without breaking on non‑numeric values.

---
Analytical Themes
I structured the analysis into three sections, each with targeted questions:

1. Customer & Market Behavior
   - Average order value per country  
   - Price variance across regions  
   - Bulk purchase trends  

2. Operational Efficiency & Anomalies
   - Negative or zero pricing detection  
   - Price spread within categories  
   - Return rates by country and category  

3. Strategic Insights & Trends
   - Monthly and weekly revenue patterns  
   - Category seasonality  
   - Loss leader identification (low price, high revenue)  
---
Consolidated SQL Query
To streamline Power BI analysis, i built one unified query that outputs a fact table with all relevant metrics:

- Revenue Metrics: Total revenue, average order value, order count  
- Quantity Metrics: Total items sold, average basket size  
- Pricing Metrics: Min, max, and average unit price  
- Return Metrics: Return count and return rate  
- Time Dimensions: Month and day of week for temporal analysis  

This consolidated table allows Power BI to generate dashboards without multiple SQL calls.

---
Power BI Integration
The consolidated dataset is designed for direct import into Power BI. Recommended visuals include:  
- Revenue Heatmap**: Country × Category  
- Seasonal Line Chart**: Monthly revenue trends  
- Return Rate Comparison**: Category and country breakdown  
- Basket Size Distribution**: Average quantity per order by region  
- Loss Leader Analysis**: Categories with low average price but high total revenue  
---
Business Impact
By addressing anomalies and focusing on overlooked metrics, this analysis provides:  
- Data Quality Assurance: Identifying invalid entries (negative prices, text in numeric fields).  
- Operational Insights: Highlighting inefficiencies in returns and bulk pricing.  
- Strategic Opportunities: Revealing high‑value markets and loss leader categories.  

-----------------------------------------------------------------------------------------------------------


