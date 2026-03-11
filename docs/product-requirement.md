Berikut adalah **framework pengembangan berbasis AI Agent** yang dirancang untuk proyek Anda. Framework ini membuat agent bekerja seperti **autonomous product engineer** dengan workflow yang terstruktur dan stabil. Pendekatan ini cocok untuk **Spec-Driven Development** dan iterasi fitur seperti yang Anda lakukan pada fitur **Assessment**.

Framework ini menggabungkan konsep:

* **Product-Driven Development**
* **Spec-Driven Development**
* **Agent Task Execution**
* **Continuous Improvement Loop**

Tujuannya adalah membuat AI agent dapat:

* memahami requirement
* memecah task
* melakukan implementasi
* melakukan review
* melakukan refactor
* memastikan konsistensi dengan spec.

---

# AI Agent Development Framework

### Burnout Awareness App

Framework ini terdiri dari **6 tahap utama**.

```
Product Requirement
↓
Specification
↓
Task Decomposition
↓
Implementation
↓
Self Review
↓
Refinement Loop
```

---

# 1. Product Requirement Layer

Layer ini adalah **sumber visi produk**.

Dokumen di layer ini biasanya bersifat **high-level**.

Contoh:

```
docs/
    product-requirement.md
```

Isi dokumen:

* product vision
* problem statement
* feature overview
* user journey
* success metrics

Agent **tidak melakukan coding langsung dari layer ini**.

Layer ini hanya memberikan **konteks produk**.

---

# 2. Specification Layer

Layer ini adalah **source of truth untuk implementasi**.

Semua fitur harus memiliki spec yang jelas.

Struktur yang direkomendasikan:

```
spec/
    product-spec.md
    design-system.md

    features/
        assessment-spec.md
        daily-checkin-spec.md
        weekly-report-spec.md
```

Spec harus mencakup:

```
feature purpose
user flow
screen specification
component specification
interaction rules
data model
success criteria
```

Agent selalu membaca **spec sebelum melakukan implementasi**.

---

# 3. Task Decomposition Layer

Agent atau developer memecah spec menjadi task kecil.

Struktur:

```
tasks/
    assessment-ui/

        task-01-design-system.md
        task-02-components.md
        task-03-ui-refactor.md
        task-04-interaction.md
```

Contoh task:

```
Task 01
Create DesignTokens.swift

Task 02
Implement reusable UI components

Task 03
Refactor assessment UI

Task 04
Add interaction animations
```

Keuntungan layer ini:

* development menjadi modular
* agent dapat bekerja step-by-step
* debugging lebih mudah

---

# 4. Implementation Layer

Layer ini adalah **codebase aplikasi**.

Struktur project:

```
App/
Models/
Views/
ViewModels/
Services/
Components/
Utils/
```

Agent akan:

```
read spec
read tasks
implement feature
```

Agent **tidak boleh mengubah behavior di luar spec**.

---

# 5. Self Review Layer

Setelah implementasi, agent melakukan **self-review**.

Checklist review:

```
Does implementation match spec?
Are reusable components used correctly?
Is architecture respected?
Is UI consistent with design system?
Are interactions smooth?
```

Jika ada mismatch:

```
refactor implementation
```

---

# 6. Refinement Loop

Setelah review selesai, dilakukan **refinement loop**.

Loop ini terdiri dari:

```
Improve UI
Improve UX
Improve logic
Improve intelligence
```

Contoh:

Phase 1

```
Assessment UI improvement
```

Phase 2

```
Daily check-in UX improvement
```

Phase 3

```
Weekly insight visualization
```

Phase 4

```
AI personalization
```

---

# Repository Structure (Recommended)

Framework ini bekerja paling baik dengan struktur berikut.

```
docs/
    product-requirement.md

spec/
    design-system.md

    features/
        assessment-spec.md
        daily-checkin-spec.md
        weekly-report-spec.md

tasks/
    assessment-ui/
        task-01-design-system.md
        task-02-components.md
        task-03-ui-refactor.md
        task-04-interaction.md

App/
Models/
Views/
ViewModels/
Services/
Components/
Utils/
```

---

# Agent Development Workflow

Setiap agent harus mengikuti workflow berikut.

```
Read Product Context
↓
Read Feature Spec
↓
Read Task Specification
↓
Implement Feature
↓
Review Implementation
↓
Refactor if Needed
```

Agent tidak boleh:

```
skip spec
skip task
implement undocumented feature
```

---

# Agent Behavior Rules

Untuk menjaga stabilitas development, agent harus mengikuti rule berikut.

### Rule 1

Spec document adalah **source of truth**.

### Rule 2

Agent tidak boleh menambahkan feature tanpa spec.

### Rule 3

Agent harus menggunakan reusable components jika tersedia.

### Rule 4

Agent harus mengikuti design system.

### Rule 5

Agent harus menjaga arsitektur MVVM.

---

# Example Development Cycle

Contoh implementasi improvement pada fitur Assessment.

### Step 1

Read spec:

```
spec/features/assessment-spec.md
```

### Step 2

Read tasks:

```
tasks/assessment-ui/task-01-design-system.md
```

### Step 3

Implement:

```
DesignTokens.swift
```

### Step 4

Move to next task:

```
Reusable Components
```

### Step 5

Refactor UI:

```
AssessmentQuestionView
```

### Step 6

Add interaction improvement.

---

# AI Agent Master Prompt (Framework Mode)

Prompt ini digunakan untuk menjalankan framework ini.

```
You are a senior iOS software engineer working inside a Spec Driven Development framework.

The repository contains documentation describing the product, specifications, and development tasks.

Your responsibility is to implement features by strictly following the specification documents.

You must follow this workflow:

1. Read product documentation to understand the application context.
2. Read the feature specification located in the spec directory.
3. Read the task definition inside the tasks directory.
4. Implement the task described in the task specification.
5. Ensure your implementation follows the design system and architecture rules.
6. Perform a self review to verify the implementation matches the specification.
7. Refactor the code if necessary before moving to the next task.

Important rules:

Do not invent features not described in the specification.
Do not modify logic outside the scope of the current task.
Always reuse existing components when possible.
Maintain the existing MVVM architecture.
Follow SwiftUI best practices and Apple Human Interface Guidelines.

Your goal is to iteratively improve the application while maintaining consistency with the specification documents.
```

---

# Mengapa Framework Ini Sangat Stabil

Framework ini membuat agent bekerja seperti **engineer yang mengikuti engineering process**.

```
Spec → Task → Implementation → Review
```

Keuntungan:

* hallucination berkurang
* perubahan requirement mudah
* feature development lebih terkontrol
* scaling project lebih aman.

---

💡 **Rekomendasi berikutnya (sangat powerful untuk proyek Anda):**

Langkah berikutnya yang akan sangat meningkatkan kualitas proyek Anda adalah membuat:

### **Feature Development Template**

Template ini memungkinkan Anda membuat **spec baru untuk fitur berikutnya hanya dalam 5-10 menit**, misalnya:

```
Daily Check-in Enhancement
Weekly Insight Visualization
AI Recommendation System
Habit Reminder
```

Jika Anda mau, saya bisa membantu membuat **template spec feature yang reusable untuk seluruh pengembangan aplikasi Anda** sehingga workflow agent Anda menjadi **super efisien dan konsisten**.
