# Monthly Business Metrics Analysis

## Project Overview

This SQL project analyzes monthly business performance in an online education platform.

The objective is to validate the hypothesis that the decline in revenue during 2017 was associated with a decrease in both the number of completed lessons and the number of active students.

The analysis combines payment and lesson data into a single monthly analytical dataset.

---

## Business Task

Validate the following business hypothesis:

> During 2017, the decrease in revenue was caused by a reduction in:
>
> - the total number of successful lessons;
> - the total number of active students.

To test the hypothesis, monthly revenue, lesson activity, and student activity are compared throughout 2017.

---

## Dataset

Tables used:

- `payments` — payment transactions
- `classes` — lesson history

---

## SQL Techniques

- Common Table Expressions (CTEs)
- Aggregate Functions
- FULL JOIN
- COUNT(DISTINCT)
- DATE_TRUNC()
- GROUP BY
- ORDER BY

---

## Project Workflow

### Step 1. Monthly Revenue

Calculated monthly revenue using successful payment transactions.

- Filtered successful payments.
- Aggregated payment amounts by month.

### Step 2. Monthly Learning Activity

Calculated lesson activity for each month.

- Filtered successful lessons.
- Counted completed lessons.
- Counted active students.

### Step 3. Business Metrics Dashboard

Combined revenue and learning activity into a unified monthly dataset.

- Joined monthly payment and lesson statistics.
- Prepared the dataset for business hypothesis validation.

---

## Skills Demonstrated

- SQL
- PostgreSQL
- Data Aggregation
- CTE Design
- Business Metrics
- Customer Activity Analysis
- Time Series Aggregation
- Analytical Data Modeling

---

## Repository Structure

monthly_business_metrics_analysis/

├── README.md

└── monthly_business_metrics_analysis.sql

---

## Key Takeaways

This project demonstrates how to build an analytical dataset by combining multiple business metrics with different levels of granularity.

The resulting monthly dashboard enables analysts to evaluate business performance trends and validate revenue-related hypotheses using operational data.

---

## Author

**Daria Sinitsyna**

Junior Data Analyst
