# GitHub Publishing Guide

Use this guide to publish the QA portfolio once, safely and cleanly.

## Recommended repository

- Repository name: `bhavani-garments-qa-portfolio`
- Visibility: Public
- Description: `Manual, responsive, regression and API testing portfolio for a Flutter and FastAPI retail ERP.`
- Suggested topics: `qa`, `manual-testing`, `postman`, `jira`, `api-testing`, `flutter`, `fastapi`, `test-cases`, `stlc`

## Before publishing

Confirm that the folder contains only:

- `README.md`
- `Bhavani_Garments_QA_Portfolio.xlsx`
- `Bhavani_Garments_API.postman_collection.json`
- `Bhavani_Garments_Local.postman_environment.json`
- `POSTMAN_EXECUTION_REPORT.md`
- `INTERVIEW_GUIDE.md`
- `RESUME_UPDATES.md`
- `QA_READINESS_CHECKLIST.md`
- `GITHUB_UPLOAD_GUIDE.md`
- `.gitignore`
- `evidence/postman-run-summary.png`
- `evidence/postman-cleanup-proof.png`

Do not upload browser logs, server traces, database dumps, `.env` files, passwords, access tokens, private customer data, build scripts, inspection files, or temporary previews.

The supplied Postman environment is sanitized. Keep these values empty before every public push:

- `username`
- `password`
- `access_token`
- `qa_customer_phone`
- `created_customer_id`

## Option A — GitHub website

1. Sign in to GitHub.
2. Select **New repository**.
3. Enter `bhavani-garments-qa-portfolio`.
4. Add the description shown above.
5. Select **Public**.
6. Do not create another README, `.gitignore`, or license during repository creation.
7. Select **Create repository**.
8. Choose **uploading an existing file**.
9. Extract the supplied portfolio ZIP on your computer.
10. Drag every file and the `evidence` folder from the extracted package into GitHub.
11. Use commit message: `docs: publish Bhavani Garments QA portfolio`.
12. Select **Commit changes**.
13. Open the repository in a private/incognito browser window and verify that the README and evidence images load.

## Option B — PowerShell and Git

Replace the first path with the folder where you extracted the package.

```powershell
cd "C:\Users\SHIVANI\Downloads\bhavani-garments-qa-portfolio"

git init
git add .
git status --short
git commit -m "docs: publish Bhavani Garments QA portfolio"
git branch -M main
git remote add origin https://github.com/shivaniboda23/bhavani-garments-qa-portfolio.git
git push -u origin main
```

If `git remote add origin` says the remote already exists, inspect it before changing anything:

```powershell
git remote -v
```

Do not use force push.

## After publishing

1. Add the repository link to the Bhavani Garments project in the resume.
2. Add the link to LinkedIn **Featured**.
3. Pin the repository on the GitHub profile.
4. Open the workbook from the repository and confirm it downloads correctly.
5. Import the public Postman files once to confirm they remain usable without saved credentials.

## Future updates

Add only genuine evidence. Do not invent defects or inflate test counts. When adding a result, record the date, environment, expected result, actual result, and evidence.
