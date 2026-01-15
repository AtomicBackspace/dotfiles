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
