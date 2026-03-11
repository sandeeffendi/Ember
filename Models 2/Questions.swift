//
//  Questions.swift
//  ember
//
//  Created by Sande Effendi on 11/03/26.
//

    // Models/Question.swift
    import Foundation

    // Model untuk setiap pertanyaan di assessment
    struct Question: Identifiable {
        let id: Int
        let text: String
        let dimension: Dimension // EE, PE, atau DP
        let options: [AnswerOption]
    }

    // Dimensi burnout berdasarkan MBI
    enum Dimension: String {
        case emotionalExhaustion = "EE"
        case physicalExhaustion = "PE"
        case depersonalization = "DP"
    }

    // Setiap pilihan jawaban dengan skornya
    struct AnswerOption: Identifiable {
        let id: Int
        let text: String
        let score: Int // 1–4
    }

    // MARK: - Data Pertanyaan (sesuaikan teks dengan kebutuhanmu)
    extension Question {
        static let all: [Question] = [
            // EE: Q1, Q4, Q7
            Question(id: 1, text: "Seberapa sering kamu merasa kelelahan emosional akibat pekerjaan?",
                     dimension: .emotionalExhaustion,
                     options: answerOptions),

            Question(id: 2, text: "Seberapa sering kamu merasa fisikmu terkuras habis di akhir hari kerja?",
                     dimension: .physicalExhaustion,
                     options: answerOptions),

            Question(id: 3, text: "Seberapa sering kamu merasa sinisme atau jarak emosional terhadap pekerjaanmu?",
                     dimension: .depersonalization,
                     options: answerOptions),

            Question(id: 4, text: "Seberapa sering kamu merasa frustrasi saat bekerja?",
                     dimension: .emotionalExhaustion,
                     options: answerOptions),

            Question(id: 5, text: "Seberapa sering kamu mengalami sakit kepala atau keluhan fisik karena tekanan kerja?",
                     dimension: .physicalExhaustion,
                     options: answerOptions),

            Question(id: 6, text: "Seberapa sering kamu merasa tidak peduli dengan hasil pekerjaanmu?",
                     dimension: .depersonalization,
                     options: answerOptions),

            Question(id: 7, text: "Seberapa sering kamu merasa emosi terkuras saat berinteraksi dengan rekan kerja?",
                     dimension: .emotionalExhaustion,
                     options: answerOptions),

            Question(id: 8, text: "Seberapa sering kamu merasa kehilangan antusiasme terhadap pekerjaanmu?",
                     dimension: .depersonalization,
                     options: answerOptions),
        ]

        // Pilihan jawaban standar untuk semua pertanyaan
        private static let answerOptions: [AnswerOption] = [
            AnswerOption(id: 1, text: "Hampir tidak pernah", score: 1),
            AnswerOption(id: 2, text: "Kadang-kadang",       score: 2),
            AnswerOption(id: 3, text: "Sering",              score: 3),
            AnswerOption(id: 4, text: "Hampir selalu",       score: 4),
        ]
    }
