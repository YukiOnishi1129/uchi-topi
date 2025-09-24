import Foundation

/// バリデーションエラー
enum ValidationError: LocalizedError {
    case empty
    case tooShort(min: Int)
    case tooLong(max: Int)
    case invalidFormat
    case invalidEmail
    case invalidInviteCode
    case custom(String)
    
    var errorDescription: String? {
        switch self {
        case .empty:
            return "入力してください"
        case .tooShort(let min):
            return "\(min)文字以上入力してください"
        case .tooLong(let max):
            return "\(max)文字以内で入力してください"
        case .invalidFormat:
            return "形式が正しくありません"
        case .invalidEmail:
            return "メールアドレスの形式が正しくありません"
        case .invalidInviteCode:
            return "招待コードは6桁の英数字で入力してください"
        case .custom(let message):
            return message
        }
    }
}

/// バリデーター
struct Validator {
    
    // MARK: - String Validations
    
    /// 空文字チェック
    static func notEmpty(_ value: String?) throws -> String {
        guard let value = value, !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw ValidationError.empty
        }
        return value
    }
    
    /// 文字数チェック
    static func length(_ value: String, min: Int? = nil, max: Int? = nil) throws -> String {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let min = min, trimmed.count < min {
            throw ValidationError.tooShort(min: min)
        }
        
        if let max = max, trimmed.count > max {
            throw ValidationError.tooLong(max: max)
        }
        
        return value
    }
    
    /// メールアドレスバリデーション
    static func email(_ value: String) throws -> String {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        let regex = try NSRegularExpression(pattern: Constants.Regex.email)
        let range = NSRange(location: 0, length: trimmed.utf16.count)
        
        guard regex.firstMatch(in: trimmed, options: [], range: range) != nil else {
            throw ValidationError.invalidEmail
        }
        
        return trimmed.lowercased()
    }
    
    /// 招待コードバリデーション
    static func inviteCode(_ value: String) throws -> String {
        let uppercased = value.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let regex = try NSRegularExpression(pattern: Constants.Regex.inviteCode)
        let range = NSRange(location: 0, length: uppercased.utf16.count)
        
        guard regex.firstMatch(in: uppercased, options: [], range: range) != nil else {
            throw ValidationError.invalidInviteCode
        }
        
        return uppercased
    }
    
    // MARK: - Task Validations
    
    /// タスクタイトルバリデーション
    static func taskTitle(_ value: String) throws -> String {
        let trimmed = try notEmpty(value)
        return try length(trimmed, min: 1, max: Constants.Limits.maxTaskTitleLength)
    }
    
    /// タスク説明バリデーション
    static func taskDescription(_ value: String) throws -> String {
        return try length(value, max: Constants.Limits.maxTaskDescriptionLength)
    }
    
    // MARK: - Message Validations
    
    /// メッセージ本文バリデーション
    static func messageBody(_ value: String) throws -> String {
        let trimmed = try notEmpty(value)
        return try length(trimmed, min: 1, max: Constants.Limits.maxMessageLength)
    }
    
    // MARK: - Date Validations
    
    /// 未来日付チェック
    static func futureDate(_ date: Date) throws -> Date {
        guard date > Date() else {
            throw ValidationError.custom("未来の日時を選択してください")
        }
        return date
    }
    
    /// 日付範囲チェック
    static func dateRange(start: Date, end: Date) throws -> (Date, Date) {
        guard start < end else {
            throw ValidationError.custom("開始日時は終了日時より前に設定してください")
        }
        return (start, end)
    }
    
    // MARK: - Family Validations
    
    /// 家族名バリデーション
    static func familyName(_ value: String) throws -> String {
        let trimmed = try notEmpty(value)
        return try length(trimmed, min: 1, max: 50)
    }
    
    /// 表示名バリデーション
    static func displayName(_ value: String) throws -> String {
        let trimmed = try notEmpty(value)
        return try length(trimmed, min: 1, max: 30)
    }
}

// MARK: - Validation Result
struct ValidationResult {
    let isValid: Bool
    let error: ValidationError?
    
    static func success() -> ValidationResult {
        ValidationResult(isValid: true, error: nil)
    }
    
    static func failure(_ error: ValidationError) -> ValidationResult {
        ValidationResult(isValid: false, error: error)
    }
}