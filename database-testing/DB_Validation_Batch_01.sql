-- Bhavani ERP database validation, batch 01
-- Read-only relationship checks. Run while connected to bhavani_erp_v2.
-- Expected result: issues_found = 0 for each check with records_checked > 0.
WITH checks AS (
    SELECT 'DB-001' AS test_id,
           'Payments reference existing bills' AS test_name,
           COUNT(*) AS records_checked,
           COUNT(*) FILTER (WHERE b.id IS NULL) AS issues_found
    FROM public.payments p
    LEFT JOIN public.bills b ON b.id = p.bill_id

    UNION ALL

    SELECT 'DB-002', 'Bill items reference existing bills',
           COUNT(*), COUNT(*) FILTER (WHERE b.id IS NULL)
    FROM public.bill_items bi
    LEFT JOIN public.bills b ON b.id = bi.bill_id

    UNION ALL

    SELECT 'DB-003', 'Sale items reference existing sales',
           COUNT(*), COUNT(*) FILTER (WHERE s.id IS NULL)
    FROM public.sale_items si
    LEFT JOIN public.sales s ON s.id = si.sale_id

    UNION ALL

    SELECT 'DB-004', 'Return items reference existing returns',
           COUNT(*), COUNT(*) FILTER (WHERE sr.id IS NULL)
    FROM public.sale_return_items sri
    LEFT JOIN public.sale_returns sr ON sr.id = sri.sale_return_id

    UNION ALL

    SELECT 'DB-005', 'Bill customers exist in the same shop',
           COUNT(*),
           COUNT(*) FILTER (
               WHERE c.id IS NULL OR c.shop_id IS DISTINCT FROM b.shop_id
           )
    FROM public.bills b
    LEFT JOIN public.customers c ON c.id = b.customer_id
    WHERE b.customer_id IS NOT NULL

    UNION ALL

    SELECT 'DB-006', 'Linked bills and sales match shop and customer',
           COUNT(*),
           COUNT(*) FILTER (
               WHERE s.id IS NULL
                  OR s.shop_id IS DISTINCT FROM b.shop_id
                  OR s.customer_id IS DISTINCT FROM b.customer_id
           )
    FROM public.bills b
    LEFT JOIN public.sales s ON s.id = b.sale_id
    WHERE b.sale_id IS NOT NULL
)
SELECT current_database() AS database_name,
       CURRENT_TIMESTAMP AS executed_at,
       test_id,
       test_name,
       records_checked,
       0 AS expected_issues,
       issues_found,
       CASE WHEN records_checked = 0 THEN 'NOT TESTED - NO DATA'
            WHEN issues_found = 0 THEN 'PASS'
            ELSE 'REVIEW REQUIRED'
       END AS result
FROM checks
ORDER BY test_id;
