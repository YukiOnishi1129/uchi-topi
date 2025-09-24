import Foundation

extension DateFormatter {
    
    /// 共通のDateFormatterインスタンス（パフォーマンス最適化）
    private static let sharedFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        return formatter
    }()
    
    // MARK: - Formatters
    
    /// 完全な日時フォーマット (例: 2024年1月1日 12:00)
    static func fullDateTime(_ date: Date) -> String {
        sharedFormatter.dateFormat = Constants.DateFormat.full
        return sharedFormatter.string(from: date)
    }
    
    /// 短い日時フォーマット (例: 1/1 12:00)
    static func shortDateTime(_ date: Date) -> String {
        sharedFormatter.dateFormat = Constants.DateFormat.short
        return sharedFormatter.string(from: date)
    }
    
    /// 時刻のみ (例: 12:00)
    static func time(_ date: Date) -> String {
        sharedFormatter.dateFormat = Constants.DateFormat.time
        return sharedFormatter.string(from: date)
    }
    
    /// 日付のみ (例: 2024/01/01)
    static func date(_ date: Date) -> String {
        sharedFormatter.dateFormat = Constants.DateFormat.date
        return sharedFormatter.string(from: date)
    }
    
    /// 月日のみ (例: 1月1日)
    static func monthDay(_ date: Date) -> String {
        sharedFormatter.dateFormat = Constants.DateFormat.monthDay
        return sharedFormatter.string(from: date)
    }
    
    /// 年月のみ (例: 2024年1月)
    static func yearMonth(_ date: Date) -> String {
        sharedFormatter.dateFormat = Constants.DateFormat.yearMonth
        return sharedFormatter.string(from: date)
    }
    
    // MARK: - Relative Formatters
    
    /// 相対的な時間表示 (例: 5分前、昨日、など)
    static func relative(_ date: Date, from referenceDate: Date = Date()) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: referenceDate)
        
        if let year = components.year, year > 0 {
            return "\(year)年前"
        } else if let month = components.month, month > 0 {
            return "\(month)ヶ月前"
        } else if let day = components.day {
            if day > 7 {
                return "\(day / 7)週間前"
            } else if day > 1 {
                return "\(day)日前"
            } else if day == 1 {
                return "昨日"
            }
        } else if let hour = components.hour {
            if hour > 0 {
                return "\(hour)時間前"
            }
        } else if let minute = components.minute {
            if minute > 0 {
                return "\(minute)分前"
            }
        }
        
        return "たった今"
    }
    
    /// チャット用の時間表示
    static func chatTime(_ date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDateInToday(date) {
            return time(date)
        } else if calendar.isDateInYesterday(date) {
            return "昨日 " + time(date)
        } else if calendar.isDate(date, equalTo: now, toGranularity: .weekOfYear) {
            let weekday = calendar.component(.weekday, from: date)
            let weekdaySymbols = ["日", "月", "火", "水", "木", "金", "土"]
            return weekdaySymbols[weekday - 1] + "曜日 " + time(date)
        } else {
            return shortDateTime(date)
        }
    }
    
    // MARK: - Duration Formatters
    
    /// 期間の表示 (例: 1時間30分)
    static func duration(from start: Date, to end: Date) -> String {
        let interval = end.timeIntervalSince(start)
        let hours = Int(interval) / 3600
        let minutes = Int(interval) % 3600 / 60
        
        if hours > 0 && minutes > 0 {
            return "\(hours)時間\(minutes)分"
        } else if hours > 0 {
            return "\(hours)時間"
        } else {
            return "\(minutes)分"
        }
    }
}

// MARK: - Date Extensions
extension Date {
    
    /// カレンダーの開始日（月の最初の日）
    var startOfMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components) ?? self
    }
    
    /// カレンダーの終了日（月の最後の日）
    var endOfMonth: Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth) ?? self
    }
    
    /// 日の開始時刻（00:00:00）
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    /// 日の終了時刻（23:59:59）
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay) ?? self
    }
    
    /// 今日かどうか
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    /// 昨日かどうか
    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }
    
    /// 明日かどうか
    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }
    
    /// 今週かどうか
    var isThisWeek: Bool {
        Calendar.current.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }
    
    /// 過去の日付かどうか
    var isPast: Bool {
        self < Date()
    }
    
    /// 未来の日付かどうか
    var isFuture: Bool {
        self > Date()
    }
}