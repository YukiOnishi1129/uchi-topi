import Foundation

extension String {
    
    // MARK: - Validation
    
    /// 空文字列かどうかをチェック（空白文字を除去）
    var isBlank: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// メールアドレス形式かどうかをチェック
    var isValidEmail: Bool {
        let emailRegex = Constants.Regex.email
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
    
    /// 招待コード形式かどうかをチェック
    var isValidInviteCode: Bool {
        let codeRegex = Constants.Regex.inviteCode
        let predicate = NSPredicate(format: "SELF MATCHES %@", codeRegex)
        return predicate.evaluate(with: self.uppercased())
    }
    
    // MARK: - Trimming
    
    /// 前後の空白と改行を削除
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// 全ての空白を削除
    var withoutSpaces: String {
        components(separatedBy: .whitespaces).joined()
    }
    
    // MARK: - Formatting
    
    /// 最初の文字を大文字に変換
    var firstUppercased: String {
        prefix(1).uppercased() + dropFirst()
    }
    
    /// キャメルケースをスペース区切りに変換
    var camelCaseToWords: String {
        unicodeScalars.reduce("") { (result, scalar) in
            if CharacterSet.uppercaseLetters.contains(scalar) {
                return result + " " + String(scalar)
            } else {
                return result + String(scalar)
            }
        }.trimmed
    }
    
    // MARK: - Truncation
    
    /// 指定された長さで切り詰め（省略記号付き）
    func truncated(to length: Int, trailing: String = "...") -> String {
        if count > length {
            return String(prefix(length)) + trailing
        }
        return self
    }
    
    // MARK: - Random Generation
    
    /// ランダムな招待コードを生成
    static func randomInviteCode() -> String {
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<Constants.Limits.inviteCodeLength).compactMap { _ in
            characters.randomElement()
        })
    }
    
    // MARK: - URL Encoding
    
    /// URLエンコード
    var urlEncoded: String? {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    /// URLデコード
    var urlDecoded: String? {
        removingPercentEncoding
    }
    
    // MARK: - Localization
    
    /// ローカライズされた文字列を取得
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    /// パラメータ付きローカライズ
    func localized(with arguments: CVarArg...) -> String {
        String(format: localized, arguments: arguments)
    }
    
    // MARK: - File Size Formatting
    
    /// バイト数を人間が読みやすい形式に変換
    static func formattedFileSize(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.countStyle = .file
        return formatter.string(fromByteCount: bytes)
    }
}

// MARK: - Substring Extensions
extension String {
    
    /// 安全な範囲でのsubstring取得
    subscript(safe range: Range<Int>) -> String? {
        guard range.lowerBound >= 0,
              range.upperBound <= count else {
            return nil
        }
        
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = index(self.startIndex, offsetBy: range.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

// MARK: - Optional String Extensions
extension Optional where Wrapped == String {
    
    /// オプショナル文字列が空かどうかをチェック
    var isNilOrEmpty: Bool {
        switch self {
        case .none:
            return true
        case .some(let value):
            return value.isEmpty
        }
    }
    
    /// オプショナル文字列が空白かどうかをチェック（空白文字を除去）
    var isNilOrBlank: Bool {
        switch self {
        case .none:
            return true
        case .some(let value):
            return value.isBlank
        }
    }
}