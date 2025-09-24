import SwiftUI

/// アプリケーションのフォントスタイル
struct AppFonts {
    // MARK: - Title Fonts
    static func largeTitle(_ size: CGFloat = 34) -> Font {
        .system(size: size, weight: .bold, design: .rounded)
    }
    
    static func title1(_ size: CGFloat = 28) -> Font {
        .system(size: size, weight: .bold, design: .rounded)
    }
    
    static func title2(_ size: CGFloat = 22) -> Font {
        .system(size: size, weight: .semibold, design: .rounded)
    }
    
    static func title3(_ size: CGFloat = 20) -> Font {
        .system(size: size, weight: .semibold, design: .rounded)
    }
    
    // MARK: - Body Fonts
    static func headline(_ size: CGFloat = 17) -> Font {
        .system(size: size, weight: .semibold)
    }
    
    static func body(_ size: CGFloat = 17) -> Font {
        .system(size: size, weight: .regular)
    }
    
    static func callout(_ size: CGFloat = 16) -> Font {
        .system(size: size, weight: .regular)
    }
    
    static func subheadline(_ size: CGFloat = 15) -> Font {
        .system(size: size, weight: .regular)
    }
    
    static func footnote(_ size: CGFloat = 13) -> Font {
        .system(size: size, weight: .regular)
    }
    
    static func caption1(_ size: CGFloat = 12) -> Font {
        .system(size: size, weight: .regular)
    }
    
    static func caption2(_ size: CGFloat = 11) -> Font {
        .system(size: size, weight: .regular)
    }
}

// MARK: - Font Modifiers
struct DynamicTypeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .dynamicTypeSize(.small ... .accessibility3)
    }
}

extension View {
    /// Dynamic Typeに対応したフォントサイズ調整
    func dynamicFont() -> some View {
        modifier(DynamicTypeModifier())
    }
}