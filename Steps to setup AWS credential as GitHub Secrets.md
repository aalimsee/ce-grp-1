Here’s how to securely set up your AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY as GitHub Secrets so your GitHub Actions can authenticate with AWS.

✅ Step-by-Step: Configure AWS Credentials as GitHub Secrets
✅ Step 1: Create an IAM User with Programmatic Access
Go to AWS Console → IAM → Users

Click “Add users”

Set user name: ce-grp-1-gh-actions

Select Access type: ✅ Programmatic access

Click Next

✅ Step 2: Attach Permissions (Recommended: least privilege)
To start, you can use this managed policy:

✅ Attach existing policies directly

Select: AdministratorAccess (for bootstrapping — replace with tighter roles later)

🔐 Tip: Later replace with scoped policy using terraform:*, eks:*, vpc:*, etc.

✅ Step 3: Download Access Key and Secret
Click Create user

Download the .csv file or copy:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

✅ Step 4: Add Secrets to GitHub
Go to your repo → ce-grp-1-vpc

Click Settings → Secrets → Actions

Click “New repository secret”

Add each of the following:

🔐 Secret #1: AWS_ACCESS_KEY_ID
Name: AWS_ACCESS_KEY_ID

Value: (paste from IAM)

🔐 Secret #2: AWS_SECRET_ACCESS_KEY
Name: AWS_SECRET_ACCESS_KEY

Value: (paste from IAM)

✅ Step 5: Verify in GitHub Actions Workflow
Make sure your GitHub Actions .yml uses the secrets like this:

yaml

- name: Configure AWS Credentials
  uses: aws-actions/configure-aws-credentials@v2
  with:
    aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
    aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    aws-region: us-east-1
✅ Final Check
Push to dev branch to trigger the workflow

Visit Actions tab and confirm steps run successfully:

Configure AWS Credentials

Terraform Init, etc.

