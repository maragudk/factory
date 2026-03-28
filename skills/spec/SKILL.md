---
name: spec
description: Write and iterate on a project spec (docs/spec.md) that defines what the product is and should be. Use this skill when the user asks to create or update a spec, says "let's spec this out", or when a product decision comes up in conversation that should be captured in the spec. Also use proactively when the user is about to start building something that doesn't have a spec yet.
license: MIT
---

# Spec

The spec is the living product document. It defines _what_ to build. It complements CLAUDE.md, which defines _how_ to work.

The spec lives at `docs/spec.md`. Create the `docs/` directory if it doesn't exist.

## When to use this skill

- The user explicitly asks to create or update a spec.
- A product decision comes up in conversation that should be captured. In this case, nudge: "This sounds like it belongs in the spec. Want me to add it to docs/spec.md?" If the user says no, move on.

## Creating a new spec

Follow the brainstorm pattern: one question at a time, multiple choice where possible.

### Flow

1. Start with the project-specific sections that need real conversation:
   - **Objective**: What is this project? Who is it for? What problem does it solve?
   - **Boundaries**: What should agents and contributors never touch?

2. For sections with known defaults, propose them for confirmation rather than asking from scratch:
   - **Tech stack**: Go, SQLite/Postgres, server-side HTML with gomponents and Datastar.
   - **Project structure**: Standard Go project layout as described in the Go skill.
   - **Commands**: `go build`, `go test`, `go run .`, etc.
   - **Code style**: Conventions from the Go skill.
   - **Testing**: Go testing patterns from the Go skill.
   - **Git workflow**: Conventions from the git skill.

   Present each as a proposal: "For tech stack, I'll go with your usual defaults — Go, SQLite, gomponents, Datastar. Any changes for this project?" One section per message.

3. Once all sections are covered, write the spec section by section (200-300 words each), asking for approval after each before moving to the next.

4. Assemble approved sections into `docs/spec.md`.

## Updating an existing spec

1. Read `docs/spec.md` first.
2. Ask what the user wants to change or add.
3. Walk through just the affected sections with the same propose-and-confirm cadence.
4. Show the changes for approval before writing.

## Proactive nudge

When a product decision comes up during other work (implementation, brainstorm, etc.), suggest capturing it in the spec. If the user agrees, read the existing spec, propose where the decision fits, and show the update for approval.

## Spec structure

The spec always has these sections in this order:

```markdown
# [Project Name]

## Objective
What the project is, who it's for, why it exists.

## Tech Stack
Languages, frameworks, databases, infrastructure.

## Project Structure
Directory layout and where things live.

## Commands
Full executable commands for build, test, lint, run, deploy.

## Code Style
Naming conventions, formatting, patterns.

## Testing
Framework, where tests live, how to run them.

## Git Workflow
Branch naming, commit format, PR process.

## Boundaries
What agents and contributors should never touch.
```

## Writing guidelines

- Be concise and specific. The spec is a reference document, not prose.
- Use concrete values, not vague descriptions. "SQLite for local development, Postgres for production" not "a relational database".
- Commands should be copy-pasteable. Include flags and arguments.
- Boundaries should be explicit. Name specific files, directories, or patterns.
