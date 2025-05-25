✅ Do you need to manually add the project to Snyk via the web UI?
Short answer:
➡️ No — not required when you're using Snyk CLI in CI/CD (like with GitHub Actions).

🔍 Why?
When you use snyk iac test (like in your Actions workflow), Snyk:

Runs the scan on the fly

Does NOT automatically create a project in the Snyk web UI

The results show in the GitHub Actions log, not in the Snyk dashboard (unless explicitly uploaded)

✅ When do projects show up in the Snyk web console?
Projects appear when:

Method	Result
Snyk GitHub App integration	✅ Project is tracked in UI
Snyk CLI test (in CI)	❌ No project in UI
Snyk CLI monitor	✅ Creates project in UI

✅ If You Want It to Show in Snyk Web UI
You can explicitly run this in your workflow:

bash
snyk iac test --org=aalimsee         # runs inline
snyk iac monitor --org=aalimsee      # uploads snapshot to Snyk Projects
monitor will register the scan and create a new project in your Snyk dashboard.

🧠 Summary
| Do you need to add project manually in web UI? | ❌ No for snyk iac test |
| Will it show in Snyk console? | ❌ Not unless you use monitor |
| Want to see history in Snyk UI? | ✅ Add snyk iac monitor |