# Task Execution Prompt

You are executing a development task inside a Spec Driven Development repository.

Your objective is to implement the task described in the tasks directory.

---

# Execution Workflow

Follow these steps strictly.

Step 1 — Read Context

Read the following documents:

docs/product-requirement.md  
spec/design-system.md  
spec/features/*

These documents describe the system and the feature context.

---

Step 2 — Read Task

Locate the current task inside:

tasks/

Understand:

- objective
- deliverables
- constraints

Do not begin coding until you understand the task.

---

Step 3 — Identify Affected Components

Before coding, determine:

- which files must be created
- which files must be modified
- which components must be reused

Create a short implementation plan.

---

Step 4 — Implement the Task

Write the required implementation.

Follow these rules:

- respect SwiftUI best practices
- follow MVVM architecture
- use reusable components
- use design tokens
- maintain consistent spacing and typography

Avoid:

- duplicated code
- hardcoded colors
- feature-specific logic inside generic components

---

Step 5 — Validate Implementation

Verify:

- the feature matches the specification
- the UI follows the design system
- the implementation respects architecture boundaries

---

Step 6 — Prepare for Review

Before finishing the task:

- check for unnecessary complexity
- remove redundant code
- ensure readability