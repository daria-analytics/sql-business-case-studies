/*
Project: Customer Purchase Analysis Domain: Online Cinema Database: skycinema
Description: This project analyzes customer purchase behavior using SQL window functions. The analysis focuses on customer acquisition, first purchases, and repeat purchase behavior across acquisition partners.
*/
-- ============================================================================ -- STEP 1 -- Build an analytical dataset with purchase sequence numbers.
-- Business goal: -- Identify the order of purchases for each customer. -- This dataset will be reused in the following analyses. -- ============================================================================
with purchase_history as (
select
    csu.purchase_id,
    csu.user_id,
    csu.partner,
    pd.name_partner,
    csu.date_purchase,
    csu.amt_payment,
    csu.is_trial,

    row_number() over (
        partition by csu.user_id
        order by csu.date_purchase, csu.purchase_id
    ) as customer_purchase_number

from skycinema.client_sign_up csu

left join skycinema.partner_dict pd
    on csu.partner = pd.id_partner
)
select *
from purchase_history
-- ============================================================================ -- STEP 2 -- Analyze first customer purchases.
-- Business goal: -- Compare acquisition partners by the number of new customers -- and evaluate trial vs. paid subscriptions. -- ============================================================================
WITH purchase_history AS (
SELECT
    csu.purchase_id,
    csu.user_id,
    csu.partner,
    pd.name_partner,
    csu.date_purchase,
    csu.amt_payment,
    csu.is_trial,

    ROW_NUMBER() OVER (
        PARTITION BY csu.user_id
        ORDER BY
            csu.date_purchase,
            csu.purchase_id
    ) AS customer_purchase_number

FROM skycinema.client_sign_up AS csu

LEFT JOIN skycinema.partner_dict AS pd
    ON csu.partner = pd.id_partner
)
SELECT name_partner, is_trial, COUNT(*) AS first_purchase_count
FROM purchase_history
WHERE customer_purchase_number = 1
GROUP BY name_partner, is_trial
ORDER BY first_purchase_count DESC
/* Insight
Only first purchases are included in the analysis because the goal is to evaluate customer acquisition rather than overall purchasing activity. Restricting the dataset to each customer's first purchase ensures that every customer is counted only once. */
-- ============================================================================ -- STEP 3 -- Analyze customer return behavior.
-- Business goal: -- Calculate the average time between the first and second purchase -- for each acquisition partner. -- ============================================================================
WITH purchase_history AS (
SELECT
    csu.purchase_id,
    csu.user_id,
    csu.partner,
    pd.name_partner,
    csu.date_purchase,
    csu.amt_payment,
    csu.is_trial,

    ROW_NUMBER() OVER (
        PARTITION BY csu.user_id
        ORDER BY
            csu.date_purchase,
            csu.purchase_id
    ) AS customer_purchase_number,

    LAG(csu.date_purchase) OVER (
        PARTITION BY csu.user_id
        ORDER BY
            csu.date_purchase,
            csu.purchase_id
    ) AS previous_purchase_date

FROM skycinema.client_sign_up AS csu

LEFT JOIN skycinema.partner_dict AS pd
    ON csu.partner = pd.id_partner
)
SELECT name_partner, AVG(date_purchase - previous_purchase_date) AS average_time_to_second_purchase
FROM purchase_history
WHERE customer_purchase_number = 2
GROUP BY name_partner
ORDER BY average_time_to_second_purchase

