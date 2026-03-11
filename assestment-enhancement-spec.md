# Burnout Awareness App
## Assessment Feature Enhancement Specification

Version: 1.0  
Platform: iOS  
Framework: SwiftUI  
Architecture: MVVM (lightweight)  
Development Method: Spec-Driven Development

---

# 1. Product Context

Burnout Awareness App adalah aplikasi mobile yang membantu pengguna mengenali tanda awal burnout dan melakukan refleksi terhadap kondisi mental mereka.

Fitur utama aplikasi:

- Burnout Assessment
- Daily Check-In
- Weekly Insight
- Profile Analysis

Aplikasi berfokus pada:

- self-awareness
- burnout prevention
- behavioral reflection

---

# 2. Existing System Context

Aplikasi saat ini sudah memiliki implementasi MVP yang berjalan dengan baik.

Fitur **Burnout Assessment** sudah memiliki prototype yang mencakup:

- questionnaire interface
- AI integration menggunakan Gemini
- AI generated burnout analysis
- recommendation output

Flow existing assessment:

User answers questionnaire  
↓  
Answers sent to Gemini AI  
↓  
AI generates analysis  
↓  
Result stored locally

Pada fase ini **logic tersebut tidak diubah**.

Fase pengembangan ini hanya berfokus pada:

UI refinement  
UX improvement  
component consistency  
design standardization

---

# 3. Architecture Overview

Aplikasi menggunakan arsitektur:

MVVM (Model View ViewModel)

Namun implementasinya bersifat **lightweight** karena aplikasi masih dalam fase MVP.

Struktur folder:


App/
Models/
Views/
ViewModels/
Services/
Components/
Utils/


Responsibility:

View  
Menangani UI menggunakan SwiftUI.

ViewModel  
Mengelola state dan business logic.

Model  
Representasi data aplikasi.

Service  
Mengelola AI integration dan persistence.

---

# 4. Assessment Feature UX Flow

Flow assessment tetap seperti implementasi saat ini.


Assessment Entry
↓
Questionnaire
↓
Answer Selection
↓
Submit Answers
↓
AI Processing
↓
Assessment Result


Perubahan hanya terjadi pada:

- UI layout
- visual hierarchy
- interaction behavior

---

# 5. Screen Specification

---

# 5.1 Assessment Entry Screen

Purpose:

Memberikan konteks sebelum user memulai assessment.

Layout:


Header Section

Title
Description

Start Button


Title:

Understand Your Burnout Level

Typography:

LargeTitle  
Bold

Description:

This short assessment helps you understand your current mental state and identify early signs of burnout.

Typography:

Body

Primary Action:

Start Assessment Button

Action:

Tap → navigate to AssessmentQuestionView

---

# 5.2 Assessment Question Screen

Ini adalah layar utama assessment.

Layout structure:


Progress Indicator

Question Text

Answer Options

Next Button


---

# Progress Indicator

Example:

Question 3 of 10

Tujuan:

memberikan sense of progress  
mengurangi survey fatigue

---

# Question Component

Question text harus:

- readable
- concise
- maksimal 2–3 baris

Example:

How often do you feel emotionally exhausted from your work?

Typography:

Title3  
Medium

---

# Answer Options

Answer menggunakan **Selectable Card Component**

Example options:

Never  
Rarely  
Sometimes  
Often  
Always

---

# Selectable Card State

Default  
Selected  
Pressed  
Disabled

Visual rule:

Default

Background: white  
Border: light gray

Selected

Background: primary color  
Text: white

Pressed

Opacity: 80%

---

# Interaction Rule

User hanya dapat memilih satu jawaban.

Jika belum memilih:

Next Button → disabled

Jika jawaban dipilih:

Next Button → enabled

---

# 5.3 Assessment Result Screen

Layout:


Result Header

Burnout Stage Card

Analysis Section

Recommendation Section


---

# Burnout Stage Card

Example:

Stage: At Risk

Stage color mapping:

Healthy → Green  
At Risk → Yellow  
Burnout → Orange  
Severe Burnout → Red

---

# Analysis Section

Menampilkan hasil analisa AI.

Example:

You may be experiencing early signs of burnout due to prolonged work stress and emotional exhaustion.

Typography:

Body

---

# Recommendation Section

Example:

Consider setting clearer work boundaries and taking short breaks during your workday.

---

# 6. Design System

Untuk menjaga konsistensi UI seluruh aplikasi dibuat **design system ringan**.

---

# 6.1 Color System

Primary Color

Soft Blue

Digunakan untuk:

buttons  
highlights  
selection states

---

Secondary Color

Soft Green

Digunakan untuk:

positive indicators  
progress

---

Warning Color

Soft Orange

Digunakan untuk:

burnout risk indicator

---

Error Color

Soft Red

Digunakan untuk:

severe burnout

---

Background Color

Off White

Tujuan:

menciptakan tampilan calm dan clean.

---

# 6.2 Typography

Font:

SF Pro (default iOS)

Hierarchy:

LargeTitle → screen title  
Title2 → section header  
Title3 → question text  
Body → paragraph text  
Caption → small text

---

# 6.3 Spacing System

Gunakan spacing konsisten:

4  
8  
16  
24  
32

---

# 7. Reusable Components

Komponen berikut harus dibuat atau direfactor.

---

# PrimaryButton

Digunakan untuk:

Start Assessment  
Next Question  
Continue

State:

Enabled  
Disabled  
Pressed

---

# SelectableCard

Digunakan untuk:

answer options

State:

Default  
Selected  
Pressed

---

# ProgressIndicator

Digunakan untuk:

assessment progress

Bisa berupa:

progress bar  
step indicator

---

# StageIndicator

Digunakan untuk:

burnout stage display

---

# 8. Interaction Specification

Untuk meningkatkan UX, tambahkan micro-interaction.

---

# Answer Selection Animation

Scale animation:

0.95 → 1.0

Duration:

120ms

---

# Screen Transition

Transition antar question:

slide transition

---

# Button Feedback

Tap button memiliki:

opacity animation

---

# 9. Accessibility Requirements

Assessment harus memenuhi minimal accessibility requirement:

- dynamic type support
- sufficient color contrast
- tappable area ≥ 44pt
- screen reader compatibility

---

# 10. Implementation Tasks

Pengembangan dibagi menjadi task berikut.

---

Task 1 — Design System Setup

Create file:

DesignTokens.swift

Content:

AppColor  
AppTypography  
Spacing

---

Task 2 — Reusable Components

Create components:

PrimaryButton  
SelectableCard  
ProgressIndicator  
StageIndicator

---

Task 3 — Assessment UI Refactor

Refactor views:

AssessmentEntryView  
AssessmentQuestionView  
AssessmentResultView

Tujuan:

menggunakan design system dan reusable components

---

Task 4 — Interaction Improvement

Tambahkan:

selection animation  
screen transition  
button feedback

---

# 11. Success Criteria

Improvement dianggap berhasil jika:

- UI konsisten dengan design system
- reusable components digunakan
- assessment UX smooth
- completion time < 2 minutes

---

# 12. Deliverables

Fase ini harus menghasilkan:

DesignTokens.swift  
Reusable UI Components  
Refactored Assessment Views  
Improved UX Interaction

---

# 13. Repository Spec Structure

Untuk mendukung Spec Driven Development, struktur berikut direkomendasikan:


spec/
product-spec.md
design-system.md
assessment-enhancement-spec.md

tasks/
assessment-ui/
task-01-design-system.md
task-02-components.md
task-03-ui-refactor.md
task-04-interaction.md


Spec document menjadi **source of truth** untuk seluruh pengembangan.