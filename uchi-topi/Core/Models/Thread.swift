import Foundation

/// スレッドモデル（トーク）
struct Thread: Identifiable, Codable, Equatable {
    let id: String
    let familyId: String
    var title: String
    var description: String?
    var createdBy: String
    var lastMessageAt: Date
    var createdAt: Date
    var updatedAt: Date
    var isArchived: Bool
    var participantIds: [String]
    
    init(
        id: String = UUID().uuidString,
        familyId: String,
        title: String,
        description: String? = nil,
        createdBy: String,
        lastMessageAt: Date = Date(),
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        isArchived: Bool = false,
        participantIds: [String] = []
    ) {
        self.id = id
        self.familyId = familyId
        self.title = title
        self.description = description
        self.createdBy = createdBy
        self.lastMessageAt = lastMessageAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isArchived = isArchived
        self.participantIds = participantIds
    }
}