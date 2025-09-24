1. プロジェクト概要
	•	名称：おうちトピック（愛称：うちトピ）
	•	コンセプト：
「家事も、旅行も、行事も。家族の“やること”と“会話”を1つにまとめるアプリ」
	•	目的：
家族間のコミュニケーションを活性化し、「言った・言わない」問題をなくす。
家事・予定・イベント・旅行など日常のあらゆるタスクを一元管理し、会話と紐づけて整理する。
	•	ターゲット：
	•	一次：夫婦（共働き、家事分担を明確化したい層）
	•	二次：子ども、祖父母、同居/別居の家族メンバー、ゲスト（家庭教師・シッター等）

⸻

2. 提供価値（Value Proposition）
	1.	会話から行動へ
	•	チャットのメッセージを1タップでタスク化
	•	タスクには元メッセージへのリンクを保持 → 「なぜやるのか」が履歴で追える
	2.	家族のやること全体を一元化
	•	家事・イベント・旅行・行事までまとめて管理
	•	カレンダー連携で見える化
	3.	家族専用コミュニケーション
	•	LINEにはない「家族専用」の整理された空間
	•	役割ごとのUI（夫婦＝管理、子ども＝確認＋ご褒美）

⸻

3. ユースケース
	•	夫婦：
	•	「ゴミ出し・買い物・支払い」をスレッドで決定 → タスク化 → 担当を割り当て
	•	「旅行計画」スレッドで話した内容がイベントに変換され、カレンダー表示
	•	子ども：
	•	宿題やお手伝いのタスクを自分の端末で確認
	•	完了時に「ご褒美ポイント」やスタンプを受け取る
	•	祖父母：
	•	行事や通院予定を参照
	•	コメントやリアクションで参加

⸻

4. 機能要件

4.1 トーク（スレッド）
	•	家族内の話題ごとにスレッド作成（例：旅行、買い物、学校行事）
	•	メッセージ投稿（テキスト、画像、ファイル）
	•	タスク化機能：メッセージ右上の「＋タスク化」ボタン → タスク作成
	•	履歴リンク：タスク詳細から元メッセージにジャンプ

4.2 トピック（タスク/イベント）
	•	種別：task / event / note
	•	項目：タイトル、説明、担当、期限、優先度、ラベル
	•	チェックリスト、コメント、履歴（activity log）
	•	カレンダー表示（eventとdue付きタスク）

4.3 カレンダー
	•	月/週ビュー
	•	予定やタスク期限を投影
	•	タップで詳細、編集可能

4.4 通知
	•	新規メッセージ、担当タスク変更、期限前リマインド
	•	個別ON/OFF、静音時間帯設定

4.5 ご褒美機能
	•	タスク完了でポイント・スタンプ付与
	•	子どもUIでは「ご褒美履歴」を表示

4.6 メンバー管理
	•	親/パートナーが「招待コード/QR」発行 → 端末ペアリング
	•	仮想アカウント方式：子どもはメール・電話不要で参加
	•	役割：parent / partner / child / guest

⸻

5. 非機能要件
	•	UI/UX：白ベース＋淡色、余白多め、直感操作、VoiceOver対応
	•	技術：SwiftUI + Firebase（Auth, Firestore, FCM, Functions）
	•	セキュリティ：招待コードは短TTL＋1回使い切り、ロールベースアクセス
	•	多言語対応：日本語/英語

⸻

6. Firestore設計（主要コレクション）
	•	users：{ displayName, role, families[], fcmTokens[] }
	•	families：{ name, inviteCode, createdBy }
	•	members/{memberId}：{ userId, role, joinedAt }
	•	threads：{ familyId, title, lastMessageAt }
	•	messages/{messageId}：{ authorId, body, createdAt }
	•	reads/{userId}：{ lastReadAt }
	•	topics：{ type, title, assigneeId, status, startAt, dueAt, sourceMessageId }
	•	checklist / comments / activity
	•	notifications：{ userId, familyId, kind, ref, createdAt, readAt }
	•	invites：{ familyId, role, code, qrPayload, status, expiresAt }

⸻

7. KPI
	•	夫婦双方の週次アクティブ率
	•	会話→タスク化率
	•	タスク期限内完了率
	•	子どもタスク完了数（ご褒美利用率）



