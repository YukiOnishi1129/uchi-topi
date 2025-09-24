import SwiftUI

/// 空状態表示ビュー
struct EmptyStateView: View {
    let title: String
    let message: String
    let systemImage: String
    let action: EmptyStateAction?
    
    init(
        title: String,
        message: String,
        systemImage: String = "tray",
        action: EmptyStateAction? = nil
    ) {
        self.title = title
        self.message = message
        self.systemImage = systemImage
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: AppSpacing.large) {
            Spacer()
            
            Image(systemName: systemImage)
                .font(.system(size: 80))
                .foregroundColor(AppColors.tertiaryText)
                .accessibilityHidden(true)
            
            VStack(spacing: AppSpacing.small) {
                Text(title)
                    .font(AppFonts.title3())
                    .foregroundColor(AppColors.primaryText)
                    .multilineTextAlignment(.center)
                
                Text(message)
                    .font(AppFonts.body())
                    .foregroundColor(AppColors.secondaryText)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, AppSpacing.large)
            }
            
            if let action = action {
                Button(action: action.handler) {
                    HStack {
                        if let icon = action.icon {
                            Image(systemName: icon)
                        }
                        Text(action.title)
                    }
                    .font(AppFonts.body())
                    .foregroundColor(.white)
                    .padding(.horizontal, AppSpacing.large)
                    .padding(.vertical, AppSpacing.small)
                    .background(AppColors.primary)
                    .cornerRadius(AppSpacing.buttonRadius)
                }
                .padding(.top, AppSpacing.medium)
                .accessibilityLabel(action.title)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title). \(message)")
    }
}

/// 空状態アクション
struct EmptyStateAction {
    let title: String
    let icon: String?
    let handler: () -> Void
    
    init(title: String, icon: String? = nil, handler: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.handler = handler
    }
}

// MARK: - Common Empty States
extension EmptyStateView {
    /// メッセージがない場合の空状態
    static func noMessages(action: (() -> Void)? = nil) -> EmptyStateView {
        EmptyStateView(
            title: "メッセージがありません",
            message: "新しい会話を始めましょう",
            systemImage: "message",
            action: action != nil ? EmptyStateAction(
                title: "メッセージを送る",
                icon: "plus",
                handler: action!
            ) : nil
        )
    }
    
    /// タスクがない場合の空状態
    static func noTasks(action: (() -> Void)? = nil) -> EmptyStateView {
        EmptyStateView(
            title: "タスクがありません",
            message: "新しいタスクを作成して、やることを管理しましょう",
            systemImage: "checklist",
            action: action != nil ? EmptyStateAction(
                title: "タスクを作成",
                icon: "plus",
                handler: action!
            ) : nil
        )
    }
    
    /// イベントがない場合の空状態
    static func noEvents(action: (() -> Void)? = nil) -> EmptyStateView {
        EmptyStateView(
            title: "イベントがありません",
            message: "家族の予定を追加しましょう",
            systemImage: "calendar",
            action: action != nil ? EmptyStateAction(
                title: "イベントを作成",
                icon: "plus",
                handler: action!
            ) : nil
        )
    }
    
    /// 検索結果がない場合の空状態
    static func noSearchResults() -> EmptyStateView {
        EmptyStateView(
            title: "検索結果がありません",
            message: "別のキーワードで検索してみてください",
            systemImage: "magnifyingglass"
        )
    }
}

// MARK: - Preview
#Preview {
    VStack {
        EmptyStateView.noMessages {
            print("Create message tapped")
        }
    }
}