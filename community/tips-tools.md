# 便利ツール・アセット情報

最終更新: 2026-04-16

VRChatアバター制作を効率化するコミュニティツールとその用途。

---

## 必須級ツール

### Modular Avatar
- **作者**: bd_
- **入手**: https://modular-avatar.nadena.dev/
- **用途**: アバターへのコンポーネント追加を非破壊的に行う
- **主要機能**:
  - MA Merge Armature: 衣装のボーンをアバターにマージ
  - MA Bone Proxy: ボーンの参照先を変更
  - MA Menu Installer: メニューを自動でRoot Menuに追加
  - MA Parameters: パラメータの自動登録
  - MA Blendshape Sync: ブレンドシェイプの同期
- **Write Defaults**: 自動的に整合性を取ってくれる

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
- **入手**: https://vpm.anatawa12.com/avatar-optimizer/
- **用途**: 非破壊的なアバター最適化
- **主要機能**:
  - Trace and Optimize: 未使用コンポーネント・ボーンを自動削除
  - Merge Skinned Mesh: SkinnedMeshを自動統合（Matcap/Emissionアトラスも可能）
  - Freeze Blendshape: 使わないBlendShapeを焼き込んでポリゴン削減
- **パフォーマンス改善効果**: 適切に設定すればEXCELLENT以上も狙える

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

### PhysBone Tuner (コミュニティ製)
- PhysBoneの設定値をVisuallyプレビューしながら調整
- 具体的な数値の目安を提示してくれる

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

| 項目 | 現在の状況（2026-04-16時点） |
|------|--------------------------|
| 推奨Unity | 2022.3.x LTS |
| SDK | VRChat Avatars 3.0 (VRCSDK3) |
| 旧SDK (VRCSDK2) | 廃止済み・アップロード不可 |
| Dynamic Bone | 非推奨。PhysBoneに移行推奨 |
