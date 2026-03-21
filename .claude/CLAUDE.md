# Global Claude Instructions

These rules apply to every project. Project-level CLAUDE.md files add specifics.

---

## Non-Negotiables

IMPORTANT: These rules override all other guidance.

- NEVER apply quick fixes or workarounds. Always diagnose to the root cause. Only patch if I explicitly ask for one.
- NEVER hardcode secrets or commit them to git. Use environment variables or a secrets manager.
- NEVER add features, abstractions, error handling, or refactors I did not ask for. Do exactly what was requested.
- NEVER summarize what you just did at the end of a response. I can read the diff. Be concise.
- NEVER skip running tests. If tests fail, fix them before moving on.

---

## How to Work With Me

- Ask clarifying questions before implementing ambiguous requirements — don't assume intent
- Challenge my ideas if there's a better approach. "Have you considered X?" is always welcome
- If a task touches more than 3 files, outline the plan and check in before writing code
- On clear, scoped tasks: just do it. Don't ask permission for obvious next steps
- When making changes, explain the *why* not just the *what*
- Flag concerns early rather than waiting until they become problems
- On PR reviews: be direct, cite specifics, suggest fixes — not "this could be improved"

---

## Code Quality

- Keep it simple. Three similar lines are better than a premature abstraction
- Extract shared logic on the third repetition, not the second
- No dead code in main branches — delete it or put it behind a feature flag
- Don't add libraries for things the standard library handles
- Fix hacky code now or create a tracked issue — "later" never comes

---

## Security

- Validate all input server-side — never trust client data
- Sanitize user input before it touches database queries or rendered output
- Default to least-privilege for service accounts and API keys
- Separate credentials for dev, staging, and prod
- Rate limiting on auth and write operations

---

## Testing

IMPORTANT: E2E tests are the priority. Write them first for any feature or endpoint.

- Unit tests for complex business logic only — don't unit test trivial code
- Test unhappy paths: network failures, malformed data, empty states, unexpected API responses
- If a bug is found, write a regression test before fixing it
- Test behavior, not implementation details

---

## Git & CI/CD

- Commit messages: imperative mood, <72 char subject, body explains *why* when the diff doesn't make it obvious
- Feature branches off main. PRs with review before merging
- CI/CD pipeline handles deployments — never deploy from a laptop
- E2E tests must pass in CI before merge

---

## Standards

- Store all timestamps in UTC. Convert to local time only at the display layer. ISO 8601 for serialization.
- Keep the README current — update setup steps in the same PR that changes them
- Document non-obvious design decisions close to the code
- If something took more than 10 minutes to figure out, write it down

---

## Environment

- Platform: WSL2 + VS Code + bash
