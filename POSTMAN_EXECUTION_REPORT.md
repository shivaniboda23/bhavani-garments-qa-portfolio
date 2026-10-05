# Postman API Test Execution Report

## Project

- Application: Bhavani Garments ERP
- Backend: FastAPI
- Execution date: 2026-10-03
- Tool: Postman Desktop Collection Runner
- Environment: Bhavani Garments - Local QA
- Iterations: 1
- Base URL: local loopback environment

## Result summary

| Metric | Result |
|---|---:|
| Requests | 16 |
| Assertions | 31 |
| Passed | 31 |
| Failed | 0 |
| Skipped | 0 |
| Errors | 0 |
| Duration | 3.813 seconds |
| Average response time | 50 ms |

Overall result: **Pass**

## Coverage

| Area | Scenarios | Status codes |
|---|---|---|
| Health | Service availability and API identity | 200 |
| Authentication | Valid login, bearer-token capture, and protected request without a token | 200, 401 |
| Customers | List, existing record, missing record, create, duplicate validation, and deletion | 200, 201, 400, 404 |
| Products | List and search | 200 |
| Dashboard | Summary response | 200 |
| Sales | Sale-detail response and requested ID | 200 |
| Supplier Payments | Summary and ledger regression | 200 |
| Sale Return | Invalid quantity split rejected during schema validation | 422 |

## Controlled mutation workflow

The final folder ran only against the local development database:

1. Created one synthetic customer and received HTTP 201.
2. Reused the generated phone to verify HTTP 400 duplicate validation.
3. Deleted the captured synthetic customer and received HTTP 200.

The Collection Runner evidence confirms cleanup completed. No synthetic customer was intentionally left behind.

## Security and data handling

- The portfolio environment stores no username, password, bearer token, temporary customer ID, or synthetic customer phone.
- The 401 request explicitly uses **No Auth** and does not send a bearer token.
- Credentials were entered only in the local Postman environment and cleared after execution.
- The backend was stopped after testing.
- Runner result exports were not included because persisted responses could expose tokens or local data. Redacted-safe screenshots are used instead.

## Evidence

- `evidence/postman-run-summary.png`: Collection Runner summary showing 31 passed assertions and zero errors.
- `evidence/postman-cleanup-proof.png`: Final create, duplicate-validation, and delete requests showing the cleanup path.
- `Bhavani_Garments_QA_Portfolio.xlsx`: Detailed API Coverage and API Run sheets.

## Limitations

- Testing used a local development environment, not production.
- This was functional API contract testing, not load, performance, penetration, or comprehensive security testing.
- Database state and example IDs are specific to the local environment.
- The evidence supports hands-on Postman experience, not professional API automation specialization.

## Interview summary

> I configured a Postman environment with reusable variables, captured the bearer token after login, and wrote response assertions for positive and negative API contracts. I executed 16 requests through the Collection Runner and all 31 assertions passed. The run covered 200, 201, 400, 401, 404, and 422 responses. For the controlled CRUD test, I created one synthetic customer, verified duplicate validation, and deleted the test record in the same run. I cleared credentials and tokens after testing.
