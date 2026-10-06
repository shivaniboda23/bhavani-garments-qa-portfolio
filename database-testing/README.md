# Bhavani Garments ERP — PostgreSQL validation exercise

**Scope:** read-only checks against a local development database, executed 6 October 2026. This exercise tested referential integrity, quantity allocation, return relationships, and basic monetary constraints. It did not change database rows.

## Results

| Group | Checks | Result |
| --- | ---: | --- |
| Reference and shop consistency (DB-001–DB-006) | 6 | 6 pass |
| Quantity and return checks (DB-007–DB-010) | 4 | 2 pass; 2 review required |
| Payment and amount checks (DB-011–DB-013) | 3 | 3 pass |
| **Total** | **13** | **11 pass; 2 review required** |

Additional reconciliation of eight completed returns found one older record whose header refund differed from its item refund sum. This is recorded for investigation. A historical data discrepancy is not, by itself, proof that the current application still creates the same result.

Two sample bills were independently calculated from their database payments and completed returns. Their customer-facing amounts were **not** verified in the Flutter UI: one bill had no customer association, and the other had no outstanding due. The screens available during the check did not expose a bill-level due/refund comparison for those records. No UI pass or UI defect is claimed.

## Method and interpretation

1. Inspected relevant PostgreSQL table columns before constructing queries.
2. Ran SELECT-only checks and recorded records examined, mismatches, and execution time.
3. Investigated flagged rows through their related sale and return records.
4. Separated observed data discrepancies from unverified causes and present-day reproducibility.
5. Kept detailed row IDs, invoice numbers, customer information, and credentials out of this public summary.

**Interview explanation:** “I ran 13 read-only PostgreSQL checks on the ERP’s billing and return data. Eleven passed. Two allocation checks found older rows needing review, and a separate refund reconciliation found one historical difference. I documented what the queries proved and kept UI verification marked incomplete where the app did not expose those records.”
