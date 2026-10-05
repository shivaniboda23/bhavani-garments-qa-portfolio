# QA Interview Guide

Use these answers as speaking points. Understand them; do not memorize every sentence.

## 60-second project explanation

> Bhavani Garments ERP is a Flutter and FastAPI retail application covering customers, billing, sales, returns, stock, purchases, and supplier payments. I tested the application through exploratory browser checks, formal widget and regression runs, and Postman API requests. I converted the work into an STLC-aligned test plan with 31 formal test cases and a traceability matrix. I documented five genuine defects in Jira, moved them through To Do, In Progress, Ready for QA, and Done, and verified each fix using focused and full regression tests. I also executed a 16-request Postman collection covering bearer authentication, success, validation, missing-resource, duplicate, and cleanup scenarios. All 31 assertions passed.

## What did you personally do?

> I executed the commands and test runs, interacted with the application and Postman, reproduced failures, reviewed browser and backend logs, recorded the Jira issues, checked expected versus actual behavior, and verified the fixes. I used AI assistance for coding support, test-structure suggestions, and document formatting, but I reviewed the output and performed the validation myself.

This answer is important. Do not claim that you independently wrote every production or test line if that is not true.

## Explain STLC using this project

1. **Requirement analysis:** identified business and UI rules for customers, sales, returns, stock, purchases, and payments.
2. **Test planning:** selected functional, negative, boundary, responsive, regression, and API coverage.
3. **Test design:** wrote cases with preconditions, data, steps, expected results, actual results, and status.
4. **Environment setup:** used Flutter tests, Chrome, a local FastAPI server, local database data, Postman, and Jira.
5. **Execution:** ran focused tests first, then related regressions, complete analysis, and the full suite.
6. **Defect management:** documented reproducible issues with severity, priority, logs, and expected versus actual behavior.
7. **Retesting and closure:** reran the failing scenario, related suites, and manual verification before moving Jira issues to Done.

## What is a good test case?

A good test case has:

- A unique ID
- Clear scenario or objective
- Preconditions
- Test data
- Reproducible steps
- Expected result
- Actual result
- Pass/fail/blocked status
- Evidence or linked defect

## Severity versus priority

- **Severity** describes impact on the product or user.
- **Priority** describes how urgently the team should fix it.

Example: BGQA-5 was High severity and P0 priority because the Supplier Ledger endpoint returned HTTP 500 and blocked an important payment workflow.

## Jira workflow explanation

> I used a simple Jira workflow: To Do, In Progress, Ready for QA, and Done. I recorded the environment, reproduction steps, expected and actual results, severity, and priority. After the fix was available, I moved the issue to Ready for QA, reran the focused and regression tests, and moved it to Done only when the retest passed.

## Critical defect example — BGQA-5

**Problem:** Supplier Ledger returned HTTP 500.

**Reproduction:** Call `GET /supplier-payment/supplier/3/ledger` with ledger data containing both offset-naive and offset-aware datetimes.

**Actual result:** Python raised `TypeError` while sorting the transactions.

**Expected result:** HTTP 200 with chronologically sorted ledger transactions.

**Root cause:** The sort compared incompatible datetime forms.

**Fix:** Normalize local comparison copies without changing the response datetime values.

**Retest:** The live endpoint returned 200; seven focused backend tests and the complete 78-test backend suite passed.

## UI defect example — BGQA-7

**Problem:** A Sale Return error SnackBar covered the fixed Confirm Return button.

**Risk:** The user could not immediately retry after a validation or backend failure.

**Fix:** Position the floating message above the fixed action while accounting for safe-area and keyboard insets.

**Retest:** Verified compact, desktop, and short keyboard-height layouts; selected quantities and reason text remained unchanged after failure.

## Boundary defect example — BGQA-4

**Problem:** A Stock card received a transient width near zero, leading to a negative calculated child width and a Flutter constraint exception.

**Fix:** Return a safe zero-size presentation for non-positive width and rebuild normally when width recovers.

**Retest:** Zero-width recovery and repeated bidirectional lazy scrolling passed.

## Postman explanation

> I used an environment so values such as `base_url`, IDs, username, password, and access token were not hardcoded into every request. The login request captured the bearer token into the environment. The collection then checked status codes and response structures. I also tested negative cases such as 401 without authentication, 404 for a missing customer, 422 for an invalid return payload, and 400 for a duplicate customer. A synthetic customer was created and deleted in the same local run.

## HTTP status codes tested

| Status | Meaning in this portfolio |
|---|---|
| 200 | Successful read or deletion response |
| 201 | Synthetic customer created |
| 400 | Duplicate phone or business validation failure |
| 401 | Protected endpoint called without authentication |
| 404 | Requested customer does not exist |
| 422 | Request schema or field relationship is invalid |

## Difference between retesting and regression

- **Retesting:** Run the exact failed scenario again to confirm the defect is fixed.
- **Regression testing:** Check related and existing workflows to ensure the fix did not break anything else.

In this project, each fix received a focused retest followed by relevant module tests and a complete test run.

## What would you improve next?

> I would add repeatable end-to-end browser automation for a few stable critical workflows, expand SQL validation for persisted financial records, and connect test cases to Jira through a test-management plugin if the team uses one. I would not automate unstable or low-value cases first.

## Questions you should ask the interviewer

- How are requirements and acceptance criteria documented?
- Which test-management and defect-tracking tools does the QA team use?
- What is the balance between manual, API, and automated testing in this role?
- How are releases and regression cycles organized?
- What would success look like for a QA trainee in the first three months?

## Practice method

1. Explain the project in 60 seconds.
2. Explain BGQA-5 in two minutes.
3. Explain BGQA-7 in one minute.
4. Define severity versus priority.
5. Explain 401, 404, 422, and 500.
6. Explain retesting versus regression.
7. Explain exactly what you did and where AI assistance was used.

