import Foundation

/// 家族グループモデル
struct Family: Identifiable, Codable, Equatable {
    let id: String
    var name: String
    var inviteCode: String?
    var createdBy: String
    var createdAt: Date
    var updatedAt: Date
    
    init(
        id: String = UUID().uuidString,
        name: String,
        inviteCode: String? = nil,
        createdBy: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.inviteCode = inviteCode
        self.createdBy = createdBy
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

/// 家族メンバー
struct FamilyMember: Identifiable, Codable, Equatable {
    let id: String
    let userId: String
    let familyId: String
    var role: UserRole
    var nickname: String?
    var joinedAt: Date
    
    init(
        id: String = UUID().uuidString,
        userId: String,
        familyId: String,
        role: UserRole,
        nickname: String? = nil,
        joinedAt: Date = Date()
    ) {
        self.id = id
        self.userId = userId
        self.familyId = familyId
        self.role = role
        self.nickname = nickname
        self.joinedAt = joinedAt
    }
}