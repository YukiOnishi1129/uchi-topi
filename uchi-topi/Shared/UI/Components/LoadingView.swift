import SwiftUI

/// ローディング表示ビュー
struct LoadingView: View {
    let message: String?
    
    init(message: String? = nil) {
        self.message = message
    }
    
    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            ProgressView()
                .scaleEffect(1.5)
                .progressViewStyle(CircularProgressViewStyle(tint: AppColors.primary))
            
            if let message = message {
                Text(message)
                    .font(AppFonts.footnote())
                    .foregroundColor(AppColors.secondaryText)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(AppSpacing.large)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background.opacity(0.95))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("読み込み中" + (message ?? ""))
    }
}

// MARK: - Loading Overlay Modifier
struct LoadingOverlay: ViewModifier {
    let isLoading: Bool
    let message: String?
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .blur(radius: isLoading ? 3 : 0)
            
            if isLoading {
                LoadingView(message: message)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isLoading)
    }
}

extension View {
    /// ローディングオーバーレイを表示
    func loadingOverlay(isLoading: Bool, message: String? = nil) -> some View {
        modifier(LoadingOverlay(isLoading: isLoading, message: message))
    }
}

// MARK: - Preview
#Preview {
    VStack {
        LoadingView()
        
        Divider()
        
        LoadingView(message: "データを読み込んでいます...")
    }
}