//
//  BurnoutResult.swift
//  ember
//
//  Created by Sande Effendi on 11/03/26.
//

    // Models/BurnoutResult.swift
    import Foundation
    import SwiftUI

    // Decode JSON response dari Gemini
    struct BurnoutResult: Codable {
        let scores: BurnoutScores
        let phase: String
        let phaseLabel: String
        let narrative: String
        let recommendations: String

        enum CodingKeys: String, CodingKey {
            case scores
            case phase
            case phaseLabel = "phase_label"
            case narrative
            case recommendations
        }
    }

    struct BurnoutScores: Codable {
        let ee: Int
        let pe: Int
        let dp: Int
        let total: Int

        enum CodingKeys: String, CodingKey {
            case ee = "EE"
            case pe = "PE"
            case dp = "DP"
            case total
        }
    }

    // Phase burnout dengan warna & icon untuk UI
    enum BurnoutPhase: String {
        case healthy       = "HEALTHY"
        case earlyWarning  = "EARLY_WARNING"
        case activeBurnout = "ACTIVE_BURNOUT"
        case severeBurnout = "SEVERE_BURNOUT"

        var color: Color {
            switch self {
            case .healthy:       return .green
            case .earlyWarning:  return .yellow
            case .activeBurnout: return .orange
            case .severeBurnout: return .red
            }
        }

        var icon: String {
            switch self {
            case .healthy:       return "checkmark.circle.fill"
            case .earlyWarning:  return "exclamationmark.triangle.fill"
            case .activeBurnout: return "flame.fill"
            case .severeBurnout: return "bolt.fill"
            }
        }
    }
