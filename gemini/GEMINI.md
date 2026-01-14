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
- **Phase Completion:** Before concluding a phase, always propose a Manual Verification Plan specifically for the user to review the logical consistency and vocabulary of the outputted documents.

### 3.2 Session Startup Protocol

**Trigger:** Execute this protocol silently at the very beginning of every new session.

1.  **Context Detection:** Check if the current directory contains a `.conductor/tracks.md` file.
2.  **Conditional Prompt:**
    - **If Conductor is NOT detected:** Proceed silently to await user input.
    - **If Conductor IS detected:** You must IMMEDIATELY output a specific prompt to the user before doing anything else.
      - **Prompt Text:** "Conductor detected. Generate Project Status Report? (Press Enter for Yes, or type 'skip')"
3.  **Interaction Handling:**
    - **If the user presses Enter (sends empty input) OR replies "yes"/"y":** Execute the **Status Overview Protocol** immediately.
    - **If the user replies "skip", "no", or provides a different instruction:** Abort the status report and proceed with the user's request.

### 3.3 Status Overview Protocol

**Trigger:** Executed when the user confirms the startup prompt or explicitly asks for a "status report" in a Conductor project.

1.  **Read State:**
    - Read `.conductor/tracks.md` to list active tracks.
    - Read `plan.md` for every active track found in `.conductor/tracks/`.
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
