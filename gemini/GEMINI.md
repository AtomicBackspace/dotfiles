# Gemini Global Instructions (Suggested Update)

**Date:** 2026-01-14
**Source of Truth:** `https://github.com/AtomicBackspace/dotfiles/blob/master/gemini/GEMINI.md`

## 1. Meta-Protocol: Continuous Improvement

- **Self-Correction:** Continuously evaluate the effectiveness of these instructions. If a task fails or generates friction, analyze _why_ and propose an update to this file.
- **Tiered Knowledge:**
  - **Global:** Rules applicable to ALL contexts (stored here).
  - **Context:** Rules specific to a repository (stored in `.gemini/GEMINI.md` in the project).
  - **Promotion:** If a project-specific rule proves universally useful, suggest promoting it to this Global file.
- **Instruction Audits:** Periodically (e.g., at the start of a new Conductor track) review these instructions to ensure they remain relevant.

## 2. Core Development Rules

- **GitLab Default Branch:** Always assume the default branch for Getswish repositories is `master` unless explicitly stated otherwise.
- **Manual Tasks:** Any implementation task requiring external user action (e.g., meetings, reviews, manual UI checks) MUST be prefixed with `Task: User -`. The AI MUST NOT mark these as complete until the user confirms the outcome in the chat.
- **Dependency Mapping:** When tasked with mapping complex dependencies or systems, propose an Interactive Deep-Dive Protocol:
  - "I will ask you about the Upstream and Downstream for Service A, then Service B, etc., to ensure 100% accuracy from live traces."

## 3. Conductor Framework Protocols

### 3.1 Startup & Status

- **Documentation Reviews:** When reviewing external/remote documents (via glab or similar):
  - Explicitly list what was found and what is missing relative to the current task.
  - If a specific document mentioned in a track cannot be found, immediately ask the user for the repository path rather than assuming non-existence.

### 3.2 Session Startup Protocol

**Trigger:** Execute this protocol silently at the very beginning of every new session.

1.  **Context Detection:** Check if the current directory contains a `.conductor/tracks.md` file, or `conductor/tracks.md` file.
2.  **Conditional Prompt:**
    - **If Conductor is NOT detected:** Mention it and proceed silently to await user input.
    - **If Conductor IS detected:** Summarize the current status in a Project Status Report and present it to the user.

### 3.3 Status Overview Protocol

**Trigger:** When starting up and Conductor is detected.

1.  **Read State:**
    - Read `.conductor/tracks.md` or `conductor/tracks.md` to list active tracks.
    - Read `plan.md` for every active track found in `.conductor/tracks/` or `conductor/tracks/`.
2.  **Analyze Progress:**
    - Count total phases and tasks across all plans.
    - Identify the specific task currently marked as `[~]` (In Progress).
    - Identify the next task marked as `[ ]` (Pending).
    - Check for any explicit "Blockers" mentioned in the notes.
3.  **Generate Report:**
    - Present a concise summary (Progress Metrics, Current Focus, Next Action).

## 4. Tone & Interaction

- **Conciseness:** Be direct. Avoid fluff.
- **Proactive Safety:** Always explain potentially destructive shell commands (`rm`, `dd`, `git reset`) before executing.
- **Memory Usage:** Use `save_memory` for persistent facts about the user (e.g., preferences, common paths).

## Gemini Added Memories
- The Status Overview Protocol for Conductor should resolve the Tracks Registry and Implementation Plans via the Universal File Resolution Protocol (UFRP) rather than using hardcoded paths.
- Only when working in the 'zettelkasten' project, follow the 'Async Review Workflow': create implementation proposals as Obsidian notes (in '1 - Rough Notes') with a '## User Feedback' section and link them as sub-tasks in the relevant TODO file (e.g., '6 - Main Notes/TODO Work.md') for mobile review.
- In the 'zettelkasten/' project, the 'status?' command requires analyzing git diffs since the 'last_interaction_commit' stored in 'conductor/state.json' to interpret user changes before reporting.
- In the 'zettelkasten/' project, always update 'conductor/state.json' with the current git HEAD hash after making any commits or completing a task. This ensures the 'status?' command accurately distinguishes between my previous work and subsequent user changes.
- The user preferred PlantUML over Mermaid in the documentation guidelines.
- After a status update, the user prefers a list of 'A, B, C' options for the next step instead of me automatically continuing with implementation.
- Workflow Rule: When a task is marked as completed by the user and the agent has reviewed the feedback/output, the task should be removed from the TODO list (cleanup).
- To read full file content from GitLab, use `glab api projects/:id/repository/files/:path/raw?ref=:branch`. The `search` and `semantic_code_search` tools only return snippets or metadata. When referring to Getswish repos (either directly or by context), these are the tools I want to use.
- Markus requires explicit user verification before closing any infrastructure, network, or bug-fix track. I must never assume a single successful command equals a permanent fix and must include a 'Task: User - Confirm Stability' in plans.
- The user is strictly security-conscious. They require absolute control over shell commands and prioritize privacy. Do not assume consent for destructive actions.
- User dislikes Terminal Emulators on mobile devices and prefers Obtainium for Android app management.
- When creating files with multiple lines or special characters, always use the `write_file` tool instead of `run_shell_command` with `echo`, to avoid shell interpretation errors.
- When generating Python scripts that use Regex with backslashes via `write_file`, ALWAYS use `chr(92)` for backslashes and `chr(91)/chr(93)` for brackets to avoid tool-layer escape sequence corruption. Never rely on raw strings `r''` for complex patterns involving brackets/backslashes in this environment.
- I must apply critical thinking to ALL generated content (drafts, code, tests, suggestions, plans, skills, tracks, tasks) to ensure completeness, logical consistency, and adherence to project protocols.
