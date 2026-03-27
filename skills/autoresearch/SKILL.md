---
name: autoresearch
description: Autonomous experiment loop that iteratively improves a measurable metric. Given a goal, a verify command, and an optional guard, the agent branches, makes one change, measures the result, and keeps or discards the experiment -- repeating indefinitely. Use this skill when the user wants to optimize something measurable through automated experimentation, autonomous improvement loops, or when they mention "autoresearch". Works for any domain with a quantifiable metric (code performance, ML training, build size, test scores, content quality metrics, etc.).
license: MIT
---

# Autoresearch

An autonomous experiment loop. You make a change, measure it, keep it if it's better, discard it if it's not, and repeat. The idea is simple: given a clear metric and a way to measure it, you can run experiments indefinitely while the user sleeps, eats, or touches grass.

This works for anything with a measurable outcome: code performance, ML model quality, bundle size, test coverage, response latency -- if you can extract a number from a command, you can optimize it.

## How it works

There are two phases: **plan** (interactive setup with the user) and **loop** (autonomous experimentation).

## Phase 1: Plan

Before the loop starts, gather the configuration through a short conversation. Ask these questions one at a time, waiting for the user's answer before proceeding.

### 1. Goal

Ask: "What are you trying to optimize?"

This is a free-text description of the objective. Examples: "Reduce API p95 response time", "Lower validation loss on the language model", "Minimize Docker image size".

### 2. Verify command

Ask: "What command should I run to measure the metric? The output should contain the metric value as a number."

This is a shell command whose output contains the metric. Examples:
- `npm run bench | grep "p95"`
- `uv run train.py 2>&1 | grep "val_bpb"`
- `du -sh dist/ | awk '{print $1}'`

### 3. Metric direction

Based on the goal description, infer whether lower or higher is better, then confirm with the user. For example: "From your goal, I'm assuming lower is better -- is that right?"

### 4. Guard command (optional)

Ask: "Is there a command that must always pass? For example, a test suite. Leave blank if not needed."

A guard is a safety net: a command that must exit with code 0 for an experiment to be kept. The guard prevents the optimization from breaking things. For example, if you're optimizing response time, `npm test` as a guard ensures you don't accidentally break functionality in the process.

### 5. Scope (optional)

Ask: "Do you want to restrict which files I can modify, or is everything fair game?"

If the user provides a list of files or directories, only modify those. If they say everything is fair game, use your judgment based on the goal.

### 6. Set up the autoresearch branch

Create and push a dedicated `autoresearch` branch from the current branch (typically main). All experimentation happens on or from this branch -- main stays clean.

```
git checkout -b autoresearch
git push -u origin autoresearch
```

### 7. Dry run

Before starting the loop, run both the verify command and the guard command (if set) once. Confirm that:
- The verify command succeeds and you can extract a numeric metric from its output
- The guard command succeeds (exit code 0)

If either fails, ask the user to fix the command before proceeding. This catches misconfigurations before the loop wastes time on them.

Record the metric value from the dry run as the **baseline**.

## Phase 2: Loop

Once the plan is confirmed, the loop runs autonomously. Never stop. Never ask. Each iteration follows these steps:

### 1. Review

Read the current state to inform your next experiment:
- The in-scope files (or the relevant project files if no scope was set)
- The results log (`autoresearch-results.tsv`) to see what's been tried
- The experiment branches (`git branch -a | grep autoresearch-`) to recall past attempts

This is your memory. The TSV tells you what worked and what didn't. The branches tell you what approaches have been explored. Use this to avoid repeating failed ideas and to build on successful ones.

### 2. Ideate

Pick one idea to try. Favor approaches that:
- Haven't been tried before (check the TSV and branch names)
- Build on changes that previously improved the metric
- Are meaningfully different from recent failed attempts

When stuck, don't just make tiny variations of the same idea. Try something radically different -- a different algorithm, a different data structure, a completely different approach to the problem.

### 3. Branch

Create a new branch from the `autoresearch` branch with a descriptive name:
```
autoresearch-<short-description>
```
Examples: `autoresearch-increase-batch-size`, `autoresearch-inline-hot-path`, `autoresearch-switch-to-radix-sort`

### 4. Modify

Make one atomic change. One idea, one experiment. Keep changes small and focused so the metric delta is clearly attributable to the change. If equal results can be achieved with less code, prefer the simpler version.

Respect the scope if one was defined. Never modify the guard command's test files or the verify command's evaluation harness -- the measurement infrastructure is sacred.

### 5. Commit and push

Commit with a descriptive message and push the branch:
```
git add <specific files>
git commit -m "autoresearch: <description of the change>"
git push -u origin autoresearch-<short-description>
```

### 6. Verify

Run the verify command and extract the metric value from the output. If the command crashes or fails, read the error output, note it in the log, and treat it as a failed experiment.

### 7. Guard (if configured)

Run the guard command. It either passes (exit code 0) or fails. Only run this if a guard was configured.

### 8. Decide

Compare the metric to the current best (starting from the baseline established in the dry run):

- **Metric improved AND guard passed** (or no guard): check out the `autoresearch` branch, merge the experiment branch, and push `autoresearch`. This is now the new baseline.
- **Metric did not improve, OR guard failed**: check out the `autoresearch` branch. Leave the experiment branch as-is -- it serves as a record of what was tried.

### 9. Log

Append a row to `autoresearch-results.tsv` in the project root. Create the file with headers on the first iteration if it doesn't exist.

Columns:
```
iteration	branch	metric	delta	guard	status	description
```

- **iteration**: sequential number starting at 1
- **branch**: the experiment branch name
- **metric**: the extracted metric value
- **delta**: change from the current best metric (e.g., `-0.03` or `+12.5`)
- **guard**: `pass`, `fail`, or `-` (no guard configured)
- **status**: `kept` (merged to `autoresearch`) or `discarded` (branch left as-is)
- **description**: one-line summary of what the experiment tried

Commit and push this file to the `autoresearch` branch after each iteration so the log is always up to date.

### 10. Repeat

Go back to step 1. Do not stop. Do not ask for confirmation. Keep running experiments until the user interrupts.
