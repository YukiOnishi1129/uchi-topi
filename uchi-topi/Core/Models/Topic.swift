import Foundation

/// トピックモデル（タスク/イベント）
struct Topic: Identifiable, Codable, Equatable {
    let id: String
    let familyId: String
    var type: TopicType
    var title: String
    var description: String?
    var assigneeId: String?
    var status: TopicStatus
    var priority: Priority
    var labels: [String]
    var startAt: Date?
    var dueAt: Date?
    var completedAt: Date?
    var sourceMessageId: String?
    var sourceThreadId: String?
    var createdBy: String
    var createdAt: Date
    var updatedAt: Date
    
    init(
        id: String = UUID().uuidString,
        familyId: String,
        type: TopicType,
        title: String,
        description: String? = nil,
        assigneeId: String? = nil,
        status: TopicStatus = .pending,
        priority: Priority = .medium,
        labels: [String] = [],
        startAt: Date? = nil,
        dueAt: Date? = nil,
        completedAt: Date? = nil,
        sourceMessageId: String? = nil,
        sourceThreadId: String? = nil,
        createdBy: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.familyId = familyId
        self.type = type
        self.title = title
        self.description = description
        self.assigneeId = assigneeId
        self.status = status
        self.priority = priority
        self.labels = labels
        self.startAt = startAt
        self.dueAt = dueAt
        self.completedAt = completedAt
        self.sourceMessageId = sourceMessageId
        self.sourceThreadId = sourceThreadId
        self.createdBy = createdBy
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

/// トピックタイプ
enum TopicType: String, Codable, CaseIterable {
    case task
    case event
    case note
    
    var displayName: String {
        switch self {
        case .task:
            return "タスク"
        case .event:
            return "イベント"
        case .note:
            return "メモ"
        }
    }
    
    var iconName: String {
        switch self {
        case .task:
            return "checkmark.circle"
        case .event:
            return "calendar"
        case .note:
            return "note.text"
        }
    }
}

/// トピックステータス
enum TopicStatus: String, Codable, CaseIterable {
    case pending
    case inProgress
    case completed
    case cancelled
    
    var displayName: String {
        switch self {
        case .pending:
            return "未着手"
        case .inProgress:
            return "進行中"
        case .completed:
            return "完了"
        case .cancelled:
            return "キャンセル"
        }
    }
}

/// 優先度
enum Priority: String, Codable, CaseIterable {
    case low
    case medium
    case high
    case urgent
    
    var displayName: String {
        switch self {
        case .low:
            return "低"
        case .medium:
            return "中"
        case .high:
            return "高"
        case .urgent:
            return "緊急"
        }
    }
    
    var color: String {
        switch self {
        case .low:
            return "gray"
        case .medium:
            return "blue"
        case .high:
            return "orange"
        case .urgent:
            return "red"
        }
    }
}