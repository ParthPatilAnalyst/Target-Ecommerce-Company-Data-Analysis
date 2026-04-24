# Target E-Commerce Data Analysis

## Project Overview
This project presents an end-to-end data analysis of **Target's e-commerce operations in Brazil**Using a real-world dataset of approximately **100,000 orders** placed between 2016 and 2018, the study extracts actionable insights regarding customer behavior, sales trends, revenue growth, and seller productivity.

The analysis is implemented in **two separate versions**:
1.  **Python:** Built using Pandas, NumPy, and Matplotlib within Jupyter Notebook.
2.  **MySQL:** Built using structured SQL queries (MySQL 8.0+) in MySQL Workbench

Both implementations address the same 15 business questions ranging from basic demographics to advanced strategic metrics like customer retention and YoY growth
---

## Technical Stack
**Languages:** Python (3.13.5), SQL (MySQL 8.0+ dialect) 
**Python Libraries:** Pandas, NumPy, Matplotlib 
**Tools:** Jupyter Notebook, MySQL Workbench 8.0 

---

## Dataset Description
The analysis utilizes a relational schema consisting of **seven interconnected CSV files**

| Table | Description | Key Metric |
| :--- | :--- | :--- |
| **Customers** | Identity, ZIP code, and location | 99,441 rows  |
| **Orders** | Lifecycle timestamps and status | 99,441 rows  |
| **Payments** | Payment types and installments | 103,886 rows  |
| **Order Items** | Product, seller, and price data | 112,650 rows  |
| **Products** | Category and physical dimensions | 32,951 rows  |
| **Sellers** | Seller location data | 3,095 rows  |
| **Geolocation** | Lat/Long coordinates per ZIP | 1,000,163 rows  |

---

## Key Business Questions Answered

### Basic Insights
**B1: Unique Customer Cities:** Identified the geographic spread across Brazil.
**B3: Total Sales per Category:** Visualized revenue drivers (e.g., Health & Beauty, Watches).
**B4: Installment Behavior:** Analyzed the "parcelamento" culture (majority of orders use installments).

### Intermediate Trends
**I1: Monthly Seasonality:** Identified 2018 order volume patterns.
**I3: Revenue Share:** Calculated the percentage of total revenue per category.
**I5: Seller Ranking:** Identified top-performing sellers generating disproportionate revenue.

### Advanced Analytics
**A2: Cumulative Sales:** Tracked running revenue totals month-by-month for target tracking.
**A3: Year-over-Year (YoY) Growth:** Quantified the transition from hyper-growth (2016-17) to market maturation (2017-18).
**A4: Customer Retention:** Measured the percentage of customers repurchasing within a 6-month window.

---

## Key Findings
**Geography:** Sao Paulo dominates the customer base; [cite_start]North/Northeast regions represent potential growth markets.
**Retention:** Most customers made only one purchase, highlighting a critical need for loyalty programs.
**Revenue Concentration:** A small number of top sellers and categories drive the majority of platform revenue.

---

## How to Run

### Python Version
1.  Clone the repository: `git clone https://github.com/ParthPatilAnalyst/Target-Ecommerce-Company-Data-Analysis`.
2.  Install dependencies: `pip install pandas numpy matplotlib jupyter`.
3.  Update the `BASE_PATH` in Cell 2 of `Target_final.ipynb` to your local data folder.
4.  Run all cells via **Kernel > Restart & Run All**.

### MySQL Version
1.  Ensure **MySQL 8.0+** is installed (required for Window Functions)[cite: 114, 115].
2.  Import the 7 CSV files using the **Table Data Import Wizard** in MySQL Workbench[cite: 171].
3.  Open and execute `ecommerce_analysis_fixed.sql`[cite: 173, 174].

---

