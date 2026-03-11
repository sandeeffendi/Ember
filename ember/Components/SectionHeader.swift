//
//  SectionHeader.swift
//  ember
//
//  Section title component with consistent styling
//

import SwiftUI

struct SectionHeader: View {
    let title: String
    var icon: String? = nil
    var subtitle: String? = nil
    var action: (() -> Void)? = nil
    var actionIcon: String? = nil
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                HStack(spacing: Spacing.sm) {
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.subheadline)
                            .foregroundColor(Color.AppColors.primary)
                    }
                    
                    Text(title)
                        .font(.headline)
                        .foregroundColor(Color.AppColors.textPrimary)
                }
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(Color.AppColors.textSecondary)
                }
            }
            
            Spacer()
            
            if let action = action, let actionIcon = actionIcon {
                Button(action: action) {
                    Image(systemName: actionIcon)
                        .font(.subheadline)
                        .foregroundColor(Color.AppColors.primary)
                }
            }
        }
        .padding(.horizontal, Spacing.md)
    }
}

// MARK: - SectionHeader Preview

struct SectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: Spacing.lg) {
            SectionHeader(title: "Basic Section")
            
            SectionHeader(
                title: "With Subtitle",
                subtitle: "This is a description"
            )
            
            SectionHeader(
                title: "With Icon",
                icon: "person.fill",
                subtitle: "Personal information"
            )
            
            SectionHeader(
                title: "With Action",
                action: {},
                actionIcon: "chevron.right"
            )
        }
        .padding()
        .background(Color.AppColors.background)
    }
}
