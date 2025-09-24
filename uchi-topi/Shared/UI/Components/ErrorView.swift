import SwiftUI

/// エラー表示ビュー
struct ErrorView: View {
    let error: Error
    let retryAction: (() -> Void)?
    
    init(error: Error, retryAction: (() -> Void)? = nil) {
        self.error = error
        self.retryAction = retryAction
    }
    
    var body: some View {
        VStack(spacing: AppSpacing.large) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 60))
                .foregroundColor(AppColors.error)
                .accessibilityHidden(true)
            
            VStack(spacing: AppSpacing.small) {
                Text("エラーが発生しました")
                    .font(AppFonts.headline())
                    .foregroundColor(AppColors.primaryText)
                
                Text(error.localizedDescription)
                    .font(AppFonts.body())
                    .foregroundColor(AppColors.secondaryText)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            if let retryAction = retryAction {
                Button(action: retryAction) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("再試行")
                    }
                    .font(AppFonts.body())
                    .foregroundColor(.white)
                    .padding(.horizontal, AppSpacing.large)
                    .padding(.vertical, AppSpacing.small)
                    .background(AppColors.primary)
                    .cornerRadius(AppSpacing.buttonRadius)
                }
                .accessibilityLabel("再試行する")
                .accessibilityHint("タップしてもう一度試します")
            }
        }
        .padding(AppSpacing.xxLarge)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("エラー: \(error.localizedDescription)")
    }
}

// MARK: - Error Alert Modifier
struct ErrorAlert: ViewModifier {
    let error: Binding<Error?>
    let buttonTitle: String
    let retryAction: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .alert(
                "エラー",
                isPresented: .constant(error.wrappedValue != nil),
                presenting: error.wrappedValue
            ) { _ in
                if let retryAction = retryAction {
                    Button("再試行", action: retryAction)
                    Button("キャンセル", role: .cancel) {
                        error.wrappedValue = nil
                    }
                } else {
                    Button(buttonTitle) {
                        error.wrappedValue = nil
                    }
                }
            } message: { error in
                Text(error.localizedDescription)
            }
    }
}

extension View {
    /// エラーアラートを表示
    func errorAlert(
        error: Binding<Error?>,
        buttonTitle: String = "OK",
        retryAction: (() -> Void)? = nil
    ) -> some View {
        modifier(ErrorAlert(
            error: error,
            buttonTitle: buttonTitle,
            retryAction: retryAction
        ))
    }
}

// MARK: - Preview
#Preview {
    ErrorView(
        error: NSError(
            domain: "",
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: "ネットワーク接続がありません。インターネット接続を確認してください。"]
        ),
        retryAction: {}
    )
}