/*
Project: Monthly Business Metrics Analysis

Domain: Online Education

Database: skyeng_db

Description:
This project analyzes monthly business metrics to validate
the hypothesis that the decline in revenue during 2017
was associated with a decrease in lesson activity
and the number of active students.
*/

-- ============================================================================
-- Monthly Business Metrics
--
-- Business goal:
-- Validate the hypothesis that the decline in revenue
-- during 2017 was associated with a decrease in lesson
-- activity and the number of active students.
--
-- Approach:
-- Aggregate payment and lesson data separately
-- using nested subqueries and combine them into
-- a single analytical dataset.
-- ============================================================================

SELECT
    sp.month,
    sp.sum_payments,
    sc.cnt_classes,
    sc.cnt_users
FROM
(
    SELECT
        date_trunc('month', transaction_datetime) AS month,
        SUM(payment_amount) AS sum_payments

    FROM skyeng_db.payments

    WHERE status_name = 'success'
      AND date_part('year', transaction_datetime) = 2017

    GROUP BY month
) sp

FULL JOIN
(
    SELECT
        date_trunc('month', class_status_datetime) AS month,
        COUNT(*) AS cnt_classes,
        COUNT(DISTINCT user_id) AS cnt_users

    FROM skyeng_db.classes

    WHERE class_status = 'success'
      AND date_part('year', class_status_datetime) = 2017

    GROUP BY month
) sc
    ON sp.month = sc.month

ORDER BY sp.month;


/*
===============================================================================
Business Interpretation

The resulting dataset combines monthly revenue,
completed lessons, and active students for 2017,
allowing validation of the proposed business hypothesis.
===============================================================================
*/

/*
===============================================================================
Insights

Monthly revenue generally declined throughout 2017.

The decrease in revenue was accompanied by a reduction
in both the number of successful lessons and the number
of active students.

Although several months showed temporary increases,
the overall downward trend supports the business hypothesis
that lower operational activity contributed to the decline
in revenue.
===============================================================================
*/
