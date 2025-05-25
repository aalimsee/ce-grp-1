Instead, you must use the GitHub CLI's API interface to call the GitHub REST API directly.

✅ Correct Way: Add Collaborator Using GitHub CLI gh api
Here’s the working command using gh api:

bash
gh api \
  --method PUT \
  -H "Accept: application/vnd.github+json" \
  /repos/aalimsee/ce-grp-1-vpc/collaborators/Lukej-git \
  -f permission=push

🔑 Permission options:
pull – read
push – read/write
admin – full access
maintain – management rights without admin
triage – issue/PR management only

🧪 To verify collaborator was added:
bash
gh api /repos/aalimsee/ce-grp-1-vpc/collaborators
This lists all users with access.

📝 Notes
The collaborator will receive an invitation email to accept.

You must be repo owner or have admin rights.