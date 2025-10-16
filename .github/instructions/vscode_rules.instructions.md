---
description: Guidelines for creating and maintaining VS Code rules to ensure consistency and effectiveness.
applyTo: ".github/instructions/*.instructions.md"
---

- **Required Rule Structure:**
  ```markdown
  ---
  description: Clear, one-line description of what the rule enforces
  globs: path/to/files/*.ext, other/path/**/*
  alwaysApply: boolean
  ---

  - **Main Points in Bold**
    - Sub-points with details
    - Examples and explanations
  ```

- **File References:**
  - When referencing local instruction files, use relative paths under `.github/instructions/` (for example: `.github/instructions/myrule.instructions.md`).
  - When referencing source code examples, use repository-relative paths (for example: `src/models/user.ts`).

- **Code Examples:**
  - Use language-specific code blocks
  ```typescript
  // 
2705 DO: Show good examples
  const goodExample = true;
  
  // 
274c DON'T: Show anti-patterns
  const badExample = false;
  ```

- **Rule Content Guidelines:**
  - Start with high-level overview
  - Include specific, actionable requirements
  - Show examples of correct implementation
  - Reference existing code when possible
  - Keep rules DRY by referencing other rules

- **Rule Maintenance:**
  - Update rules when new patterns emerge
  - Add examples from actual codebase
  - Remove outdated patterns
  - Cross-reference related rules

- **Best Practices:**
  - Use bullet points for clarity
  - Keep descriptions concise
  - Include both DO and DON'T examples
  - Reference actual code over theoretical examples
  - Use consistent formatting across rules 
