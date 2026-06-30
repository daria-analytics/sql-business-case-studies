# Customer Purchase Analysis

## Project Overview

This SQL project analyzes customer purchase behavior in an online cinema service.

The objective is to understand how users make their first and repeat purchases, evaluate acquisition partners, and analyze the time between consecutive purchases.

The analysis is based on transactional subscription data using SQL window functions, joins, CTEs, and aggregation.

---

## Business Tasks

The project focuses on three analytical tasks:

1. Build an analytical dataset that identifies the sequence of customer purchases.
2. Analyze which acquisition partners generate the largest number of first-time customers.
3. Measure how quickly customers return for a second purchase across different acquisition channels.

---

## Dataset

Tables used:

- `client_sign_up` — subscription purchase history
- `partner_dict` — acquisition partner dictionary

---

## SQL Techniques

- Common Table Expressions (CTE)
- LEFT JOIN
- Window Functions
  - ROW_NUMBER()
  - LAG()
- Aggregate Functions
- Date Arithmetic
- CASE WHEN
- GROUP BY
- ORDER BY

---

## Project Workflow

### Step 1. Customer Purchase Ranking

Created a reusable analytical dataset by ranking customer purchases chronologically.
This dataset serves as the foundation for identifying first and repeat purchases.

- Joined purchase data with the partner dictionary.
- Assigned each purchase its sequence number within the customer's history.
- Built a reusable analytical dataset for further analysis.

### Step 2. First Purchase Analysis

Filtered only first purchases to evaluate customer acquisition.
Compared acquisition partners and subscription types to identify the channels that bring the highest number of new customers.

- Filtered only first purchases.
- Compared acquisition partners.
- Analyzed paid vs. trial subscriptions.
- Ranked partners by the number of new customers.

### Step 3. Customer Return Analysis

Calculated the average time between the first and second purchase using window functions.
Compared customer return speed across acquisition partners to evaluate engagement quality.

- Retrieved the previous purchase date using `LAG()`.
- Selected only second purchases.
- Calculated the average time between the first and second purchase.
- Compared customer return speed across partners.

---

## Skills Demonstrated

- SQL
- PostgreSQL
- Window Functions
- Common Table Expressions (CTEs)
- Customer Analytics
- Product Analytics
- Cohort & Retention Analysis
- Business Analysis

---

## Repository Structure

customer_purchase_analysis/
│
├── README.md
└── skycinema_customer_purchase_analysis.sql

---

## Key Takeaways

This project demonstrates how SQL window functions can be used to transform raw transactional data into business insights.

The resulting analytical dataset allows analysts to identify customer acquisition patterns, distinguish first-time and repeat customers, and evaluate partner performance based on customer retention.

---


## Author

**Daria Sinitsyna**  
Junior Data Analyst
