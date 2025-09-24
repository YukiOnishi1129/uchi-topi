import SwiftUI

/// アプリケーションのカラーパレット
struct AppColors {
    // MARK: - Primary Colors
    static let primary = Color("Primary", bundle: .main)
    static let secondary = Color("Secondary", bundle: .main)
    static let accent = Color("Accent", bundle: .main)
    
    // MARK: - Background Colors
    #if os(iOS)
    static let background = Color(UIColor.systemBackground)
    static let secondaryBackground = Color(UIColor.secondarySystemBackground)
    static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)
    #else
    static let background = Color(NSColor.controlBackgroundColor)
    static let secondaryBackground = Color(NSColor.windowBackgroundColor)
    static let tertiaryBackground = Color(NSColor.controlBackgroundColor)
    #endif
    
    // MARK: - Text Colors
    #if os(iOS)
    static let primaryText = Color(UIColor.label)
    static let secondaryText = Color(UIColor.secondaryLabel)
    static let tertiaryText = Color(UIColor.tertiaryLabel)
    static let placeholderText = Color(UIColor.placeholderText)
    #else
    static let primaryText = Color(NSColor.labelColor)
    static let secondaryText = Color(NSColor.secondaryLabelColor)
    static let tertiaryText = Color(NSColor.tertiaryLabelColor)
    static let placeholderText = Color(NSColor.placeholderTextColor)
    #endif
    
    // MARK: - Status Colors
    static let success = Color.green
    static let warning = Color.orange
    static let error = Color.red
    static let info = Color.blue
    
    // MARK: - Priority Colors
    static let priorityLow = Color.gray
    static let priorityMedium = Color.blue
    static let priorityHigh = Color.orange
    static let priorityUrgent = Color.red
    
    // MARK: - Role Colors
    static let parentColor = Color.blue
    static let partnerColor = Color.purple
    static let childColor = Color.green
    static let guestColor = Color.gray
    
    // MARK: - Semantic Colors
    #if os(iOS)
    static let separator = Color(UIColor.separator)
    #else
    static let separator = Color(NSColor.separatorColor)
    #endif
    static let shadow = Color.black.opacity(0.1)
    
    // MARK: - Task Status Colors
    static let pendingStatus = Color.gray
    static let inProgressStatus = Color.blue
    static let completedStatus = Color.green
    static let cancelledStatus = Color.red
}

// MARK: - Color Extensions
extension Color {
    /// 優先度に基づいた色を返す
    static func priority(_ priority: Priority) -> Color {
        switch priority {
        case .low:
            return AppColors.priorityLow
        case .medium:
            return AppColors.priorityMedium
        case .high:
            return AppColors.priorityHigh
        case .urgent:
            return AppColors.priorityUrgent
        }
    }
    
    /// ロールに基づいた色を返す
    static func role(_ role: UserRole) -> Color {
        switch role {
        case .parent:
            return AppColors.parentColor
        case .partner:
            return AppColors.partnerColor
        case .child:
            return AppColors.childColor
        case .guest:
            return AppColors.guestColor
        }
    }
    
    /// ステータスに基づいた色を返す
    static func status(_ status: TopicStatus) -> Color {
        switch status {
        case .pending:
            return AppColors.pendingStatus
        case .inProgress:
            return AppColors.inProgressStatus
        case .completed:
            return AppColors.completedStatus
        case .cancelled:
            return AppColors.cancelledStatus
        }
    }
}