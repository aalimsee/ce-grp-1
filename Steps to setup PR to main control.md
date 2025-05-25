To enforce pull request control to the main branch, you’ll use GitHub Branch Protection Rules. This ensures:

✅ No direct push to main
✅ All changes must go through a PR
✅ Optional: Require approvals, status checks (e.g., Terraform Plan, Snyk), etc.

✅ Step-by-Step: Set PR Control for main Branch
🔒 Step 1: Go to Branch Protection Settings
Open your repo: ce-grp-1-vpc on GitHub

Click Settings → Branches

Under Branch protection rules, click “Add rule”

⚙️ Step 2: Configure Rule for main
Branch name pattern: main

Enable these options:

✅ Require a pull request before merging
✅ Require approvals

Set: 1 approval required (or more, depending on your team)
✅ Require status checks to pass before merging

Check relevant GitHub Actions (e.g. Terraform VPC, Snyk IaC Scan)
✅ (Optional) Require linear history
✅ (Optional) Include administrators (for stricter control)

🧪 Step 3: Test It
Try pushing directly to main:

bash
git checkout main
touch test.txt
git add test.txt
git commit -m "testing direct push"
git push origin main
✅ You should get a “permission denied” error.

Push to dev, open PR → get approval → merge

🔁 Bonus: Prevent Merge Without Review
To enforce even tighter control:

✅ Enable Dismiss stale pull request approvals

✅ Enable Require review from Code Owners (if you use CODEOWNERS)