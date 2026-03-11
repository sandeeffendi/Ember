//
//  SectionContainer.swift
//  ember
//
//  Container for grouped content sections
//

import SwiftUI

struct SectionContainer<Content: View>: View {
    let title: String?
    let content: Content
    var showHeader: Bool = true
    var elevation: Elevation = .low
    
    init(
        title: String? = nil,
        showHeader: Bool = true,
        elevation: Elevation = .low,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.showHeader = showHeader
        self.elevation = elevation
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            if showHeader, let title = title {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color.AppColors.textPrimary)
                    .padding(.horizontal, Spacing.md)
            }
            
            content
        }
    }
}

// MARK: - Section Item

struct SectionItem<Content: View>: View {
    let content: Content
    var showDivider: Bool = true
    
    init(showDivider: Bool = true, @ViewBuilder content: () -> Content) {
        self.showDivider = showDivider
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            content
            
            if showDivider {
                Divider()
                    .padding(.leading, Spacing.md)
            }
        }
    }
}

// MARK: - SectionContainer Preview

struct SectionContainer_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: Spacing.lg) {
            SectionContainer(title: "Personal Info") {
                SectionItem {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text("John Doe")
                            .foregroundColor(Color.AppColors.textSecondary)
                    }
                    .padding(Spacing.md)
                }
                
                SectionItem(showDivider: false) {
                    HStack {
                        Text("Email")
                        Spacer()
                        Text("john@example.com")
                            .foregroundColor(Color.AppColors.textSecondary)
                    }
                    .padding(Spacing.md)
                }
            }
            
            SectionContainer(title: nil) {
                AppCard(elevation: .low) {
                    Text("Card inside section")
                }
            }
        }
        .padding()
        .background(Color.AppColors.background)
    }
}
