import Foundation

/// アプリケーション定数
enum Constants {
    
    // MARK: - App Info
    enum App {
        static let name = "うちトピ"
        static let bundleIdentifier = Bundle.main.bundleIdentifier ?? ""
        static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        static let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
    
    // MARK: - Firebase Collections
    enum Collections {
        static let users = "users"
        static let families = "families"
        static let members = "members"
        static let threads = "threads"
        static let messages = "messages"
        static let reads = "reads"
        static let topics = "topics"
        static let checklist = "checklist"
        static let comments = "comments"
        static let activity = "activity"
        static let notifications = "notifications"
        static let invites = "invites"
    }
    
    // MARK: - User Defaults Keys
    enum UserDefaultsKeys {
        static let isFirstLaunch = "isFirstLaunch"
        static let selectedFamilyId = "selectedFamilyId"
        static let notificationEnabled = "notificationEnabled"
        static let theme = "theme"
        static let language = "language"
    }
    
    // MARK: - Notification Names
    enum NotificationNames {
        static let userDidLogin = Foundation.Notification.Name("userDidLogin")
        static let userDidLogout = Foundation.Notification.Name("userDidLogout")
        static let familyDidChange = Foundation.Notification.Name("familyDidChange")
        static let networkStatusChanged = Foundation.Notification.Name("networkStatusChanged")
    }
    
    // MARK: - Time Constants
    enum Time {
        static let animationDuration: Double = 0.3
        static let shortDelay: Double = 0.1
        static let mediumDelay: Double = 0.5
        static let longDelay: Double = 1.0
        static let inviteCodeTTL: TimeInterval = 86400 // 24時間
        static let messageCacheExpiry: TimeInterval = 3600 // 1時間
    }
    
    // MARK: - Limits
    enum Limits {
        static let maxFamilyMembers = 20
        static let maxMessageLength = 1000
        static let maxTaskTitleLength = 100
        static let maxTaskDescriptionLength = 500
        static let maxAttachmentSize: Int64 = 10 * 1024 * 1024 // 10MB
        static let maxImagesPerMessage = 10
        static let inviteCodeLength = 6
    }
    
    // MARK: - Pagination
    enum Pagination {
        static let defaultPageSize = 20
        static let messagesPageSize = 50
        static let tasksPageSize = 30
        static let notificationsPageSize = 20
    }
    
    // MARK: - API Keys (プレースホルダー)
    enum API {
        // 実際のキーは環境変数やConfiguration fileで管理
        static let firebaseAPIKey = ""
        static let firebaseProjectId = ""
    }
    
    // MARK: - Regular Expressions
    enum Regex {
        static let email = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"#
        static let inviteCode = #"^[A-Z0-9]{6}$"#
    }
    
    // MARK: - Date Formats
    enum DateFormat {
        static let full = "yyyy年M月d日 HH:mm"
        static let short = "M/d HH:mm"
        static let time = "HH:mm"
        static let date = "yyyy/MM/dd"
        static let monthDay = "M月d日"
        static let yearMonth = "yyyy年M月"
    }
}