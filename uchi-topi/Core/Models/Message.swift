import Foundation

/// メッセージモデル
struct Message: Identifiable, Codable, Equatable {
    let id: String
    let threadId: String
    let authorId: String
    var body: String
    var attachments: [MessageAttachment]
    var createdAt: Date
    var updatedAt: Date?
    var isEdited: Bool
    var taskId: String?  // タスク化された場合のタスクID
    
    init(
        id: String = UUID().uuidString,
        threadId: String,
        authorId: String,
        body: String,
        attachments: [MessageAttachment] = [],
        createdAt: Date = Date(),
        updatedAt: Date? = nil,
        isEdited: Bool = false,
        taskId: String? = nil
    ) {
        self.id = id
        self.threadId = threadId
        self.authorId = authorId
        self.body = body
        self.attachments = attachments
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isEdited = isEdited
        self.taskId = taskId
    }
}

/// メッセージ添付ファイル
struct MessageAttachment: Codable, Equatable {
    let id: String
    let type: AttachmentType
    let url: String
    let fileName: String
    let fileSize: Int64?
    let thumbnailUrl: String?
    
    init(
        id: String = UUID().uuidString,
        type: AttachmentType,
        url: String,
        fileName: String,
        fileSize: Int64? = nil,
        thumbnailUrl: String? = nil
    ) {
        self.id = id
        self.type = type
        self.url = url
        self.fileName = fileName
        self.fileSize = fileSize
        self.thumbnailUrl = thumbnailUrl
    }
}

/// 添付ファイルタイプ
enum AttachmentType: String, Codable {
    case image
    case document
    case video
    case audio
    case other
}

/// 既読情報
struct MessageRead: Codable, Equatable {
    let userId: String
    let messageId: String
    let threadId: String
    let lastReadAt: Date
    
    init(
        userId: String,
        messageId: String,
        threadId: String,
        lastReadAt: Date = Date()
    ) {
        self.userId = userId
        self.messageId = messageId
        self.threadId = threadId
        self.lastReadAt = lastReadAt
    }
}