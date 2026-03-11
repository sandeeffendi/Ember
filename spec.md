1. Product Specification Document (Markdown)
# Burnout Awareness App
## Product Specification (MVP)

Version: 1.0  
Platform: iOS  
Framework: SwiftUI  
Architecture: MVVM (lightweight MVP)

---

# 1. Product Overview

Burnout Awareness App adalah aplikasi mobile yang membantu pengguna mengenali tanda awal burnout dan melakukan refleksi terhadap kondisi mental mereka melalui assessment, daily check-in, dan insight mingguan.

Tujuan utama aplikasi adalah meningkatkan self-awareness sehingga pengguna dapat mencegah burnout sebelum kondisinya menjadi parah.

Aplikasi berfokus pada:

- self reflection
- early burnout detection
- behavioral awareness
- wellbeing tracking

---

# 2. Existing Prototype Context

Project ini sudah memiliki prototype untuk fitur **Burnout Assessment**.

Prototype tersebut sudah mencakup:

- questionnaire interface
- integrasi dengan model AI (Gemini)
- AI generated analysis dan recommendation

Agent harus:

1. mempelajari implementasi prototype yang ada
2. mempertahankan logic assessment yang sudah berjalan
3. melakukan refactor jika diperlukan
4. mengintegrasikan fitur assessment ke dalam arsitektur aplikasi yang baru

Agent tidak boleh menulis ulang fitur assessment dari awal kecuali benar-benar diperlukan.

---

# 3. Architecture

Aplikasi menggunakan arsitektur:

MVVM (Model View ViewModel)

Namun implementasi harus **lightweight** karena aplikasi masih dalam tahap **MVP**.

Struktur folder yang direkomendasikan:


App/
Models/
Views/
ViewModels/
Services/
Components/
Utils/


## Responsibility

### View

Menangani tampilan UI menggunakan SwiftUI.

### ViewModel

Menangani:

- state management
- business logic
- service interaction

### Model

Representasi data aplikasi.

### Service

Menangani:

- AI integration
- persistence
- external communication

---

# 4. Application Flow

Flow utama aplikasi:


Launch App
↓
Check if user has completed burnout assessment
↓
If not completed → show Assessment Flow
If completed → show Homepage


Navigasi utama:


Homepage
├── Daily Check-In
├── Weekly Report
└── Profile


Navigation menggunakan:

SwiftUI NavigationStack

---

# 5. Feature Specification

---

# 5.1 Burnout Assessment

Tujuan:

Menentukan stage burnout pengguna dan memberikan analisa berbasis AI.

Flow:


User answers questionnaire
↓
Answers sent to Gemini AI
↓
AI generates structured response
↓
Result stored locally


Response format:


{
stage: "At Risk",
analysis: "...",
recommendation: "..."
}


Assessment result harus disimpan secara lokal dan dapat diakses pada halaman profile.

Data model:


Assessment
burnoutStage
analysis
recommendation
timestamp


---

# 5.2 Homepage

Homepage adalah entry point utama aplikasi setelah assessment selesai.

Struktur halaman:

App Bar

- Profile Icon
- Welcome Message

Main Content

- Card: Daily Check-In
- Card: Weekly Report

Contoh welcome text:


Good Morning
How are you feeling today?


UI harus mengikuti Apple Human Interface Guidelines.

---

# 5.3 Daily Check-In

Daily check-in digunakan untuk mencatat kondisi mental user sepanjang hari.

Terdiri dari tiga fase:

Morning Check  
Midday Check  
Shutdown Check

Mapping waktu:

Morning → 05:00–11:00  
Midday → 11:00–17:00  
Shutdown → 17:00–23:00

Setiap check-in mencatat:


moodLevel
energyLevel
stressLevel


Data model:


DailyCheckIn
date
phase
moodLevel
energyLevel
stressLevel


Check-in harus dapat diselesaikan dalam waktu kurang dari 10 detik.

---

# 5.4 Weekly Report

Halaman ini memberikan insight tentang wellbeing pengguna selama satu minggu.

Komponen utama:

Calendar View  
Weekly Insight

Calendar menunjukkan apakah user melakukan check-in.

Contoh:


Mon Tue Wed Thu Fri Sat Sun
✔ ✔ ✔ ✖ ✔ ✔ ✔


Insight dapat berupa:

- stress pattern
- energy trend
- behavioral recommendation

---

# 5.5 Profile Page

Halaman profile menampilkan hasil burnout assessment.

Komponen:

Burnout Stage  
AI Analysis  
AI Recommendation

Semua data berasal dari hasil assessment yang disimpan secara lokal.

---

# 6. Data Models

Minimal model yang harus ada:

## User


User
id
name
createdAt


## Assessment


Assessment
burnoutStage
analysis
recommendation
timestamp


## DailyCheckIn


DailyCheckIn
date
phase
moodLevel
energyLevel
stressLevel


---

# 7. Data Persistence (MVP)

Untuk MVP gunakan penyimpanan lokal seperti:

UserDefaults  
Local JSON  
atau lightweight persistence.

Arsitektur harus memungkinkan migrasi ke database yang lebih kompleks di masa depan.

---

# 8. State Management

Gunakan SwiftUI state system:

@State  
@StateObject  
@ObservedObject  

Pattern:


View
↓
ViewModel
↓
Service


---

# 9. Reusable UI Components

Komponen reusable yang perlu dibuat:

CardView  
CheckInButton  
CalendarDayView

Tujuan:

- konsistensi UI
- reusability
- maintainability

---

# 10. AI Integration

AI hanya digunakan untuk fitur burnout assessment.

Flow:


User answers questionnaire
↓
Send answers to Gemini API
↓
Receive structured burnout analysis
↓
Store result locally


Service layer harus mengisolasi logic komunikasi dengan AI.

---

# 11. Engineering Principles

Implementasi harus mengikuti prinsip berikut:

- maintainable code
- modular structure
- minimal boilerplate
- clean SwiftUI views
- pragmatic architecture

Aplikasi harus dirancang sebagai **MVP yang dapat di-scale pada iterasi berikutnya**.