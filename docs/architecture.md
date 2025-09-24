# うちトピ アーキテクチャ設計書

## 概要
本ドキュメントは「うちトピ」iOSアプリケーションの技術アーキテクチャを定義します。

## アーキテクチャ原則

### 1. 基本原則
- **MVVM + Clean Architecture**: ビジネスロジックとUIの分離
- **依存関係逆転**: 上位レイヤーは下位レイヤーに依存しない
- **単一責任**: 各クラス・モジュールは単一の責務を持つ
- **テスタビリティ**: 全てのビジネスロジックはテスト可能

### 2. レイヤー構成
```
├── Features/       # 機能別モジュール
├── Core/          # コアビジネスロジック
└── Shared/        # 共通コンポーネント
```

## プロジェクト構造

```
uchi-topi/
├── App/
│   ├── uchi_topiApp.swift      # アプリエントリーポイント
│   ├── AppDelegate.swift       # アプリデリゲート
│   └── Configuration/          # 設定ファイル
│       ├── Info.plist
│       └── GoogleService-Info.plist
│
├── Features/                   # 機能別モジュール
│   ├── Auth/                   # 認証
│   │   ├── Views/
│   │   ├── ViewModels/
│   │   └── Models/
│   ├── Family/                 # 家族管理
│   │   ├── Views/
│   │   ├── ViewModels/
│   │   └── Models/
│   ├── Thread/                 # トーク（スレッド）
│   │   ├── Views/
│   │   ├── ViewModels/
│   │   └── Models/
│   ├── Topic/                  # トピック（タスク/イベント）
│   │   ├── Views/
│   │   ├── ViewModels/
│   │   └── Models/
│   ├── Calendar/               # カレンダー
│   │   ├── Views/
│   │   ├── ViewModels/
│   │   └── Models/
│   └── Notification/           # 通知
│       ├── Views/
│       ├── ViewModels/
│       └── Models/
│
├── Core/                       # コアビジネスロジック
│   ├── Models/                 # データモデル
│   │   ├── User.swift
│   │   ├── Family.swift
│   │   ├── Thread.swift
│   │   ├── Message.swift
│   │   ├── Topic.swift
│   │   └── Notification.swift
│   ├── Services/               # ビジネスロジック
│   │   ├── AuthService.swift
│   │   ├── FamilyService.swift
│   │   ├── ThreadService.swift
│   │   ├── TopicService.swift
│   │   └── NotificationService.swift
│   ├── Repositories/           # データアクセス層
│   │   ├── UserRepository.swift
│   │   ├── FamilyRepository.swift
│   │   ├── ThreadRepository.swift
│   │   └── TopicRepository.swift
│   └── Extensions/             # 拡張
│       ├── Date+Extensions.swift
│       └── String+Extensions.swift
│
├── Shared/                     # 共通コンポーネント
│   ├── UI/                     # UI共通部品
│   │   ├── Components/
│   │   │   ├── LoadingView.swift
│   │   │   ├── ErrorView.swift
│   │   │   └── EmptyView.swift
│   │   ├── Modifiers/
│   │   │   └── ViewModifiers.swift
│   │   └── Styles/
│   │       ├── Colors.swift
│   │       ├── Fonts.swift
│   │       └── Spacing.swift
│   ├── Utilities/              # ユーティリティ
│   │   ├── DateFormatter.swift
│   │   ├── Validator.swift
│   │   └── Constants.swift
│   └── Firebase/               # Firebase設定
│       ├── FirebaseConfig.swift
│       └── FirestoreManager.swift
│
├── Resources/                  # リソース
│   ├── Assets.xcassets/
│   ├── Localizable.strings
│   └── Localizable.strings.en
│
└── Tests/                      # テスト
    ├── uchi-topiTests/
    └── uchi-topiUITests/
```

## 技術スタック

### フロントエンド
- **SwiftUI**: 宣言的UI
- **Combine**: リアクティブプログラミング
- **async/await**: 非同期処理

### バックエンド
- **Firebase Auth**: 認証
- **Cloud Firestore**: データベース
- **Firebase Cloud Messaging**: プッシュ通知
- **Cloud Functions**: サーバーサイドロジック
- **Firebase Storage**: ファイルストレージ

### 開発ツール
- **Xcode 15+**: 開発環境
- **Swift 5.9+**: プログラミング言語
- **SwiftLint**: コード品質管理
- **XCTest**: テストフレームワーク

## データフロー

```
View → ViewModel → Service → Repository → Firebase
  ↑                                           ↓
  └───────────────────────────────────────────┘
```

1. **View**: UIの表示とユーザー操作の受付
2. **ViewModel**: ViewのためのデータとロジックをI提供
3. **Service**: ビジネスロジックの実装
4. **Repository**: データアクセスの抽象化
5. **Firebase**: データの永続化

## 主要パターン

### 1. MVVM (Model-View-ViewModel)
```swift
// View
struct ThreadListView: View {
    @StateObject private var viewModel = ThreadListViewModel()
    
    var body: some View {
        // UI実装
    }
}

// ViewModel
@MainActor
class ThreadListViewModel: ObservableObject {
    @Published var threads: [Thread] = []
    private let threadService: ThreadServiceProtocol
    
    func loadThreads() async {
        // ビジネスロジック呼び出し
    }
}
```

### 2. Repository Pattern
```swift
protocol ThreadRepositoryProtocol {
    func fetchThreads(familyId: String) async throws -> [Thread]
    func createThread(_ thread: Thread) async throws
}

class ThreadRepository: ThreadRepositoryProtocol {
    private let db = Firestore.firestore()
    
    func fetchThreads(familyId: String) async throws -> [Thread] {
        // Firestore実装
    }
}
```

### 3. Dependency Injection
```swift
// Service層でのDI
class ThreadService: ThreadServiceProtocol {
    private let repository: ThreadRepositoryProtocol
    
    init(repository: ThreadRepositoryProtocol = ThreadRepository()) {
        self.repository = repository
    }
}
```

## エラーハンドリング

### エラー型の定義
```swift
enum AppError: LocalizedError {
    case networkError
    case authenticationError
    case validationError(String)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "ネットワークエラーが発生しました"
        case .authenticationError:
            return "認証エラーが発生しました"
        case .validationError(let message):
            return message
        case .unknown:
            return "不明なエラーが発生しました"
        }
    }
}
```

## セキュリティ

### 1. 認証
- Firebase Authによる認証
- 匿名認証から始め、後でアカウント連携
- 子供アカウントは仮想アカウント方式

### 2. 認可
- Firestoreセキュリティルールでfamilyスコープ制御
- ロールベースアクセス制御 (parent/partner/child/guest)

### 3. データ保護
- 機密情報はKeychainに保存
- 通信は全てHTTPS
- ローカルキャッシュの適切な管理

## パフォーマンス最適化

### 1. 画像処理
- 画像の遅延読み込み
- サムネイルとフルサイズの使い分け
- キャッシュ戦略

### 2. データ同期
- Firestoreのオフライン対応
- 差分同期
- ページネーション

### 3. UI最適化
- Viewの再利用
- 不要な再レンダリングの抑制
- 非同期処理の適切な使用

## テスト戦略

### 1. ユニットテスト
- ViewModelのロジックテスト
- Serviceレイヤーのテスト
- Modelのバリデーションテスト

### 2. 統合テスト
- Repository層のテスト（モック使用）
- エンドツーエンドのフロー検証

### 3. UIテスト
- 主要なユーザーフローの自動テスト
- アクセシビリティ検証

## CI/CD

### 1. ビルドパイプライン
- GitHub Actions使用
- 自動テスト実行
- コード品質チェック（SwiftLint）

### 2. デプロイメント
- TestFlight経由でのベータ配信
- 段階的リリース戦略

## モニタリング

### 1. クラッシュレポート
- Firebase Crashlytics

### 2. パフォーマンス監視
- Firebase Performance Monitoring

### 3. 分析
- Firebase Analytics
- カスタムイベントトラッキング

## 命名規約

### 1. ファイル名
- Views: `〇〇View.swift`
- ViewModels: `〇〇ViewModel.swift`
- Models: 単数形 (例: `Thread.swift`)
- Services: `〇〇Service.swift`
- Repositories: `〇〇Repository.swift`

### 2. クラス/構造体名
- PascalCase使用
- 明確で説明的な名前

### 3. 変数/関数名
- camelCase使用
- 動詞で始まる関数名（例: `fetchThreads`）
- Bool値は`is`/`has`プレフィックス

## アクセシビリティ

### 1. VoiceOver対応
- 全てのUIコンポーネントにaccessibilityLabel設定
- accessibilityIdentifier設定（UIテスト用）

### 2. Dynamic Type対応
- システムフォントサイズへの対応

### 3. カラーコントラスト
- WCAG 2.1 AA準拠