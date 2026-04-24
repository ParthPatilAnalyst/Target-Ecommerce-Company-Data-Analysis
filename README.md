# Target E-Commerce Data Analysis

## Project Overview
[cite_start]This project presents an end-to-end data analysis of **Target's e-commerce operations in Brazil**[cite: 1, 11]. [cite_start]Using a real-world dataset of approximately **100,000 orders** placed between 2016 and 2018, the study extracts actionable insights regarding customer behavior, sales trends, revenue growth, and seller productivity[cite: 11, 12].

The analysis is implemented in **two separate versions**:
1.  [cite_start]**Python:** Built using Pandas, NumPy, and Matplotlib within Jupyter Notebook[cite: 13, 21].
2.  [cite_start]**MySQL:** Built using structured SQL queries (MySQL 8.0+) in MySQL Workbench[cite: 13, 111].

[cite_start]Both implementations address the same 15 business questions ranging from basic demographics to advanced strategic metrics like customer retention and YoY growth[cite: 13, 105, 107].

---

## Technical Stack
* [cite_start]**Languages:** Python (3.13.5), SQL (MySQL 8.0+ dialect) [cite: 15]
* [cite_start]**Python Libraries:** Pandas, NumPy, Matplotlib [cite: 6, 24]
* [cite_start]**Tools:** Jupyter Notebook, MySQL Workbench 8.0 [cite: 15, 115]

---

## Dataset Description
[cite_start]The analysis utilizes a relational schema consisting of **seven interconnected CSV files**[cite: 17, 18]:

| Table | Description | Key Metric |
| :--- | :--- | :--- |
| **Customers** | Identity, ZIP code, and location | [cite_start]99,441 rows [cite: 18] |
| **Orders** | Lifecycle timestamps and status | [cite_start]99,441 rows [cite: 18] |
| **Payments** | Payment types and installments | [cite_start]103,886 rows [cite: 18] |
| **Order Items** | Product, seller, and price data | [cite_start]112,650 rows [cite: 18] |
| **Products** | Category and physical dimensions | [cite_start]32,951 rows [cite: 18] |
| **Sellers** | Seller location data | [cite_start]3,095 rows [cite: 18] |
| **Geolocation** | Lat/Long coordinates per ZIP | [cite_start]1,000,163 rows [cite: 18] |

---

## Key Business Questions Answered

### Basic Insights
* [cite_start]**B1: Unique Customer Cities:** Identified the geographic spread across Brazil[cite: 79, 80].
* [cite_start]**B3: Total Sales per Category:** Visualized revenue drivers (e.g., Health & Beauty, Watches)[cite: 83, 84].
* [cite_start]**B4: Installment Behavior:** Analyzed the "parcelamento" culture (majority of orders use installments)[cite: 85, 86].

### Intermediate Trends
* [cite_start]**I1: Monthly Seasonality:** Identified 2018 order volume patterns[cite: 90, 91].
* [cite_start]**I3: Revenue Share:** Calculated the percentage of total revenue per category[cite: 94, 95].
* [cite_start]**I5: Seller Ranking:** Identified top-performing sellers generating disproportionate revenue[cite: 98, 99].

### Advanced Analytics
* [cite_start]**A2: Cumulative Sales:** Tracked running revenue totals month-by-month for target tracking[cite: 103, 104].
* [cite_start]**A3: Year-over-Year (YoY) Growth:** Quantified the transition from hyper-growth (2016-17) to market maturation (2017-18)[cite: 105, 106].
* [cite_start]**A4: Customer Retention:** Measured the percentage of customers repurchasing within a 6-month window[cite: 107, 108].

---

## Key Findings
* **Geography:** Sao Paulo dominates the customer base; [cite_start]North/Northeast regions represent potential growth markets[cite: 88, 158].
* [cite_start]**Retention:** Most customers made only one purchase, highlighting a critical need for loyalty programs[cite: 108, 158].
* [cite_start]**Revenue Concentration:** A small number of top sellers and categories drive the majority of platform revenue[cite: 99, 158].

---

## How to Run

### Python Version
1.  [cite_start]Clone the repository: `git clone https://github.com/ParthPatilAnalyst/Target-Ecommerce-Company-Data-Analysis`[cite: 164].
2.  [cite_start]Install dependencies: `pip install pandas numpy matplotlib jupyter`[cite: 165].
3.  [cite_start]Update the `BASE_PATH` in Cell 2 of `Target_final.ipynb` to your local data folder[cite: 166].
4.  [cite_start]Run all cells via **Kernel > Restart & Run All**[cite: 168].

### MySQL Version
1.  [cite_start]Ensure **MySQL 8.0+** is installed (required for Window Functions)[cite: 114, 115].
2.  [cite_start]Import the 7 CSV files using the **Table Data Import Wizard** in MySQL Workbench[cite: 171].
3.  [cite_start]Open and execute `ecommerce_analysis_fixed.sql`[cite: 173, 174].

---

