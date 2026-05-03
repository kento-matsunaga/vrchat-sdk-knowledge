# ナレッジベース更新履歴

VRChat SDK & Modular Avatar ナレッジベースの週次更新記録。

---

## 2026-05-03

### VRChat SDK（公式ドキュメント確認）

- **SDK 3.10.3**: 前回から変更なし
- PhysBone仕様、Contacts、Constraints、Playable Layers、Animator Parameters: いずれも変更なし
- 出典: https://creators.vrchat.com/releases/

### Modular Avatar（公式ドキュメント確認）

- **最新バージョン v1.16.2**（2026年2月11日リリース）を確認
  - 出典: https://modular-avatar.nadena.dev/docs/changelog

- 未記載だった新コンポーネントを `modular-avatar/components/vrchat-specific.md` に追記:
  - **MA Rename VRChat Collision Tags**（v1.13.0+）
    - ContactsのCollision Tagを自動的にユニーク名にリネーム
    - 複数の配布Prefabが同じタグ名を使っても誤検出されなくなる
    - 出典: https://modular-avatar.nadena.dev/docs/reference/rename-collision-tags
  - **MA Move Independently**（エディタ専用ユーティリティ）
    - 子オブジェクトを動かさずに親オブジェクトのみを移動できる
    - 衣装のHipボーン位置微調整に有用
    - 出典: https://modular-avatar.nadena.dev/docs/reference/move-independently

- `modular-avatar/overview.md` のコンポーネント一覧に上記2コンポーネントを追記
- `community/tips-tools.md` のバージョン情報を更新（MA v1.16.2 を追記）

### 確認済み・変更なし

- VRChat SDK 3.10.3: 前回から変更なし
- PhysBone仕様（Version 1.0/1.1）: 前回から変更なし
- Contacts仕様: 前回から変更なし
- Constraints仕様（6種類）: 前回から変更なし
- Playable Layers仕様: 前回から変更なし
- Animator Parameters: 前回から変更なし
- Modular Avatar Merge Armature、Menu Installer: 前回から変更なし

---

## 2026-04-26

### VRChat SDK（公式ドキュメント確認）

- **SDK 3.10.3** が最新バージョンであることを確認（前回から変更なし）
- 出典: https://creators.vrchat.com/releases/

### Modular Avatar（公式ドキュメント確認）

- **Merge Armature** の Lock Mode 名称を公式ドキュメントに合わせて修正
  - `Base Path` → `単方向`、`Both Paths` → `双方向` に更新
  - 新パラメータを `modular-avatar/components/merge-armature.md` に追記:
    - Reset Position オプション（Also set rotation / Also set local scale / Adjust outfit overall scale）
    - Avoid name collisions（デフォルト ON）
    - Adjust bone names to match target
  - 出典: https://modular-avatar.nadena.dev/docs/reference/merge-armature

### コミュニティTips

- `community/tips-physbone.md`: ふんわりスカート（Hinge型）設定と足コライダー配置を追記
  - Hinge 制限でのスカート設定値（Pull/Momentum/Immobileのカーブ活用）
  - スカート貫通防止のための足コライダー推奨配置（UpperLeg/LowerLeg）
  - 出典: https://note.com/x9n_note/n/nb45abf2f9e5a, https://cgbox.jp/2023/09/01/vrchat-physbone-howto/

- `community/tips-animator-fx.md`: アニメーションクリップの "None" 使用禁止Tipを追記
  - None → `proxy_empty` または空クリップへの置き換え推奨
  - 出典: https://x.com/mimyquality/status/1822551094285021428

- `community/tips-tools.md`: VRC Texture Optimizer を追記
  - GPU ネイティブ圧縮、PC/Quest 両対応の無料テクスチャ最適化ツール
  - 出典: https://booth.pm/ja/items/6915386, https://vrnavi.jp/avatar-weight-saving1/

### 確認済み・変更なし

- PhysBone仕様（Version 1.0/1.1）: 前回から変更なし
- Contacts仕様: 前回から変更なし
- Constraints仕様（6種類）: 前回から変更なし
- Playable Layers仕様: 前回から変更なし
- Animator Parameters: 前回から変更なし（ドキュメント最終更新 2025-12-12）
- Modular Avatar Menu Installer: 前回から変更なし

---

## 2026-04-19

### VRChat SDK（公式ドキュメント確認）

- **SDK 3.10.3**（2026-04-16リリース）を確認
  - 新コンポーネント `VRCRaycast` の導入（ワールド向け）
  - Toon Standardの改善
  - UdonへのVRC+サブスクリプション状態の公開
  - 出典: https://creators.vrchat.com/releases/

- **新ビルトインパラメータ**を `animations/animator-parameters.md` に追記
  - `IsAnimatorEnabled`（Bool）: アニメーター有効/無効状態の検出
  - `IsOnFriendsList`（Bool）: 着用者がフレンドリストにいるか判定
  - 出典: https://creators.vrchat.com/avatars/animator-parameters/

- **Expression Parameters**の仕様補足を追記
  - 最大登録数 8192個（256bit制限内）
  - マルチプラットフォーム時はリスト順・型の一致が必須（名前では同期しない）

### コミュニティTips

- `community/tips-animator-fx.md`: FX Layerテンプレートのベストプラクティスを追記
  - `proxy_empty`（VRCSDK 3.9.0+）の使用推奨
  - `Is Animated` フラグの適切な活用
  - 出典: https://booth.pm/ja/items/4301775

- `community/tips-tools.md`: Modular Avatarの便利ショートカットを追記
  - Hierarchy右クリック → `Modular Avatar > Create Toggle` で素早くトグル作成
  - 出典: https://vrnavi.jp/modular-avatar-komono/
  - SDKバージョン情報を 3.10.3 に更新

### 確認済み・変更なし

- PhysBone仕様（Version 1.0/1.1）: 前回から変更なし
- Contacts仕様: 前回から変更なし
- Constraints仕様（6種類）: 前回から変更なし
- Playable Layers仕様: 前回から変更なし
- Modular Avatar（Merge Armature、Menu Installer）: 前回から変更なし
