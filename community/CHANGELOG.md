# ナレッジベース更新履歴

VRChat SDK & Modular Avatar ナレッジベースの週次更新記録。

---

## 2026-05-31

### VRChat SDK（公式ドキュメント確認）

- **SDK 3.10.3**: 前回から変更なし
- PhysBone仕様、Contacts、Constraints、Playable Layers、Animator Parameters: いずれも変更なし
- 出典: https://creators.vrchat.com/releases/

### Modular Avatar（公式ドキュメント確認）

- **最新バージョン v1.17.1**: 前回から変更なし（2026-05-14 リリース済み）
- Merge Armature、Menu Installer: 変更なし
- 出典: https://modular-avatar.nadena.dev/docs/changelog

### コミュニティTips

- `community/tips-physbone.md` に以下を追記（最終更新日も更新）:

  - **Simplified モード 黄金比クイックリファレンス**（新セクション）
    - ふわふわ系（髪・ケモ耳）: Pull 0.1 / Spring 0.6 / Immobility 0.3
    - ぷるぷる系（胸・柔らかい肉）: Pull 0.1 / Spring 0.8 / Immobility 0.5
    - ひらひら系（スカート・布）: Pull 0.2 / Spring 0.4 / Immobility 0.6
    - 出典: https://vrc-step.com/vrc-avatar-physbones/

  - **掴み・固定の制御（新セクション）**
    - Allow Posing = false で他ユーザーのポーズ固定を禁止
    - **複数PhysBoneで構成される部位は全コンポーネントに同一設定が必要**（よくある抜け漏れ）
    - 出典: https://vrnavi.jp/physbone-fix/

  - **パフォーマンス節約テクニック**に `AAO Merge PhysBone` を追記

- `community/tips-tools.md` に以下を更新（最終更新日も更新）:

  - **AvatarOptimizer (AAO) にバージョン情報 1.9.14 を追記**
    - 主要機能に `Merge PhysBone` を追加
    - 出典: https://vpm.anatawa12.com/avatar-optimizer/en/

  - **バージョン・互換性情報テーブル** に `AvatarOptimizer (AAO) 1.9.14` 行を追加

### 確認済み・変更なし

- VRChat SDK 3.10.3: 前回から変更なし
- PhysBone仕様（Version 1.0/1.1）: 前回から変更なし
- Contacts仕様: 前回から変更なし
- Constraints仕様（6種類）: 前回から変更なし
- Playable Layers仕様: 前回から変更なし
- Animator Parameters（IsAnimatorEnabled、IsOnFriendsList含む）: 前回から変更なし
- Modular Avatar Merge Armature、Menu Installer: 前回から変更なし

---

## 2026-05-24

### VRChat SDK（公式ドキュメント確認）

- **SDK 3.10.3**: 前回から変更なし
- PhysBone仕様、Contacts、Constraints、Playable Layers、Animator Parameters: いずれも変更なし
- 出典: https://creators.vrchat.com/releases/

### Modular Avatar（公式ドキュメント確認）

- **最新バージョン v1.17.1**: 前回から変更なし（2026-05-14 リリース済み）
- 出典: https://modular-avatar.nadena.dev/docs/changelog

- **v1.17.0 追記漏れを補完: MA Bone Proxy に Match Scale オプション追加**
  - Bone Proxy コンポーネントに「Match scale」オプションが追加（v1.17.0）
  - 参照先ボーンのスケールに自動的に合わせる機能
  - `community/tips-tools.md` の MA Bone Proxy 説明行に追記

### コミュニティTips

- `community/tips-animator-fx.md` に以下を追記（最終更新日も更新）:

  - **FX Controller の Layer Weight 設定（よくある落とし穴）**
    - FX Controller に新しいレイヤーを追加した際、デフォルトの Weight が 0 のままだとアニメーションが一切再生されない
    - Animator ウィンドウで歯車アイコン → Weight を 1.0 に設定すること
    - 出典: https://signyamo.blog/vrchat_playable-layers/

  - **パラメーター名の命名規則**
    - 半角英数字とアンダースコアのみ推奨（日本語などのマルチバイト文字は不可）
    - 大文字・小文字は区別される
    - 出典: https://note.com/ninado/n/nc1c5806ab024

### 確認済み・変更なし

- VRChat SDK 3.10.3: 前回から変更なし
- PhysBone仕様（Version 1.0/1.1）: 前回から変更なし
- Contacts仕様: 前回から変更なし
- Constraints仕様（6種類）: 前回から変更なし
- Playable Layers仕様: 前回から変更なし
- Animator Parameters（IsAnimatorEnabled、IsOnFriendsList含む）: 前回から変更なし
- Modular Avatar Merge Armature、Menu Installer: 前回から変更なし

---

## 2026-05-17

### Modular Avatar（公式ドキュメント確認）

- **バージョン更新: v1.16.2 → v1.17.1**
  - 出典: https://modular-avatar.nadena.dev/docs/changelog

- **v1.17.0**（2026-05-11）主な変更点:
  - 新コンポーネント `MA Floor Adjuster` 追加: 靴底がワールドの床に合うようアバターの垂直位置を自動調整
  - VRCRaycastコンポーネントとパラメータのサポート追加（SDK 3.10.3の新コンポーネントに対応）
  - BlendShapeピッカーにマルチセレクト機能追加

- **v1.17.1**（2026-05-14）:
  - MA Floor Adjuster の実行順序を修正: TexTransToolなど既存のNDMFプラグインの後に実行されるように変更

- 更新ファイル:
  - `modular-avatar/overview.md`: MA Floor Adjusterをコンポーネント一覧に追記
  - `modular-avatar/components/floor-adjuster.md`: 新規作成
  - `community/tips-tools.md`: バージョン情報を v1.17.1 に更新、新コンポーネント情報追記

### VRChat SDK（公式ドキュメント確認）

- **SDK 3.10.3**: 前回から変更なし
- PhysBone仕様、Contacts、Constraints、Playable Layers、Animator Parameters: いずれも変更なし
- 出典: https://creators.vrchat.com/releases/

### コミュニティTips

- `community/tips-tools.md` に以下を追記:

  - **SDKトラブルシューティング: Missing Credentials エラー対処法**
    - VRChat Control Panel → Authentication → Logout → 再ログインで解決するケースが多い
    - Logs/Library フォルダ削除で解決する場合もある
    - 出典: https://zenn.dev/yrd_gs/articles/b123e9fee91ff9

  - **パフォーマンスランク Excellent の数値基準**
    - Triangles 32,000以下 / Texture Memory 40MB以下 / Skinned Meshes 1個以下 / Material Slots 4個以下
    - AAO + lilAvatarUtils + ActualPerformanceWindowを組み合わせた最適化フロー
    - 出典: https://qiita.com/Hellcat_152/items/ad1b1ceb2504bc39c0a4

### 確認済み・変更なし

- VRChat SDK 3.10.3: 前回から変更なし
- PhysBone仕様（Version 1.0/1.1）: 前回から変更なし
- Contacts仕様: 前回から変更なし
- Constraints仕様（6種類）: 前回から変更なし
- Playable Layers仕様: 前回から変更なし
- Animator Parameters（IsAnimatorEnabled、IsOnFriendsList含む）: 前回から変更なし
- Modular Avatar Merge Armature、Menu Installer: 前回から変更なし

---

## 2026-05-10

### VRChat SDK（公式ドキュメント確認）

- **SDK 3.10.3**: 前回から変更なし
- PhysBone仕様、Contacts、Constraints、Playable Layers、Animator Parameters: いずれも変更なし
- 出典: https://creators.vrchat.com/releases/

### Modular Avatar（公式ドキュメント確認）

- **最新バージョン v1.16.2**: 前回から変更なし（2026年2月11日リリースのまま）
- Merge Armature、Menu Installer: 変更なし
- 出典: https://modular-avatar.nadena.dev/

### コミュニティTips

- `community/tips-tools.md` に以下3ツールを追記:

  - **Meshia Mesh Simplification**: アバター全体のメッシュを一括ポリゴン削減するツール。目標パフォーマンスランクを指定して自動調整。lilNDMFMeshSimplifierの後継として現在主流。
    - 出典: https://vrnavi.jp/avatar-weight-saving3/

  - **ActualPerformanceWindow**: Unity Playモード内でアップロード後のパフォーマンス結果をリアルタイムプレビューできるツール（anatawa12作）。
    - 出典: https://vrnavi.jp/avatar-weight-saving3/

  - **ALCOM**: VCC（VRChat Creator Companion）の代替アセット管理ランチャー。2026年時点でコミュニティの一部がVCCからの移行を進めている。
    - 出典: https://zenn.dev/exxxna/articles/a5cfff93823d8f

### 確認済み・変更なし

- VRChat SDK 3.10.3: 前回から変更なし
- PhysBone仕様（Version 1.0/1.1）: 前回から変更なし
- Contacts仕様: 前回から変更なし
- Constraints仕様（6種類）: 前回から変更なし
- Playable Layers仕様: 前回から変更なし
- Animator Parameters（IsAnimatorEnabled、IsOnFriendsList含む）: 前回から変更なし
- Modular Avatar Merge Armature、Menu Installer: 前回から変更なし

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
