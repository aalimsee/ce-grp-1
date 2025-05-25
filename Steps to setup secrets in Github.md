To set up GitHub Secrets from the command line, you can use the GitHub CLI tool: gh

✅ Step-by-Step: Set GitHub Secrets via CLI
🔁 Step 1: Install GitHub CLI (if not already installed)
macOS (Homebrew):

```brew install gh```

Ubuntu/Debian:
```sudo apt install gh```

Windows (winget):

```winget install --id GitHub.cli```

✅ Step 2: Authenticate GitHub CLI
```gh auth login```
Choose
GitHub.com
HTTPS
Authenticate in browser

✅ Step 3: Set AWS Secrets in Your Repository
Replace <your-value> with actual access/secret key values.

# Navigate to your repo directory
cd ce-grp-1-vpc

# Set AWS Access Key ID
gh secret set AWS_ACCESS_KEY_ID -b"<your-access-key-id>"

# Set AWS Secret Access Key
gh secret set AWS_SECRET_ACCESS_KEY -b"<your-secret-access-key>"
🔐 -b stands for "body" and securely passes the secret value.

✅ Example
```
gh secret set AWS_ACCESS_KEY_ID -b"AKIAIOSFODNN7EXAMPLE"
gh secret set AWS_SECRET_ACCESS_KEY -b"wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
```
✅ Confirm They’re Set
```gh secret list```

You should see:

```AWS_ACCESS_KEY_ID       Repository
AWS_SECRET_ACCESS_KEY   Repository```
✅ Once that’s done, push to your dev branch and GitHub Actions will securely use those credentials.