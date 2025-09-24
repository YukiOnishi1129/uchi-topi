import Foundation

/// 通知モデル
struct Notification: Identifiable, Codable, Equatable {
    let id: String
    let userId: String
    let familyId: String
    var kind: NotificationKind
    var title: String
    var body: String
    var referenceType: ReferenceType?
    var referenceId: String?
    var isRead: Bool
    var readAt: Date?
    var createdAt: Date
    
    init(
        id: String = UUID().uuidString,
        userId: String,
        familyId: String,
        kind: NotificationKind,
        title: String,
        body: String,
        referenceType: ReferenceType? = nil,
        referenceId: String? = nil,
        isRead: Bool = false,
        readAt: Date? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.userId = userId
        self.familyId = familyId
        self.kind = kind
        self.title = title
        self.body = body
        self.referenceType = referenceType
        self.referenceId = referenceId
        self.isRead = isRead
        self.readAt = readAt
        self.createdAt = createdAt
    }
}

/// 通知種別
enum NotificationKind: String, Codable, CaseIterable {
    case newMessage
    case taskAssigned
    case taskUpdated
    case taskCompleted
    case eventReminder
    case dueDateReminder
    case familyInvite
    case system
    
    var displayName: String {
        switch self {
        case .newMessage:
            return "新着メッセージ"
        case .taskAssigned:
            return "タスク割り当て"
        case .taskUpdated:
            return "タスク更新"
        case .taskCompleted:
            return "タスク完了"
        case .eventReminder:
            return "イベントリマインダー"
        case .dueDateReminder:
            return "期限リマインダー"
        case .familyInvite:
            return "家族への招待"
        case .system:
            return "システム通知"
        }
    }
    
    var iconName: String {
        switch self {
        case .newMessage:
            return "message"
        case .taskAssigned, .taskUpdated, .taskCompleted:
            return "checkmark.circle"
        case .eventReminder, .dueDateReminder:
            return "bell"
        case .familyInvite:
            return "person.badge.plus"
        case .system:
            return "info.circle"
        }
    }
}

/// 参照タイプ
enum ReferenceType: String, Codable {
    case thread
    case message
    case topic
    case family
}