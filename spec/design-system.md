# Design System Specification

Platform: iOS  
Framework: SwiftUI

---

# Design Principles

The UI must follow these principles:

- calm
- minimal
- readable
- supportive

The interface should reduce cognitive load and encourage reflection.

---

# Color System

Primary Color  
Soft Blue

Purpose:

- primary actions
- button highlights
- selection states

---

Secondary Color  
Soft Green

Purpose:

- positive feedback
- progress indicators

---

Warning Color  
Soft Orange

Purpose:

- burnout risk indicators

---

Critical Color  
Soft Red

Purpose:

- severe burnout stage

---

Background Color  
Off White

Purpose:

- calm visual environment

---

# Typography

Font:

SF Pro

Hierarchy:

LargeTitle → screen titles  
Title2 → section headers  
Title3 → question text  
Body → paragraph text  
Caption → metadata text

---

# Spacing System

Spacing scale:

4  
8  
16  
24  
32

---

# UI Components

The design system includes the following reusable components.

PrimaryButton  
SelectableCard  
ProgressIndicator  
StageIndicator

All components must follow consistent spacing and typography rules.

# Surface System

The application uses a card-based interface to create visual hierarchy.

Surface types:

PrimarySurface  
Used for main content cards.

SecondarySurface  
Used for nested sections.

GlassSurface  
Used for floating information panels.

All surfaces must use:

rounded corner radius  
consistent shadow tokens  
spacing tokens