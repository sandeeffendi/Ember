# Code Review Prompt

You are performing a professional code review on the current implementation.

Your goal is to ensure the code matches the repository specification and engineering standards.

---

# Review Context

The repository follows:

Spec Driven Development  
SwiftUI architecture  
Lightweight MVVM pattern  
Design System driven UI

---

# Review Checklist

Review the implementation using the following criteria.

---

# 1. Specification Compliance

Check:

- does the implementation match the feature specification?
- are all required components implemented?
- is any undocumented behavior introduced?

If the implementation deviates from the specification, identify the issue.

---

# 2. Architecture Integrity

Check:

- does the code respect MVVM separation?
- is business logic placed inside ViewModel?
- are Views focused on UI rendering?

Flag violations if architecture boundaries are broken.

---

# 3. Design System Usage

Verify:

- colors come from design tokens
- typography follows design system
- spacing is consistent

Hardcoded styles should be flagged.

---

# 4. Component Reusability

Check whether components are reusable.

Avoid components that:

- contain feature-specific logic
- duplicate existing components
- tightly couple UI and business logic

---

# 5. Code Quality

Evaluate:

- readability
- simplicity
- duplication
- unnecessary complexity

Recommend refactoring if needed.

---

# 6. UX Quality

Check:

- UI clarity
- visual hierarchy
- interaction feedback
- accessibility considerations

---

# Output Format

Provide review results using this structure.

## Summary

Short summary of the code quality.

## Issues Found

List of problems discovered.

## Suggested Improvements

Specific suggestions for refactoring or improvement.

## Final Verdict

One of:

Approved  
Needs Refactor  
Requires Major Revision