import Foundation

/// ユーザーモデル
struct User: Identifiable, Codable, Equatable {
    let id: String
    var displayName: String
    var email: String?
    var role: UserRole
    var families: [String]
    var fcmTokens: [String]
    var createdAt: Date
    var updatedAt: Date
    
    init(
        id: String = UUID().uuidString,
        displayName: String,
        email: String? = nil,
        role: UserRole = .guest,
        families: [String] = [],
        fcmTokens: [String] = [],
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.displayName = displayName
        self.email = email
        self.role = role
        self.families = families
        self.fcmTokens = fcmTokens
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

/// ユーザーロール
enum UserRole: String, Codable, CaseIterable {
    case parent
    case partner
    case child
    case guest
    
    var displayName: String {
        switch self {
        case .parent:
            return "親"
        case .partner:
            return "パートナー"
        case .child:
            return "子ども"
        case .guest:
            return "ゲスト"
        }
    }
}