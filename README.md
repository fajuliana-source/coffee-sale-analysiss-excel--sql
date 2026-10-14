# coffee-sale-analysiss-excel--sql
# ☕ End-to-End Coffee Sales Analytics: Dual Excel Dashboard & PostgreSQL Data Validation

[![Tools](https://img.shields.io/badge/Tools-Microsoft_Excel_%7C_PostgreSQL-blue?style=flat-square)](https://github.com)
[![Domain](https://img.shields.io/badge/Domain-Retail_%26_F%26B_Analytics-brown?style=flat-square)](https://github.com)
[![Dataset](https://img.shields.io/badge/Data_Size-14%2C117_Records-orange?style=flat-square)](https://www.kaggle.com)

---

## 1. Project Overview
This project presents a dual-platform commercial data analysis of a multi-location coffee retail chain operating across three New York locations (Astoria, Hell's Kitchen, and Lower Manhattan). The project validates raw transaction records using **PostgreSQL** queries and visualizes the commercial insights through an interactive executive dashboard built in **Microsoft Excel**.

## 2. Business Problem
Retail stakeholders often rely on visual dashboards to make rapid operational decisions, but those visualizations must be perfectly reconciled with backend database records. The business needed to uncover hidden sales trends, peak operational hours, and product performance drivers, while ensuring absolute data integrity between front-end reporting and the database.

## 3. Dataset Description
- **Source:** Kaggle Retail Transaction Dataset
- **Volume:** 14,117 raw transaction logs (representing 214,470 units sold)
- **Timeframe:** January 1, 2023 – June 30, 2023 (6 Months)
- **Granularity:** Transaction line-item level containing features like Date, Time, Location, Product Category, Product Type, Quantity, and Unit Price.

## 4. Business Questions
1. **Executive KPIs:** What are the total revenue, total order volume, average unit price, and total units sold?
2. **Temporal Trends:** How does revenue fluctuate by time of day, day of the week, and month-over-month?
3. **Product Performance:** Which product categories generate the highest revenue versus the highest order volume?
4. **Geographic Behavior:** How do purchasing behaviors and peak hours differ across the three store locations?

## 5. Tools and Technologies
- **Microsoft Excel:** Data cleaning, feature engineering, Pivot Tables, dynamic formulas (INDEX-MATCH), interactive dashboard design.
- **PostgreSQL:** Database schema creation, data ingestion (`COPY`), and analytical querying (CTEs, aggregations, grouping).
- **PowerPoint:** Executive presentation of SQL logic and business findings.

## 6. Data Cleaning and Preparation
The raw dataset was rigorously inspected for data quality:
- Verified zero missing values and zero duplicate transaction records.
- Standardized data types across all columns.
- Engineered **5 new calculated columns** to support analysis:
  - **Time of Day:** `=IF(F2<TIME(6,0,0),"Night",IF(F2<TIME(12,0,0),"Morning",IF(F2<TIME(18,0,0),"Afternoon","Night")))`
  - **Day of Week:** `=TEXT([@[transaction_date]],"ddd")`
  - **Month & Year:** `=TEXT([@[transaction_date]],"MMM")` and `=TEXT([@[transaction_date]],"YYYY")`
  - **Total Line Sales:** `=[@[transaction_qty]]*[@[unit_price]]`

## 7. Exploratory Data Analysis and Methodology
The methodology followed a 3-phase cross-platform validation approach:
1. **Phase 1 (Excel EDA):** Utilized a dedicated Pivot Engine to aggregate metrics by time, product, and location.
2. **Phase 2 (Dashboarding):** Built an interactive UI with dynamic subheaders automatically tracking peak metrics.
3. **Phase 3 (SQL Validation):** Replicated all Excel aggregation logic in PostgreSQL to verify data integrity. 

**Reconciliation Matrix:**
| Metric | Excel Output | PostgreSQL Output | Status |
|---|---|---|---|
| Total Revenue | $698.8K | $698,812.33 | ✅ Match |
| Total Orders | 149,116 | 149,116 | ✅ Match |
| Total Units Sold | 214,470 | 214,470 | ✅ Match |

## 8. Dashboard and Visualizations

**Master Executive Dashboard (All Stores Combined)**
![Master Coffee Sales Dashboard](assets/coffee_dashboard_overall.png)

**Location-Specific Comparative Views**
| Lower Manhattan | Hell's Kitchen | Astoria |
|---|---|---|
| ![Lower Manhattan](assets/slicer_lower_manhattan.png) | ![Hell's Kitchen](assets/slicer_hells_kitchen.png) | ![Astoria](assets/slicer_astoria.png) |

## 9. Key Findings and Insights
- **Volume vs. Revenue:** *Brewed Chai Tea* is the highest ordered product (17,183 orders), but *Barista Espresso* generates the highest revenue ($91.4K).
- **Time of Day:** 56% of overall sales occur during the Morning shift.
- **Peak Operational Day:** Monday is the highest-grossing day overall ($101.7K).
- **Store Personas:** 
  - *Lower Manhattan* relies heavily on morning commuters (63% morning sales).
  - *Astoria* exhibits strong afternoon (41%) and evening (14%) traffic, fitting a residential neighborhood profile.

## 10. Interpretation and Business Implications
The data reveals a critical **Volume vs. Revenue Paradox**. Relying strictly on transaction volume creates a false sense of product success. High-volume items like Chai Tea consume operational labor without driving top-line growth at the same rate as Espresso. Furthermore, a blanket operational strategy will fail, as individual stores demonstrate distinct commercial personas (commuter vs. residential).

## 11. Recommendations
1. **Chai Tea Bundling (AOV Strategy):** Implement point-of-sale protocols to pair high-frequency Chai Tea orders with high-margin bakery items (e.g., Scones) to boost Average Order Value.
2. **Elevate Espresso Visibility:** Reposition Barista Espresso prominently on digital and physical menu boards to drive conversion from regular drip-coffee drinkers.
3. **Location-Based Shift Scheduling:** Cut evening staff in Lower Manhattan (where night sales account for only 3%) and reallocate labor hours to Astoria's busy evening rush (14%).

## 12. Conclusion
By bridging the gap between front-end visualizations (Excel) and back-end database queries (PostgreSQL), this analysis not only ensured 100% data accuracy but also uncovered hidden revenue drivers. The business is now equipped to transition from a feeling-based operational strategy to a data-driven profitability model.
     
