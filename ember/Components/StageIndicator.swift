//
//  StageIndicator.swift
//  ember
//
//  Burnout stage badge component
//

import SwiftUI

struct StageIndicator: View {
    let phase: BurnoutPhase
    let label: String
    let score: Int
    
    private var stageColor: Color {
        switch phase {
        case .healthy:
            return Color.AppColors.secondary
        case .earlyWarning:
            return .yellow
        case .activeBurnout:
            return Color.AppColors.warning
        case .severeBurnout:
            return Color.AppColors.error
        }
    }
    
    private var stageIcon: String {
        phase.icon
    }
    
    var body: some View {
        VStack(spacing: Spacing.sm) {
            ZStack {
                Circle()
                    .fill(stageColor.opacity(0.15))
                    .frame(width: 80, height: 80)
                
                Image(systemName: stageIcon)
                    .font(.system(size: 36))
                    .foregroundColor(stageColor)
            }
            
            Text(label)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color.AppColors.textPrimary)
            
            Text("Skor Total: \(score)/32")
                .font(.caption)
                .foregroundColor(Color.AppColors.textSecondary)
        }
        .padding(.top, Spacing.lg)
    }
}

struct StageIndicator_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 24) {
            StageIndicator(phase: .healthy, label: "Sehat", score: 10)
            StageIndicator(phase: .earlyWarning, label: "Awasi", score: 16)
            StageIndicator(phase: .activeBurnout, label: "Burnout", score: 22)
            StageIndicator(phase: .severeBurnout, label: "Berat", score: 30)
        }
    }
}
