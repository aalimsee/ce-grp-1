Here’s how to securely set up your AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY as GitHub Secrets so your GitHub Actions can authenticate with AWS.

# ✅ Step-by-Step: Configure AWS Credentials as GitHub Secrets
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


# Step-by-Step: Set GitHub Secrets via CLI
🔁 Step 1: Install GitHub CLI (if not already installed)

macOS (Homebrew):
bash
brew install gh

Ubuntu/Debian:
bash
sudo apt install gh

Windows (winget):
bash
winget install --id GitHub.cli

✅ Step 2: Authenticate GitHub CLI
bash
gh auth login

Choose:
GitHub.com
HTTPS
Authenticate in browser

✅ Step 3: Set AWS Secrets in Your Repository
Replace <your-value> with actual access/secret key values.

bash
# Navigate to your repo directory
cd ce-grp-1-vpc

# Set AWS Access Key ID
gh secret set AWS_ACCESS_KEY_ID -b"<your-access-key-id>"

# Set AWS Secret Access Key
gh secret set AWS_SECRET_ACCESS_KEY -b"<your-secret-access-key>"
🔐 -b stands for "body" and securely passes the secret value.

✅ Example
bash
gh secret set AWS_ACCESS_KEY_ID -b"AKIAIOSFODNN7EXAMPLE"
gh secret set AWS_SECRET_ACCESS_KEY -b"wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"

✅ Confirm They’re Set
bash
gh secret list
You should see:

plaintext
AWS_ACCESS_KEY_ID       Repository
AWS_SECRET_ACCESS_KEY   Repository
