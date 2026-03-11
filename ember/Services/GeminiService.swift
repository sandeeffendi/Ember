//
//  GeminiService.swift
//  ember
//

// Services/GeminiService.swift
import Foundation
import GoogleGenerativeAI

// Error yang mungkin terjadi saat proses analisa
enum GeminiError: LocalizedError {
    case invalidResponse
    case decodingFailed(String)
    case apiError(String)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Response dari AI tidak valid. Coba lagi."
        case .decodingFailed(let detail):
            return "Gagal memproses hasil: \(detail)"
        case .apiError(let msg):
            return "Terjadi kesalahan API: \(msg)"
        }
    }
}

final class GeminiService {
    private let model: GenerativeModel

    // System instruction yang kamu buat sebelumnya
    private let systemInstruction = """
    You are a professional burnout assessment analyst trained in MBI \
    (Maslach Burnout Inventory) methodology.
    You will receive a user's answers to an 8-question burnout self-assessment. \
    Each answer has a score from 1 to 4.
    ## Dimensions:
    - EE (Emotional Exhaustion): Q1, Q4, Q7 → max score 12
    - PE (Physical Exhaustion): Q2, Q5 → max score 8
    - DP (Depersonalization): Q3, Q6, Q8 → max score 12
    ## Scoring Rules:
    - Total score range: 8–32
    - Phase classification:
      * 8–13  → HEALTHY (Zona Aman)
      * 14–19 → EARLY_WARNING (Burnout Dini)
      * 20–26 → ACTIVE_BURNOUT (Burnout Aktif)
      * 27–32 → SEVERE_BURNOUT (Burnout Berat)
    ## Your Task:
    1. Calculate each dimension score and total score
    2. Determine the burnout phase
    3. Write a short, empathetic narrative analysis in Bahasa Indonesia (2-3 sentences)
    4. Provide 3 concise, actionable recommendations in Bahasa Indonesia
    ## Output Rules:
    - Respond ONLY with valid JSON matching the schema below
    - Never add markdown, explanation, or text outside the JSON
    - Narrative and recommendations must be warm, non-judgmental, and supportive
    """

    init() {
        self.model = GenerativeModel(
            name: "gemini-flash-lite-latest",
            apiKey: Self.loadAPIKey(),
            systemInstruction: systemInstruction
        )
    }

    private static func loadAPIKey() -> String {
        guard let key = Bundle.main.infoDictionary?["GEMINI_API_KEY"] as? String else {
            fatalError("Gemini API key not found in Secrets.xcconfig")
        }
        return key
    }

    // Kirim jawaban user ke Gemini dan terima hasil analisa
    func analyze(answers: [Int: Int]) async throws -> BurnoutResult {
        let prompt = buildPrompt(from: answers)

        do {
            let response = try await model.generateContent(prompt)

            guard let rawText = response.text else {
                throw GeminiError.invalidResponse
            }

            return try parseResult(from: rawText)
        } catch let error as GeminiError {
            throw error
        } catch {
            throw GeminiError.apiError(error.localizedDescription)
        }
    }

    // Format jawaban user menjadi prompt yang jelas untuk Gemini
    private func buildPrompt(from answers: [Int: Int]) -> String {
        let sortedAnswers = answers.sorted { $0.key < $1.key }
        let answerText = sortedAnswers
            .map { "Q\($0.key): \($0.value)" }
            .joined(separator: ", ")

        return """
        Here are the user's assessment answers:
        \(answerText)

        Please analyze and return the result in this exact JSON format:
        {
          "scores": { "EE": 0, "PE": 0, "DP": 0, "total": 0 },
          "phase": "PHASE_CODE",
          "phase_label": "Label Fase",
          "narrative": "Narasi analisis...",
          "recommendations": "1. ... 2. ... 3. ..."
        }
        """
    }

    // Parse JSON string dari Gemini menjadi BurnoutResult
    private func parseResult(from text: String) throws -> BurnoutResult {
        // Bersihkan jika Gemini menambahkan markdown code block
        let cleaned = text
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard let data = cleaned.data(using: .utf8) else {
            throw GeminiError.decodingFailed("Tidak bisa convert ke Data")
        }

        do {
            return try JSONDecoder().decode(BurnoutResult.self, from: data)
        } catch {
            throw GeminiError.decodingFailed(error.localizedDescription)
        }
    }
}
