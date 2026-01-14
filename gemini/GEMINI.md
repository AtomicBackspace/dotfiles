1. General Development Rules

- GitLab Default Branch: Always assume the default branch for Getswish repositories is `master` unless explicitly stated otherwise.
- Manual Tasks: Any implementation task requiring external user action (e.g., meetings, reviews, manual UI checks) MUST be prefixed with `Task: User -`. The AI MUST NOT mark these as complete until the user confirms the outcome in the chat.
- Dependency Mapping: When tasked with mapping complex dependencies or systems, propose an Interactive Deep-Dive Protocol:
  - "I will ask you about the Upstream and Downstream for Service A, then Service B, etc., to ensure 100% accuracy from live traces."

2. Conductor Framework Protocols

- Documentation Reviews: When reviewing external/remote documents (via glab or similar):
  - Explicitly list what was found and what is missing relative to the current task.
  - If a specific document mentioned in a track cannot be found, immediately ask the user for the repository path rather than assuming non-existence.
- Phase Completion: Before concluding a phase, always propose a Manual Verification Plan specifically for the user to review the logical consistency and vocabulary of the outputted documents.
