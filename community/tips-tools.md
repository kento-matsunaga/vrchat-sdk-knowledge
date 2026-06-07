# 便利ツール・アセット情報

最終更新: 2026-06-07

VRChatアバター制作を効率化するコミュニティツールとその用途。

---

## 必須級ツール

### Modular Avatar
- **作者**: bd_
- **入手**: https://modular-avatar.nadena.dev/
- **用途**: アバターへのコンポーネント追加を非破壊的に行う
- **主要機能**:
  - MA Merge Armature: 衣装のボーンをアバターにマージ
  - MA Bone Proxy: ボーンの参照先を変更（v1.17.0 以降: **Match scale** オプション追加 — 参照先ボーンのスケールに自動的に合わせる）
  - MA Menu Installer: メニューを自動でRoot Menuに追加
  - MA Parameters: パラメータの自動登録
  - MA Blendshape Sync: ブレンドシェイプの同期
- **Write Defaults**: 自動的に整合性を取ってくれる
- **便利ショートカット**: Hierarchy上でアバターを右クリック → `Modular Avatar > Create Toggle` でオブジェクト切り替えトグルを素早く作成可能（出典: https://vrnavi.jp/modular-avatar-komono/）

### VRCFury
- **入手**: https://vrcfury.com/
- **用途**: 非破壊的なアバター設定追加
- **主要機能**:
  - 衣装統合
  - Toggle自動生成
  - SkinnedMeshのArmature Link
- **Modular Avatarとの使い分け**: VRCFuryは衣装販売者向け機能が充実

### AvatarOptimizer (AAO)
- **作者**: anatawa12
- **最新バージョン**: 1.9.14
- **入手**: https://vpm.anatawa12.com/avatar-optimizer/
- **用途**: 非破壊的なアバター最適化
- **主要機能**:
  - Trace and Optimize: 未使用コンポーネント・ボーンを自動削除
  - Merge Skinned Mesh: SkinnedMeshを自動統合（Matcap/Emissionアトラスも可能）
  - Freeze Blendshape: 使わないBlendShapeを焼き込んでポリゴン削減
  - Merge PhysBone: 同設定のPhysBoneコンポーネントを統合してコンポーネント数を削減
  - **AAO Max Texture Size**: アバターのテクスチャ最大解像度を一括設定。例: 4K→1024pxに設定するとテクスチャメモリが59.81MB→11.25MBに削減（出典: https://vr-lifemagazine.com/avatar-optimizer-how-to/）
- **パフォーマンス改善効果**: 適切に設定すればEXCELLENT以上も狙える
- **出典**: https://vpm.anatawa12.com/avatar-optimizer/en/

---

## 作業効率化ツール

### Gesture Manager
- Unity Editor上でジェスチャーをテスト再生できる
- PhysBoneの動作確認、表情の確認に便利

### VRChat SDK の Built-in Avatar Preview
- SDKビルドなしでPlayModeでアバターを確認
- PhysBone, Constraint の動作をEditor上で確認可能

### lilToon（シェーダー）
- VRChat最適化済みの高機能シェーダー
- マテリアルアトラス化機能内蔵
- MatCap, Emission, Dissolveなど多機能

### Poiyomi Toon（シェーダー）
- アニメーション連動機能が充実
- Locked / Unlocked モードに注意（Locked = 最適化済み）
- Animate With Properties でマテリアルのプロパティをアニメーション可能

---

## PhysBone設定補助ツール

### VRC Texture Optimizer
- **作者**: OXI Design
- **入手**: https://booth.pm/ja/items/6915386
- **用途**: VRChatアバターのテクスチャをバッチ一括最適化
- **主要機能**:
  - GPU ネイティブ圧縮（PC/Quest 両対応）
  - テクスチャ解像度・圧縮形式を一括最適化
- **効果**: テクスチャ容量・VRAM 使用量を大幅削減
- **価格**: 無料

出典: https://booth.pm/ja/items/6915386, https://vrnavi.jp/avatar-weight-saving1/

### PhysBone Tuner (コミュニティ製)
- PhysBoneの設定値をVisuallyプレビューしながら調整
- 具体的な数値の目安を提示してくれる

### Meshia Mesh Simplification
- **用途**: アバター全体のメッシュに対して一括ポリゴン削減
- **特徴**:
  - 目標パフォーマンスランクを指定すれば自動でポリゴン数を調整
  - AAOによる「削除」と違い「削減（間引き）」方式
  - lilNDMFMeshSimplifier の後継として現在主流
- **推奨箇所**: 単色パーツ・暗色パーツ・シンプルなメッシュ
- **避けるべき箇所**: 顔のまつ毛・髪の細部・指の関節など

出典: https://vrnavi.jp/avatar-weight-saving3/

### ActualPerformanceWindow（パフォーマンス確認ツール）
- **作者**: anatawa12
- **入手**: anatawa12のgistパック（VPM経由）
- **用途**: Unity Playモード内でアップロード後のパフォーマンス結果をリアルタイムプレビュー
- **効果**: AAOや各種最適化を適用した後の実際のランクをビルド前に確認できる

出典: https://vrnavi.jp/avatar-weight-saving3/

### KRT Material Tools
- **用途**: Unityのマテリアルを非破壊的に管理するツール
- **主要機能**:
  - **Quick Variant**: 選択したマテリアルを一括で Material Variant 化し、Prefab Variant にも自動で適用。元マテリアルを変更せず改変マテリアルを管理できる
- **活用シーン**: アバター衣装改変時に元アセットのマテリアルを汚さないよう、改変専用の Variant として分離する際に便利
- **出典**: https://zenn.dev/nekobox/articles/d0e92cb8a6f8ba

### ALCOM（VCC代替ランチャー）
- **用途**: VRChat Creator Companion (VCC) の代替アセット管理ツール
- **特徴**: 「かゆいところに手が届く」機能が充実しているとコミュニティで評価
- **主な利点**: パッケージ管理・バージョン管理をVCCより細かく制御可能
- 2026年時点でコミュニティの一部がVCCからALCOMへ移行中

出典: https://zenn.dev/exxxna/articles/a5cfff93823d8f

---

## トラブルシューティング

### SDK「Missing Credentials」エラー

VRChat SDKのコントロールパネルで「Missing Credentials」が表示されアップロードできない場合の対処法。

**原因**: 2段階認証を設定している環境で、内部的に2段階認証が未実行の状態になっていることが多い。

**解決手順:**
1. Unity上の VRChat Control Panel → `Authentication` タブを開く
2. 「Logout」を選択して一度ログアウト
3. 再度アカウントにログイン（2段階認証コードを入力）

**上記で解決しない場合:**
- 各プロジェクトの `Logs` / `Library` フォルダを削除してUnityを再起動
- `User Settings` も削除する（環境に応じて）

出典: https://zenn.dev/yrd_gs/articles/b123e9fee91ff9

---

## パフォーマンスランク Excellent 達成の数値基準

VRChatアバターでExcellentランクを達成するための目安値（2026年時点）:

| 項目 | Excellent上限 |
|------|-------------|
| Triangles（ポリゴン数） | 32,000以下 |
| Texture Memory | 40MB以下 |
| Skinned Meshes | 1個以下 |
| Material Slots | 4個以下 |

**実践的な最適化フロー:**
1. `AAO Trace And Optimize` をアバタールートに追加（自動最適化）
2. lilAvatarUtils で4Kテクスチャを2Kに一括変換
3. Skinned Mesh を `AAO Merge Skinned Mesh` で統合（1〜2個に）
4. Material Slots を マテリアルアトラス化（lilToon/Poiyomiの機能）で4個以下に
5. `ActualPerformanceWindow` でビルド前にランクをプレビュー確認

出典: https://qiita.com/Hellcat_152/items/ad1b1ceb2504bc39c0a4

---

## VRChatのSDK更新チェック先

| リソース | URL | 内容 |
|---------|-----|------|
| 公式Changelog | https://creators.vrchat.com/releases/ | SDK更新履歴 |
| VRChat Blog | https://hello.vrchat.com/blog | 主要機能発表 |
| @VRChat_Dev (X) | https://x.com/vrchat_dev | 開発者公式アカウント |
| VRChat Discord | https://discord.gg/vrchat | Creator Channelが有用 |
| VRChat Canny | https://feedback.vrchat.com/ | バグ報告・機能要望 |

---

## バージョン・互換性情報

| 項目 | 現在の状況（2026-06-07時点） |
|------|---------------------------|
| 推奨Unity | 2022.3.x LTS |
| SDKバージョン | 3.10.3（2026-04-16リリース）|
| Modular Avatarバージョン | 1.17.1（2026-05-14リリース）|
| AvatarOptimizer (AAO) | 1.9.14 |
| SDK | VRChat Avatars 3.0 (VRCSDK3) |
| 旧SDK (VRCSDK2) | 廃止済み・アップロード不可 |
| Dynamic Bone | 非推奨。PhysBoneに移行推奨 |
| 新コンポーネント(SDK 3.10.3) | VRCRaycast（ワールド向け） |
| MA新コンポーネント(v1.13〜v1.15) | MA Rename VRChat Collision Tags / MA Move Independently / MA Global Collider / MA Platform Filter |
| MA新コンポーネント(v1.17.0) | MA Floor Adjuster（靴の床高さ自動調整） / VRCRaycastサポート / BlendShapeピッカーにマルチセレクト追加 |
