---
name: address-code-review
description: Address code review feedback by walking through comments one at a time with the user. Use when the user has received code review comments — on a GitHub PR, in a document in the repo, or directly in conversation — and wants to work through them methodically. Also trigger when the user mentions "address review", "review comments", "PR feedback", or wants to respond to code review feedback.
---

# Address Code Review

Work through code review comments with the user, one comment at a time. Never present multiple comments at once.

## Input sources

Comments may come from:

1. **GitHub PR** - Fetch inline and general comments using `gh api`
2. **Document in the repo** - Parse whatever markdown structure is found
3. **Conversation** - Comments given directly by the user

## Process

### 1. Collect feedback

- **GitHub PR**: Use GraphQL to fetch all comments in one go. Fetch inline review comments via `pullRequest.reviewThreads` and general PR comments via `pullRequest.comments`. Skip already-resolved threads (`isResolved`). Still present outdated but unresolved comments (`isOutdated`), noting to the user that the code has changed since the comment was left.
- **Document**: Read the file and extract review items.
- **Conversation**: Use the comments as provided.

### 2. Triage one at a time

For each comment, strictly one at a time:

1. Present the comment to the user.
2. Share your own assessment: agree, disagree, or propose an alternative. Explain your reasoning briefly.
3. Wait for the user to decide what to do (apply, skip, modify, etc.).
4. Record the agreed-upon action. Do not apply code changes yet.

For GitHub PR inline comments: immediately reply to the comment on GitHub and resolve the thread after discussion.

### 3. Apply changes

After all comments have been discussed, apply all agreed-upon code changes in one batch.

For GitHub PR general comments (which may contain multiple issues in one comment): post a single summary reply after all issues in that comment are addressed.

For document sources: update the document with status/progress as appropriate.

## GitHub CLI reference

| Action | Command |
|---|---|
| Fetch all comments | GraphQL query on `pullRequest.reviewThreads` (inline) and `pullRequest.comments` (general) |
| Reply to inline comment | `gh api repos/{owner}/{repo}/pulls/{pr}/comments/{id}/replies -X POST -f body="..."` |
| Reply to general comment | `gh api repos/{owner}/{repo}/issues/{pr}/comments -X POST -f body="..."` |
| Resolve a thread | GraphQL mutation `resolveReviewThread(input: {threadId: "..."})` |
