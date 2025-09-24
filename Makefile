# うちトピ iOS App Makefile
# VS Codeから簡単にビルド・実行できるコマンド集

.PHONY: help build clean run install launch simulator list-devices test

# デフォルトのシミュレーターID (iPhone 16)
SIMULATOR_ID = D7F1BFA2-4B11-4480-88AE-DE9253698A20
SIMULATOR_NAME = iPhone 16
SCHEME = uchi-topi
BUNDLE_ID = com.yuki.uchi-topi

# ヘルプを表示
help:
	@echo "利用可能なコマンド:"
	@echo "  make build       - アプリをビルド"
	@echo "  make run         - ビルド、インストール、起動を一括実行"
	@echo "  make install     - アプリをシミュレーターにインストール"
	@echo "  make launch      - インストール済みのアプリを起動"
	@echo "  make simulator   - シミュレーターを起動"
	@echo "  make list        - 利用可能なシミュレーターを表示"
	@echo "  make test        - テストを実行"
	@echo "  make clean       - ビルドをクリーン"
	@echo "  make reset-sim   - シミュレーターをリセット"

# アプリをビルド
build:
	@echo "🔨 アプリをビルドしています..."
	xcodebuild -scheme $(SCHEME) \
		-sdk iphonesimulator \
		-configuration Debug \
		-derivedDataPath build \
		build

# ビルドをクリーン
clean:
	@echo "🧹 ビルドをクリーンしています..."
	xcodebuild -scheme $(SCHEME) clean
	rm -rf build/

# シミュレーターを起動
simulator:
	@echo "📱 シミュレーター ($(SIMULATOR_NAME)) を起動しています..."
	xcrun simctl boot $(SIMULATOR_ID) || true
	open -a Simulator

# アプリをインストール
install: build
	@echo "📲 アプリをインストールしています..."
	xcrun simctl install $(SIMULATOR_ID) build/Build/Products/Debug-iphonesimulator/$(SCHEME).app

# アプリを起動
launch:
	@echo "🚀 アプリを起動しています..."
	xcrun simctl launch $(SIMULATOR_ID) $(BUNDLE_ID)

# ビルド、インストール、起動を一括実行
run: simulator install launch
	@echo "✅ アプリが起動しました！"

# 利用可能なシミュレーターを表示
list:
	@echo "📱 利用可能なiPhoneシミュレーター:"
	@xcrun simctl list devices | grep -i "iphone" | grep -E "(Booted|Shutdown)" | grep -v "unavailable"

# 特定のシミュレーターでアプリを実行 (例: make run-on DEVICE_ID=xxx)
run-on:
ifndef DEVICE_ID
	@echo "❌ DEVICE_IDを指定してください。例: make run-on DEVICE_ID=xxx"
	@echo "利用可能なデバイスを確認するには 'make list' を実行してください"
else
	@echo "📱 指定されたシミュレーター ($(DEVICE_ID)) で実行しています..."
	xcrun simctl boot $(DEVICE_ID) || true
	open -a Simulator
	$(MAKE) SIMULATOR_ID=$(DEVICE_ID) install launch
endif

# テストを実行
test:
	@echo "🧪 テストを実行しています..."
	xcodebuild test \
		-scheme $(SCHEME) \
		-sdk iphonesimulator \
		-destination 'platform=iOS Simulator,id=$(SIMULATOR_ID)'

# シミュレーターをリセット
reset-sim:
	@echo "🔄 シミュレーターをリセットしています..."
	xcrun simctl shutdown $(SIMULATOR_ID) || true
	xcrun simctl erase $(SIMULATOR_ID)
	@echo "✅ シミュレーターがリセットされました"

# デバッグ用：現在のビルド設定を表示
info:
	@echo "📋 現在の設定:"
	@echo "  スキーム: $(SCHEME)"
	@echo "  バンドルID: $(BUNDLE_ID)"
	@echo "  シミュレーターID: $(SIMULATOR_ID)"
	@echo "  シミュレーター名: $(SIMULATOR_NAME)"

# スクリーンショットを撮る
screenshot:
	@echo "📸 スクリーンショットを撮影しています..."
	xcrun simctl io $(SIMULATOR_ID) screenshot screenshot-$$(date +%Y%m%d-%H%M%S).png
	@echo "✅ スクリーンショットが保存されました"

# アプリのログを表示
logs:
	@echo "📝 アプリのログを表示しています... (Ctrl+C で終了)"
	xcrun simctl spawn $(SIMULATOR_ID) log stream --predicate 'bundleID == "$(BUNDLE_ID)"'