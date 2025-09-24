import SwiftUI

/// アプリケーションの余白・間隔定義
struct AppSpacing {
    // MARK: - Padding Values
    static let xxSmall: CGFloat = 4
    static let xSmall: CGFloat = 8
    static let small: CGFloat = 12
    static let medium: CGFloat = 16
    static let large: CGFloat = 20
    static let xLarge: CGFloat = 24
    static let xxLarge: CGFloat = 32
    static let xxxLarge: CGFloat = 40
    
    // MARK: - Specific Spacing
    static let cardPadding: CGFloat = medium
    static let sectionSpacing: CGFloat = large
    static let listItemSpacing: CGFloat = small
    static let iconSpacing: CGFloat = xSmall
    
    // MARK: - Corner Radius
    static let smallRadius: CGFloat = 8
    static let mediumRadius: CGFloat = 12
    static let largeRadius: CGFloat = 16
    static let cardRadius: CGFloat = mediumRadius
    static let buttonRadius: CGFloat = smallRadius
    
    // MARK: - Heights
    static let buttonHeight: CGFloat = 48
    static let inputHeight: CGFloat = 44
    static let tabBarHeight: CGFloat = 49
    static let navigationBarHeight: CGFloat = 44
    
    // MARK: - Icon Sizes
    static let smallIcon: CGFloat = 16
    static let mediumIcon: CGFloat = 24
    static let largeIcon: CGFloat = 32
    
    // MARK: - Layout Guides
    static let maxContentWidth: CGFloat = 600
    static let minimumTapTarget: CGFloat = 44
}

// MARK: - Spacing View Modifiers
extension View {
    /// カードスタイルの余白とコーナー半径を適用
    func cardStyle() -> some View {
        self
            .padding(AppSpacing.cardPadding)
            .background(AppColors.secondaryBackground)
            .cornerRadius(AppSpacing.cardRadius)
            .shadow(color: AppColors.shadow, radius: 2, x: 0, y: 2)
    }
    
    /// セクションスタイルの余白を適用
    func sectionStyle() -> some View {
        self
            .padding(.vertical, AppSpacing.sectionSpacing)
            .padding(.horizontal, AppSpacing.medium)
    }
}