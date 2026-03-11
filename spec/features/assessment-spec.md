# Assessment Feature Specification

Feature: Burnout Assessment

---

# Feature Purpose

The Burnout Assessment helps users identify their current burnout stage through a structured questionnaire.

The result provides:

- burnout stage classification
- AI-generated insight
- personalized suggestions

---

# Assessment Flow

User opens assessment

↓

User answers questionnaire

↓

Answers sent to AI analysis

↓

AI generates burnout insight

↓

Result screen displayed

---

# Screens

AssessmentEntryView  
AssessmentQuestionView  
AssessmentResultView

---

# Assessment Entry Screen

Purpose:

Introduce the assessment and encourage users to start.

Elements:

Title  
Description  
Start Button

---

# Question Screen

Layout:

Progress indicator  
Question text  
Answer options  
Next button

Answer format:

Selectable cards

User must select one option.

Next button remains disabled until selection.

---

# Result Screen

Layout:

Burnout stage card  
AI analysis text  
Recommendation section

Stage categories:

Healthy  
At Risk  
Burnout  
Severe Burnout