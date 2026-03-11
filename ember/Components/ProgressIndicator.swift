//
//  ProgressIndicator.swift
//  ember
//
//  Assessment progress indicator component
//

import SwiftUI

struct ProgressIndicator: View {
    let current: Int
    let total: Int
    
    private var progress: Double {
        guard total > 0 else { return 0 }
        return Double(current) / Double(total)
    }
    
    var body: some View {
        VStack(spacing: Spacing.sm) {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: CornerRadius.small)
                        .fill(Color.AppColors.cardBorder)
                        .frame(height: 6)
                    
                    RoundedRectangle(cornerRadius: CornerRadius.small)
                        .fill(Color.AppColors.primary)
                        .frame(width: geometry.size.width * progress, height: 6)
                        .animation(.spring(duration: 0.3), value: progress)
                }
            }
            .frame(height: 6)
            
            Text("Pertanyaan \(current) dari \(total)")
                .font(.caption)
                .foregroundColor(Color.AppColors.textSecondary)
        }
    }
}

struct ProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 24) {
            ProgressIndicator(current: 1, total: 8)
            ProgressIndicator(current: 3, total: 8)
            ProgressIndicator(current: 8, total: 8)
        }
        .padding()
    }
}
