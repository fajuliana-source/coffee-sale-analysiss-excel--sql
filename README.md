# coffee-sale-analysiss-excel--sql
# End-to-End Coffee Sales Analytics: Dual Excel Dashboard & PostgreSQL Data Validation

[![Tools](https://img.shields.io/badge/Tools-Microsoft_Excel_%7C_PostgreSQL-blue?style=flat-square)](https://github.com)
[![Domain](https://img.shields.io/badge/Domain-Retail_%26_F%26B_Analytics-brown?style=flat-square)](https://github.com)
[![Dataset](https://img.shields.io/badge/Data_Size-14%2C117_Records-orange?style=flat-square)](https://www.kaggle.com)

---

## 1. Project Overview
This project delivers a comprehensive, end-to-end commercial analytics solution evaluating the performance of a multi-location coffee retail chain operating across three primary  store Locations: **Lower Manhattan, Hell's Kitchen, and Astoria.**

This project bridges the gap between front-end visual reporting and back-end database engineering. The project began by engineering an interactive executive dashboard in Microsoft Excel to visualize sales performance, operational shift concentrations, product volume vs. revenue divergences, and geographic purchasing behaviors across 14,116 raw transaction logs and **214,470** total units sold) from January 1, 2023, to June 30, 2023.

To achieve enterprise-level data validation, the entire analysis was subsequently re-engineered in **PostgreSQL**. By translating visual pivot logic into structured database queries **(CTEs, aggregate functions, conditional grouping, and timestamp extractions)**, every key performance indicator (KPI), trend line, and ranking was cross-validated. This dual-tool approach guarantees 100% data reconciliation, proving that the numbers driving executive decisions are accurate, repeatable, and audit-ready.

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
| product_detail | Text | Granular SKU description and sizing details |

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

Other Analysis 
- Which top 5 product categories contribute the largest share to total sales?
- Which specific product types dominate transaction order volume (Top 10 Most Ordered)?
- Which specific product types dominate gross revenue generation (Top 10 Highest Earning)?
- Does a discrepancy exist between customer order frequency and total dollar return?

Geographic & Slicer Analysis
- How do sales KPIs, shift patterns, and product preferences shift when filtering specifically by Lower Manhattan, Hell's Kitchen, and Astoria?

## 5. Tools and Commands
Microsoft Excel

- Used for data inspection, preparation, feature engineering, and interactive dashboard development.

- Data Cleaning and Preparation: Inspected the raw dataset for missing values, duplicate transaction IDs, and inconsistencies in date and time fields.

- Feature Engineering: Created calculated columns to support time-based and multidimensional sales analysis.

- Dynamic Lookup Formulas: Used INDEX, MATCH, and MAX to build dynamic lookup functionality and display selected results using custom number and text formatting.

- Interactive Dashboard Development: Designed an interactive dashboard incorporating timeline slicers, visual hierarchy, custom colour branding, and shape-based containers to improve navigation and readability.

PostgreSQL 17:
- Used for relational table creation, data ingestion, and analytical querying.

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
=IF(F2<TIME(6,0,0),"Night",IF(F2<TIME(12,0,0),"Morning",IF(F2<TIME(18,0,0),"Afternoon","Night")))y model.
     
- Day of Week: Extracted three-letter abbreviated weekday strings from Column "transaction_date":=TEXT([@[transaction_date]],"ddd")
- Month Name: Extracted three-letter abbreviated month strings from Column "transaction_date":=TEXT([@[transaction_date]],"MMM")
- Extracted four-digit calendar year from Column "transaction_date":=TEXT([@[transaction_date]],"YYYY")
- Total Line Sales: Calculated line item gross revenue by multiplying quantity by unit price:=[@[transaction_qty]]*[@[unit_price]]


## Exploratory Data Analysis and Methodology
The analytical methodology followed a structured 3-stage process:

| Phase | Activities |
|---|---|
| **Phase 1: Excel Pivot Engine** | • Built a dedicated `Pivot` worksheet.<br>• Calculated key performance indicators (KPIs).<br>• Created dynamic peak-value lookup text cards. |
| ↓ | **Followed by Phase 2: Visual Dashboard Architecture** |
| **Phase 2: Visual Dashboard Architecture** | • Structured five metric cards.<br>• Created doughnut, bar, and line charts.<br>• Connected slicers across PivotTables. |
| ↓ | **Followed by Phase 3: PostgreSQL Cross-Reconciliation** |
| **Phase 3: PostgreSQL Cross-Reconciliation** | • Created the SQL database table schema.<br>• Loaded 14,117 rows using `COPY`.<br>• Replicated the Excel aggregations using SQL queries. |

## Complete PostgreSQL Query Implementation
Below is the full, unedited PostgreSQL script executed to validate the Excel outputs:
[SQL Analysis Code](./coffee_sales_analysis.sql)

## Dashboard and Visualization
- [Coffee Sales Dashboard](./Coffee_Sales_Analysis_Dashboard.png)
