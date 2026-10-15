# coffee-sale-analysiss-excel--sql
# End-to-End Coffee Sales Analytics: Dual Excel Dashboard & PostgreSQL Data Validation

[![Tools](https://img.shields.io/badge/Tools-Microsoft_Excel_%7C_PostgreSQL-blue?style=flat-square)](https://github.com)
[![Domain](https://img.shields.io/badge/Domain-Retail_%26_F%26B_Analytics-brown?style=flat-square)](https://github.com)
[![Dataset](https://img.shields.io/badge/Data_Size-14%2C117_Records-orange?style=flat-square)](https://www.kaggle.com)


## 1. Project Overview
This project delivers a comprehensive, end-to-end commercial analytics solution evaluating the performance of a multi-location coffee retail chain operating across three primary  store Locations: **Lower Manhattan, Hell's Kitchen, and Astoria.**

This project bridges the gap between front-end visual reporting and back-end database engineering. The project began by building an interactive executive dashboard in Microsoft Excel to visualize sales performance, operational shift concentrations, product volume vs. revenue divergences, and geographic purchasing behaviors across **14,116** raw transaction logs and **214,470** total units sold) from **January 1, 2023, to June 30, 2023.**

To achieve enterprise-level data validation, the entire analysis was then re-engineered in **PostgreSQL**. By translating visual pivot logic into structured database queries **(CTEs, aggregate functions, conditional grouping, and timestamp extractions)**, every key performance indicator (KPI), trend line, and ranking was cross-validated. This dual-tool approach guarantees 100% data reconciliation, proving that the numbers driving executive decisions are accurate, repeatable, and audit-ready.

## 2. Business Problem
The coffee chain runs three stores (Astoria, Hell’s Kitchen, Lower Manhattan) and needs a single, trusted view of sales performance for Jan–Jun 2023. Leadership wants to plan staffing, inventory, pricing, and promotions based on facts, not assumptions. Specifically, they need to:

- See the core KPIs at a glance: total revenue, total orders, total units, average unit price, and the top-earning product.
- Identify peak trading windows by time of day (morning/afternoon/night), day of week, and monthly trend to align rosters and stock levels.
- Separate “most ordered” products from “highest earning" products to guide menu placement, bundling, and pricing tests.
- Compare patterns by location so each store can run store-specific actions instead of one blanket strategy.
- Trust the numbers by reconciling the Excel dashboard with PostgreSQL outputs, ensuring every KPI matches the raw transaction table.

### 3. Dataset Description
The dataset was sourced from Kaggle and comprises raw POS (Point of Sale) transaction logs spanning a 6-month operational period (January 2023 – June 2023).

Dataset Metadata & Schema Summary
- Total Raw Records: 14,116 transaction records
- Total Units Sold: 214,470 units
- Timeframe: January 1, 2023 – June 30, 2023
- Geographic Scope: 3 Stores (Astoria, Hell's Kitchen, Lower Manhattan)

| Raw Field Name | Data Type | Description |
|---|---|---|
| transaction_id | Integer | Unique identifier for each customer transaction |
| transaction_date | Date / Text | Standard calendar date of sale (YYYY-MM-DD) |
| transaction_time | Time / Text | Exact timestamp of transaction (HH:MM:SS) |
| transaction_qty | Integer | Number of units purchased per line item |
| store_id | Integer | Unique store location identifier (1, 2, 3) |
| store_location | Text | Physical location name (Astoria, Hell's Kitchen, Lower Manhattan) |
| product_id | Integer | Unique inventory SKU identifier |
| unit_price | Decimal | Retail price per individual unit ($) |
| product_category | Text | High-level category (Coffee, Tea, Bakery, Drinking Chocolate, etc.) |
| product_type | Text | Specific sub-category (Barista Espresso, Brewed Chai Tea, Scone, etc.) |
| product_detail | Text | product description |

## 4. Business Questions
To understand the business performance and support better decision-making, this analysis focuses on answering the following business questions:

Executive KPIs
- What is the total gross revenue generated across all locations?
- What is the total order volume, total unit volume, and average unit price?
- What is the single highest-earning product across the entire chain?

Temporal & Operational Trends
- How is sales revenue distributed across operational shifts (Morning vs. Afternoon vs. Night)?
- Which day of the week generates peak revenue, and what is the dollar variance between the busiest and slowest days?
- What is the month-over-month sales growth trajectory across the 6-month period?

Others 
- Which top 5 product categories contribute the largest share to total sales?
- Which specific product types dominate transaction order volume (Top 10 Most Ordered)?
- Which specific product types dominate gross revenue generation (Top 10 Highest Earning)?
- Does a discrepancy exist between customer order frequency and total dollar return?

Geographic & Slicer Analysis
- How do sales KPIs, shift patterns, and product preferences shift when filtering specifically by Lower Manhattan, Hell's Kitchen, and Astoria?

## 5. Tools and Commands
Microsoft Excel:

Used for data inspection, preparation, feature engineering, and interactive dashboard development.

- Data Cleaning and Preparation: Inspected the raw dataset for missing values, duplicate transaction IDs, and inconsistencies in date and time fields.

- Feature Engineering: Created calculated columns to support time-based and multidimensional sales analysis.

- Dynamic Lookup Formulas: Used INDEX, MATCH, and MAX to build dynamic lookup functionality and display selected results using custom number and text formatting.

- Interactive Dashboard Development: Designed an interactive dashboard incorporating timeline slicers, visual hierarchy, custom colour branding, and shape-based containers to improve navigation and readability.

PostgreSQL 17:

Used for relational table creation, data ingestion, and analytical querying.

- Database Schema Design: Defined a relational table structure using CREATE TABLE, with appropriate data types and NUMERIC(10,2) precision for monetary values.

- Data Ingestion: Loaded CSV data into PostgreSQL using the COPY command.

- Analytical SQL: Used aggregate functions such as SUM(), AVG(), and COUNT(), alongside GROUP BY, ORDER BY, and LIMIT, to analyse sales performance across relevant dimensions.

Microsoft PowerPoint:
- Used to document the analytical process and communicate technical findings.

- Prepared a presentation documenting SQL query logic, screenshots of query outputs, visual evidence of the analysis, and interpretations of the results for stakeholder communication.

## 6. Data Cleaning and Preparation
Data preparation was performed in Microsoft Excel before the dataset was structured and loaded into PostgreSQL for analysis.

Step 1: Data Import and Structural Inspection

- The raw CSV file was imported into Microsoft Excel for initial inspection.

- The dataset was reviewed for structural issues, missing values, duplicate transaction IDs, and inconsistencies in date and time fields.

Initial checks indicated:

- No missing values were identified.

- No duplicate transaction IDs were identified.

- Date and time values were consistent in their original representation.

Step 2: Data Type Standardisation

Columns were reviewed and prepared for analysis using appropriate data types and formats.

Column

Intended data type or format

- transaction_id, store_id, product_id, transaction_qty: Whole number

- transaction_date: Date (YYYY-MM-DD)

- transaction_time: Time (HH:MM:SS)

- unit_price: Currency

Date and time fields were prepared for temporal analysis, while numeric fields were checked for compatibility with calculations and aggregation.

Step 3: Feature Engineering

Five calculated columns were created to support more detailed sales analysis and interactive dashboard filtering.

These attributes were incorporated into the dataset to facilitate comparisons across operational time periods and other relevant business dimensions.

- Time of Day Bucket (Operational Shift): Evaluated raw timestamp in Column F to categorize sales into operational shifts:
=IF(F2<TIME(6,0,0),"Night",IF(F2<TIME(12,0,0),"Morning",IF(F2<TIME(18,0,0),"Afternoon","Night"))

- Day of Week: Extracted three-letter abbreviated weekday strings from Column "transaction_date":=TEXT([@[transaction_date]],"ddd")
  
- Month Name: Extracted three-letter abbreviated month strings from Column "transaction_date":=TEXT([@[transaction_date]],"MMM")

- Extracted four-digit calendar year from Column "transaction_date":=TEXT([@[transaction_date]],"YYYY")

- Total Line Sales: Calculated line item gross revenue by multiplying quantity by unit price:=[@[transaction_qty]]*[@[unit_price]]


## 7 Exploratory Data Analysis and Methodology
The analytical methodology followed a structured 3-stage process:

| Phase | Activities |
|---|---|
| **Phase 1: Excel Pivot Engine** | • Built  `Pivot` worksheet.<br>• Calculated key performance indicators (KPIs).<br>• Created dynamic peak-value lookup text cards. |
| ↓ | **Followed by Phase 2: Visual Dashboard Architecture** |
| **Phase 2: Visual Dashboard ** | • Structured five metric cards.<br>• Created doughnut, bar, and line charts.<br>• Connected slicers across PivotTables. |
| ↓ | **Followed by Phase 3: PostgreSQL Cross-Reconciliation** |
| **Phase 3: PostgreSQL Cross-Reconciliation** | • Created the SQL database table schema.<br>• Loaded 14,116 rows using `COPY`.<br>• Replicated the Excel aggregations using SQL queries. |

## 8 Complete PostgreSQL Query Implementation
Below is the full, unedited PostgreSQL script executed to validate the Excel outputs:
[SQL Analysis Code](./coffee_sales_analysis.sql)

## 9 Dashboard and Visualization
The dashboard was designed using a Warm Roast Coffee Palette to match industry branding, featuring clean card containers, clear typography hierarchy, and interactive slicer controls.

### Key Findings and Insights

#### A. Overall Coffee Sales Performance
- [Coffee Sales Dashboard](./Coffee_Sales_Analysis_Dashboard.png)
The analysis covered 14,116 rows of coffee sales data from January to June 2023. The following metrics summarise the overall performance of the three store locations.

| Performance Metric | Result |
|---|---:|
| Total Sales Revenue | $698,812.33 |
| Total Transaction Records | 149,116 |
| Average Unit Price | $3.38 |
| Total Units Sold | 214,470 |
| Top Product by Revenue | Barista Espresso ($91,406) |
| Best-Performing Month | June ($166,486) |
| Best-Performing Weekday | Monday ($101,677) |

#### B. Order Volume vs. Sales Revenue: Brewed Chai Tea and Barista Espresso

One of the interesting findings from the analysis was that the most frequently ordered product was not the product generating the highest revenue.

- **Brewed Chai Tea:** Ranked first by order volume, with 17,183 orders and approximately $77,125 in sales revenue.
- **Barista Espresso:** Ranked third by order volume, with 16,403 orders, but generated the highest revenue at $91,406.

Although Brewed Chai Tea was ordered more frequently, Barista Espresso generated $14,281 more in revenue.

This shows why businesses should look beyond order frequency when evaluating product performance. A product can attract more orders without generating the highest revenue.

For the business, this presents two opportunities: increase the average spend of customers who order Brewed Chai Tea and explore ways to maintain or grow sales of Barista Espresso.

#### C. Comparing Performance Across Store Locations 
Using the dashboard slicers, I compared sales performance across Lower Manhattan, Hell's Kitchen, and Astoria to identify differences in customer purchasing patterns and sales activity.
**Geographic Location Slicers (Store Comparisons)**

- [Lower Manhattan Slicer View](./Lower_Manhattan_View.png)
- [Hell's Kitchen Slicer View](./Hell_Slicer_View.png)	
- [Astoria Slicer View](./Astoria_Slicer_View.png)

| Performance Metric | Lower Manhattan | Hell's Kitchen | Astoria |
|---|---:|---:|---:|
| Total Sales Revenue | $230.1K | $236.5K | $232.2K |
| Transaction Records | 47.8K | 50.7K | 50.6K |
| Average Unit Price | $3.37 | $3.39 | $3.38 |
| Total Units Sold | 71,742 | 71,737 | 70,991 |
| Morning Sales Share | 63% | 59% | 45% |
| Afternoon Sales Share | 34% | 30% | 41% |
| Night Sales Share | 3% | 11% | 14% |
| Peak Sales Weekday | Monday ($34.4K) | Tuesday ($34.8K) | Wednesday ($34.2K) |
| Peak Sales Month | June ($54.4K) | June ($57.0K) | June ($55.1K) |
| Top Revenue Category | Coffee ($88.9K) | Coffee ($91.2K) | Coffee ($89.7K) |
| Top Product by Revenue | Barista Espresso ($31.1K) | Barista Espresso ($32.4K) | Barista Espresso ($27.9K) |

Hell's Kitchen generated the highest total revenue, while all three locations recorded similar sales figures and average unit prices.

The main difference was when sales occurred. Lower Manhattan recorded its highest share of sales in the morning, while Astoria had a larger afternoon and night sales share. These patterns suggest that customer purchasing behaviour may differ by location.

June was the best-performing month across all three stores, and Barista Espresso was the leading product by revenue in each location.

## 10 Business Interpretation

#### Sales volume does not tell the whole story

Brewed Chai Tea had the highest order volume, but Barista Espresso generated more revenue. This highlights the importance of evaluating products using multiple measures, including order frequency, sales revenue, and units sold.

#### Sales patterns differ by location

Lower Manhattan recorded 63% of its sales in the morning, compared with 45% in Astoria. Night sales accounted for only 3% of Lower Manhattan's revenue, while Astoria recorded 14%.

These differences suggest that the stores may benefit from different staffing and inventory plans. However, sales data alone cannot establish whether current staffing levels or operating hours are inefficient. Cost and staffing data would be needed to assess that.

#### Monday leads overall, but not at every location

Monday generated the highest sales across the chain, at $101,677. However, the peak weekday varied by location: Monday in Lower Manhattan, Tuesday in Hell's Kitchen, and Wednesday in Astoria.

This suggests that management should consider both overall sales trends and individual store patterns when planning promotions, staffing, and stock levels.

#### June was the strongest month

June generated $166,486 in sales and was the best-performing month across all three locations. 

## 11 Business Recommendations

Based on the findings, I identified the following actions the business could explore.

#### 1. Increase the value of Brewed Chai Tea purchases

Brewed Chai Tea attracted the highest number of orders but generated less revenue than Barista Espresso.

The business could test product bundles that pair Brewed Chai Tea with pastries or snacks, such as scones. This would provide an opportunity to increase the average transaction value without relying solely on selling more drinks.

#### 2. Improve the visibility of Barista Espresso

Barista Espresso generated the highest revenue across the chain and was the leading product by revenue in all three locations.

The business could test more prominent menu placement, staff recommendations, and limited-time promotions to maintain or increase demand. The results should be tracked to determine whether these changes improve sales.

#### 3. Test a price adjustment for Brewed Chai Tea

Given its high order volume, Brewed Chai Tea could be considered for a small price-increase test.

Rather than assuming that regular customers would accept a higher price, the business could test a modest 5% increase in a selected location and monitor changes in sales volume, revenue, and profit margin before making a wider decision.

#### 4. Review staffing and inventory by location

Lower Manhattan's sales were concentrated in the morning, while Astoria recorded a larger share of afternoon and night sales.

Management could compare hourly sales with staffing costs and stock usage to determine whether adjustments to shift schedules or inventory would improve efficiency. Any changes should be based on the cost of operating each shift as well as the revenue generated.

#### 5. Investigate the factors behind June's performance

Since June was the best-performing month across all three stores, management could examine product sales, transaction volumes, and location-level trends to understand what drove the increase.

These findings could help inform future sales planning, provided the business can identify which factors are repeatable.

## Author and Contact
Fatolu Adedoyin Juliana

Data Analyst |  Statistics Graduate | Research Analyst 

LinkedIn: Fatolu Adedoyin Juliana

GitHub Profile: fajuliana-source

Email: fatoluadedoyin46@gmail.com 
