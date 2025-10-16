---
description: Guide for using Taskmaster to manage task-driven development workflows
applyTo: "**/*"
---

# Taskmaster Development Workflow

This guide outlines the standard process for using Taskmaster to manage software development projects. It is written as a set of instructions for you, the AI agent.

- **Your Default Stance**: For most projects, the user can work directly within the `master` task context. Your initial actions should operate on this default context unless a clear pattern for multi-context work emerges.
- **Your Goal**: Your role is to elevate the user's workflow by intelligently introducing advanced features like **Tagged Task Lists** when you detect the appropriate context. Do not force tags on the user; suggest them as a helpful solution to a specific need.

## The Basic Loop
The fundamental development cycle you will facilitate is:
1.  **`list`**: Show the user what needs to be done.
2.  **`next`**: Help the user decide what to work on.
3.  **`show <id>`**: Provide details for a specific task.
4.  **`expand <id>`**: Break down a complex task into smaller, manageable subtasks.
5.  **Implement**: The user writes the code and tests.
6.  **`update-subtask`**: Log progress and findings on behalf of the user.
7.  **`set-status`**: Mark tasks and subtasks as `done` as work is completed.
8.  **Repeat**.

All your standard command executions should operate on the user's current task context, which defaults to `master`.

---

## Standard Development Workflow Process

### Simple Workflow (Default Starting Point)

For new projects or when users are getting started, operate within the `master` tag context:

-   Start new projects by running `initialize_project` tool / `task-master init` or `parse_prd` / `task-master parse-prd --input='<prd-file.txt>'` (see @`taskmaster.instructions.md`) to generate initial tasks.json with tagged structure
-   Configure rule sets during initialization with `--rules` flag (e.g., `task-master init --rules vscode,windsurf`) or manage them later with `task-master rules add/remove` commands  
-   Begin coding sessions with `get_tasks` / `task-master list` (see @`taskmaster.instructions.md`) to see current tasks, status, and IDs
-   Determine the next task to work on using `next_task` / `task-master next` (see @`taskmaster.instructions.md`)
-   Analyze task complexity with `analyze_project_complexity` / `task-master analyze-complexity --research` (see @`taskmaster.instructions.md`) before breaking down tasks
-   Review complexity report using `complexity_report` / `task-master complexity-report` (see @`taskmaster.instructions.md`) for a formatted, readable version.
-   Select tasks based on dependencies (all marked 'done'), priority level, and ID order
-   View specific task details using `get_task` / `task-master show <id>` (see @`taskmaster.instructions.md`) to understand implementation requirements
-   Break down complex tasks using `expand_task` / `task-master expand --id=<id> --force --research` (see @`taskmaster.instructions.md`) with appropriate flags like `--force` (to replace existing subtasks) and `--research`
-   Implement code following task details, dependencies, and project standards
-   Mark completed tasks with `set_task_status` / `task-master set-status --id=<id> --status=done` (see @`taskmaster.instructions.md`)
-   Update dependent tasks when implementation differs from original plan using `update` / `task-master update --from=<id> --prompt="..."` or `update_task` / `task-master update-task --id=<id> --prompt="..."` (see @`taskmaster.instructions.md`)
