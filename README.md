# coffee-sale-analysiss-excel--sql
Dual Excel Dashboard &amp; PostgreSQL Data Reconciliation for Retail Coffee Sales
# ☕ End-to-End Coffee Sales Analytics: Dual Excel Dashboard & PostgreSQL Data Reconciliation

[![Tools]  (https://img.shields.io/badge/Tools-Microsoft_Excel_%7C_PostgreSQL-blue?style=flat-square)](https://github.com)

[![Domain]  (https://img.shields.io/badge/Domain-Retail_%26_F%26B_Analytics-brown?style=flat-square)](https://github.com)


[![Dataset] (https://img.shields.io/badge/Data_Size-14%2C117_Records-orange?style=flat-square)](https://www.kaggle.com)

---

## 📌 Executive Summary

This project presents a dual-platform commercial data analysis of a multi-location coffee retail chain operating across **Astoria, Hell's Kitchen, and Lower Manhattan**. Analyzing **14,117 raw transaction records** (representing **149,116 line item entries** and **214,470 units sold**) spanning January 2023 through June 2023, the objective was twofold:

1. Build a dynamic executive dashboard in **Microsoft Excel** featuring multi-location slicers, nested conditional indicators, and automated KPI labels.
2. Re-engineer all business questions into **PostgreSQL** to validate dashboard metrics, verify data integrity, and ensure zero discrepancy between front-end visual reporting and backend database records.

---

## 📊 Dashboard Visual Interface

### 1. Master Executive Dashboard (All Stores Combined)
![Master Coffee Sales Dashboard](assets/coffee_dashboard_overall.png)

### 2. Location-Specific Comparative Views (Slicer States)
| Lower Manhattan (Office Commuter District) | Hell's Kitchen (High-Volume Core) | Astoria (Residential Neighborhood) |
|---|---|---|
| ![Lower Manhattan](assets/slicer_lower_manhattan.png) | ![Hell's Kitchen](assets/slicer_hells_kitchen.png) | ![Astoria](assets/slicer_astoria.png) |

---

## 💡 Key Findings & Analytical Highlights

### 1. Volume Leader vs. Revenue Driver Paradox
- **Brewed Chai Tea** is the undisputed **volume leader** across the chain with **17,183 total orders**, driving constant customer foot traffic.
- **Barista Espresso** is the primary **revenue engine**, generating **$91.4K ($91,406)** in sales despite registering fewer individual orders (16,403 orders).
- **Strategic Impact:** Menu engineering must protect Chai Tea as a foot-traffic acquisition channel while actively driving add-on upsells to match Espresso's dollar productivity.

```text
VOLUME vs. REVENUE PROFILE
Brewed Chai Tea   │ 17,183 Orders (Rank #1 Volume)  │ $77.1K Revenue (Rank #2 Dollars)
Barista Espresso  │ 16,403 Orders (Rank #3 Volume)  │ $91.4K Revenue (Rank #1 Dollars)
