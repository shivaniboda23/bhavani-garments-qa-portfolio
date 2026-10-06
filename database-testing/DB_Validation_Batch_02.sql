-- Bhavani ERP database validation, batch 02
-- Read-only checks. Run while connected to bhavani_erp_v2.
-- A REVIEW REQUIRED result is a finding to investigate, not automatically a confirmed defect.
WITH checks AS (
    SELECT 'DB-007' AS test_id,
           'Sale item quantity equals K plus R' AS test_name,
           COUNT(*) AS records_checked,
           COUNT(*) FILTER (
               WHERE quantity <> k_quantity + r_quantity
                  OR quantity < 0 OR k_quantity < 0 OR r_quantity < 0
           ) AS issues_found
    FROM public.sale_items

    UNION ALL

    SELECT 'DB-008', 'Sale return item quantity equals K plus R',
           COUNT(*),
           COUNT(*) FILTER (
               WHERE quantity <> k_quantity + r_quantity
                  OR quantity < 0 OR k_quantity < 0 OR r_quantity < 0
           )
    FROM public.sale_return_items

    UNION ALL

    SELECT 'DB-009', 'Sale returns match their sale shop and customer',
           COUNT(*),
           COUNT(*) FILTER (
               WHERE s.id IS NULL
                  OR sr.shop_id IS DISTINCT FROM s.shop_id
                  OR sr.customer_id IS DISTINCT FROM s.customer_id
           )
    FROM public.sale_returns sr
    LEFT JOIN public.sales s ON s.id = sr.sale_id

    UNION ALL

    SELECT 'DB-010', 'Returned variant appears on the original sale',
           COUNT(*),
           COUNT(*) FILTER (
               WHERE NOT EXISTS (
                   SELECT 1
                   FROM public.sale_items si
                   JOIN public.sale_returns sr ON sr.sale_id = si.sale_id
                   WHERE sr.id = sri.sale_return_id
                     AND si.variant_id = sri.variant_id
               )
           )
    FROM public.sale_return_items sri

    UNION ALL

    SELECT 'DB-011', 'Payment amounts are positive',
           COUNT(*), COUNT(*) FILTER (WHERE amount <= 0)
    FROM public.payments

    UNION ALL

    SELECT 'DB-012', 'Bill totals are not negative',
           COUNT(*), COUNT(*) FILTER (WHERE grand_total < 0)
    FROM public.bills

    UNION ALL

    SELECT 'DB-013', 'Sale return refunds are not negative',
           COUNT(*), COUNT(*) FILTER (WHERE refund_amount < 0)
    FROM public.sale_return_items
)
SELECT current_database() AS database_name,
       CURRENT_TIMESTAMP AS executed_at,
       test_id, test_name, records_checked, issues_found,
       CASE WHEN records_checked = 0 THEN 'NOT TESTED - NO DATA'
            WHEN issues_found = 0 THEN 'PASS'
            ELSE 'REVIEW REQUIRED'
       END AS result
FROM checks
ORDER BY test_id;
