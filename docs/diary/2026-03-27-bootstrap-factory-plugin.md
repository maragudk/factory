# Diary: Bootstrap the factory plugin marketplace

Set up the factory repo as a Claude Code plugin marketplace called `maragu` with a plugin called `factory`, containing skills, hooks, and a welcome message.

## Step 1: Research and brainstorm

### Prompt Context

**Verbatim prompt:** Read https://addyosmani.com/blog/code-agent-orchestra/ . I'd like build some Claude Code plugins in this repo. Let's brainstorm where we could start. I have an existing skills repo at ../skills, see that too. Ultrathink.
**Interpretation:** Research multi-agent orchestration patterns and figure out how to build Claude Code plugins in the factory repo.
**Inferred intent:** Markus wants to evolve the factory repo from an empty "how we build" placeholder into a real plugin distribution system.

### What I did
Read the blog post about agent orchestration (subagents, agent teams, Ralph Loop, quality gates). Explored the existing skills repo (27 skills, well-structured with SKILL.md frontmatter). Explored the superpowers plugin repo for reference. Read the official Claude Code plugin marketplace docs.

### Why
Needed to understand the plugin system mechanics before building anything.

### What worked
Parallel exploration of all three sources (blog, skills repo, superpowers) saved time. The Claude Code plugin docs at code.claude.com were comprehensive and authoritative.

### What didn't work
Initially looked at superpowers as the model for plugin structure, but the official docs turned out to be the better reference -- superpowers predates some of the current plugin system.

### What I learned
Claude Code has a full plugin marketplace system built in. A marketplace is just a `marketplace.json` in `.claude-plugin/`, and plugins are directories with a `plugin.json` manifest. The `source: "./"` pattern lets a repo be both marketplace and plugin.

### What was tricky
Nothing at this stage -- pure research.

### What warrants review
N/A

### Future work
The blog post's orchestration patterns (worktree lifecycle, quality gates, Ralph Loop) are candidates for future plugins.

## Step 2: Create the marketplace and plugin skeleton

### Prompt Context

**Verbatim prompt:** Actually, I'd like to start with creating a plugin that can be installed but actually does nothing, like https://github.com/obra/superpowers
**Interpretation:** Start with the simplest possible plugin to prove the pipeline works.
**Inferred intent:** Validate the end-to-end install flow before adding real content.

### What I did
Created `.claude-plugin/marketplace.json` (marketplace name: `maragu`) and `.claude-plugin/plugin.json` (plugin name: `factory`). The plugin source is `"./"` so the repo root is the plugin. Several naming iterations: started as `noop`/`allthethings`, settled on marketplace=`maragu`, plugin=`factory`.

### Why
Need the infrastructure before adding content.

### What worked
`claude plugin validate .` caught an invalid source path (`"noop"` needed to be `"./noop"`). The `pluginRoot` metadata field with relative sources worked after fixing the path format.

### What didn't work
First PR creation failed with a permissions error (`CreatePullRequest` GraphQL mutation). Turned out it just needed a retry -- the `gh pr create` command worked on the second attempt with identical arguments.

### What I learned
The marketplace name and plugin name are independent. Users install with `/plugin install <plugin>@<marketplace>`. Version bumps are required for the cached plugin to update from remote, but not when testing locally with `./`.

### What was tricky
The `source: "./"` pattern for a plugin at the repo root coexisting with the marketplace in the same `.claude-plugin/` directory -- both `marketplace.json` and `plugin.json` live there.

### What warrants review
The naming: marketplace=`maragu`, plugin=`factory`. Installation is `/plugin install factory@maragu`.

### Future work
N/A

## Step 3: Add skills from the skills repo

### Prompt Context

**Verbatim prompt:** Let's start with adding all skills from ../skills here. Use the `cp` -a command directly for all skills that are in the readme there
**Interpretation:** Copy all 20 skills from the skills repo into the factory plugin.
**Inferred intent:** Consolidate skills into the plugin so they're distributed via the marketplace.

### What I did
Ran `cp -a` for all 20 skill directories listed in the skills repo README into `/skills/`. Plus the existing `dad-joke` skill, that's 21 total. Validated with `claude plugin validate .`.

### Why
The plugin system distributes skills -- this is the core content.

### What worked
Straightforward copy. All skills validated. After a version bump and marketplace update, `/reload-plugins` showed `21 plugin skills loaded`.

### What didn't work
Initial install from remote showed 0 skills -- needed a version bump for the cache to update.

### What I learned
Version bumps are the cache-busting mechanism for remote marketplace installs.

### What was tricky
Nothing.

### What warrants review
Skills are copied, not symlinked. Changes in the skills repo won't automatically propagate. This is intentional for now.

### Future work
Consider whether skills should be submodules or symlinks for easier sync.

## Step 4: Add the session start welcome hook

### Prompt Context

**Verbatim prompt:** Let's build a session start hook that tells the agent (not sub-agents) to say "Welcome to the factory." as the first thing always.
**Interpretation:** Create a SessionStart hook that displays a welcome message.
**Inferred intent:** Give the plugin a visible identity when sessions start.

### What I did
Created `hooks/hooks.json` with a `SessionStart` hook (matcher: `startup`). Went through several iterations of the hook command:

1. `echo 'Say "Welcome to the factory."...'` -- model treated the injected instruction as a prompt injection and refused to follow it.
2. `echo '{"additionalContext": "..."}'` -- would have worked but switched approach.
3. `echo '{"systemMessage": "Welcome to the factory."}'` -- worked. Shows as a system message directly to the user.
4. Pulled into `hooks/scripts/session-start.sh` script, added AGENTS.md as `additionalContext` via `hookSpecificOutput`, and injected version number from `plugin.json`.

### Why
`systemMessage` displays directly to the user without model interpretation. `additionalContext` gives the model context about the user's preferences from AGENTS.md.

### What worked
The `systemMessage` JSON field bypasses the model entirely -- it's shown to the user as a system message. Combined with `hookSpecificOutput.additionalContext` for model context, this gives both user-visible and model-visible output.

### What didn't work
Plain text echo as an instruction to the model. The model interpreted `Say "Welcome to the factory."` as a potential prompt injection and refused to follow it. This is actually reasonable safety behavior, just not what we wanted.

### What I learned
- `systemMessage` in hook JSON output is displayed to the user directly, not interpreted by the model.
- `additionalContext` in `hookSpecificOutput` is injected into the model's context.
- `jq -Rs .` is the way to safely embed file content as a JSON string (raw input, slurp, output as escaped string).
- `${CLAUDE_PLUGIN_ROOT}` is the variable for referencing plugin paths in hook commands.

### What was tricky
The prompt injection refusal was unexpected and funny. The model's safety training worked against us here -- it saw an instruction in hook output telling it to "say X" and flagged it as suspicious.

### What warrants review
The `AGENTS.md` content is now injected via the plugin hook on every session start. This duplicates what's already in `CLAUDE.md` for the user. Check whether this causes redundancy or conflicts.

### Future work
- More hooks: quality gates on `TaskCompleted`, verification on `Stop`/`SubagentStop`
- The orchestration tooling from the blog post brainstorm
