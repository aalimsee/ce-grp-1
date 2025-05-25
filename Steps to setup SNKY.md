# Step-by-Step: Add Snyk to terraform-vpc.yml
## Step 1: Add a SNYK_TOKEN to GitHub Secrets
Go to: https://app.snyk.io/account
Copy your API token

In your GitHub repo:
Navigate to Settings → Secrets → Actions

Click New repository secret

Add:
Name: SNYK_TOKEN
Value: (paste token)

# Step 2: Update Workflow — .github/workflows/terraform-vpc.yml
Add this Snyk job step to your existing jobs.terraform.steps array after terraform validate and before terraform plan:

yaml
```
      - name: Snyk IaC Scan
        uses: snyk/actions/iac@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
        with:
          args: "--file=main.tf --severity-threshold=medium"
```

You can also run it on the whole folder like this (preferred):

yaml
```
      - name: Snyk IaC Scan
        uses: snyk/actions/iac@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
        with:
          args: "--severity-threshold=medium"
```

🔁 Final Sample Block (inside your steps:)
yaml
```
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v3

      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ env.AWS_REGION }}

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2
        with:
          terraform_version: 1.6.6

      - name: Terraform Init
        run: terraform init

      - name: Terraform Format Check
        run: terraform fmt -check

      - name: Terraform Validate
        run: terraform validate

      - name: Snyk IaC Scan
        uses: snyk/actions/iac@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
        with:
          args: "--severity-threshold=medium"

      - name: Terraform Plan
        run: terraform plan -input=false
```
✅ Results
Snyk will now run on every push to dev and PR to main
Vulnerabilities or misconfigurations will appear in the Actions logs
You can enforce fail-on-issues by adding --fail-on=all in args

