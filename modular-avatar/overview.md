# Modular Avatar 概要

最終更新: 2026-05-03  
公式: https://modular-avatar.nadena.dev/  
GitHub: https://github.com/bdunderscore/modular-avatar  
作者: bd_ (nadena.dev)

---

## Modular Avatar とは

VRChatアバターの改変・ギミック追加を**非破壊的**に行うためのUnityツールセット。  
衣装・ギミックをPrefabとして独立させ、アバターにドラッグ&ドロップするだけで統合できる。

### 核心的なメリット

| 従来の方法 | MAを使う方法 |
|----------|------------|
| アバターを直接編集（破壊的） | Prefabを追加するだけ（非破壊） |
| 素体更新 → 全改変をやり直し | 素体更新 → Prefabを付け直すだけ |
| 他の人に配布しにくい | Prefabをそのまま配布可能 |
| パラメータ名の衝突を手動管理 | MAが自動で解決 |
| Animatorを手動でマージ | MAが自動でマージ |

---

## インストール

### ALCOM（推奨）
1. ALCOM を起動
2. VPMリポジトリを追加: `https://vpm.nadena.dev/vpm.json`
3. パッケージ一覧から `Modular Avatar` をインストール

### VRChat Creator Companion
- VCCからも追加可能（公式ドキュメント参照）

**必須要件:**
- VRChat SDK（最新版）
- Unity 2022.3.x LTS

---

## NDMF（Non-Destructive Modular Framework）

MAの基盤となるフレームワーク。複数の非破壊ツールが互いに干渉せず協調動作できる仕組み。

### ビルドフェーズ（実行順序）

```
Resolving フェーズ
  └─ 参照解決・アニメーションコントロールのクローン

Generating フェーズ  
  └─ カスタムコンポーネントの生成（MAの前に実行したいもの）

Transforming フェーズ（主処理）
  └─ MA Merge Armature → Merge Animator → Parameters
     → Menu Installer → Reactive Components → Convert Constraints
     → Avatar Optimizer 等

Optimizing フェーズ
  └─ メッシュ最適化・未使用ボーン削除

VRChat SDK ビルド
  └─ 最終検証・アップロード用アセット生成
```

**重要:** MAはビルド時のみ変換を行う。元のScene/Prefabは一切変更されない。

---

## コンポーネント一覧

### アーマチュア・アニメーション統合系（最重要）

| コンポーネント | 概要 |
|-------------|------|
| [MA Merge Armature](components/merge-armature.md) | 衣装のボーンをアバターに統合 |
| [MA Merge Animator](components/merge-animator.md) | AnimatorをFX等のLayerに統合 |
| [MA Bone Proxy](components/bone-proxy.md) | Prefab内のオブジェクトをアバター構造内に配置 |

### メニュー・パラメータ系（最重要）

| コンポーネント | 概要 |
|-------------|------|
| [MA Parameters](components/parameters.md) | パラメータ定義・名前競合を自動解決 |
| [MA Menu Installer](components/menu-installer.md) | Expression Menuに自動でメニュー追加 |
| [MA Menu Item](components/menu-installer.md#menu-item) | Unity階層から直接MenuItemを定義 |

### リアクティブ系（簡単にToggleを作る）

| コンポーネント | 概要 |
|-------------|------|
| [MA Object Toggle](components/reactive.md) | GameObjectのON/OFFを制御 |
| [MA Shape Changer](components/reactive.md#shape-changer) | BlendShapeを変更 |
| [MA Material Setter](components/reactive.md#material-setter) | マテリアルを変更 |
| [MA Material Swap](components/reactive.md#material-swap) | マテリアルを別のものに差し替え |

### 外観・メッシュ系

| コンポーネント | 概要 |
|-------------|------|
| [MA Blendshape Sync](components/blendshape-sync.md) | 複数レンダラー間でBlendShapeを同期 |
| [MA Scale Adjuster](components/scale-adjuster.md) | 特定ボーンのスケールを調整 |
| [MA Mesh Settings](components/mesh-settings.md) | アンカー・バウンズを階層的に設定 |
| [MA Remove Vertex Color](components/misc.md) | 頂点色を削除 |
| [MA Replace Object](components/misc.md#replace-object) | GameObjectを別のオブジェクトに置換 |

### VRChat特化系

| コンポーネント | 概要 |
|-------------|------|
| [MA Visible Head Accessory](components/vrchat-specific.md) | 一人称で頭部アクセサリーを表示 |
| [MA World Fixed Object](components/vrchat-specific.md#world-fixed) | ワールド空間にオブジェクトを固定 |
| [MA World Scale Object](components/vrchat-specific.md#world-scale) | アバタースケーリングを無視 |
| [MA Convert Constraints](components/vrchat-specific.md#convert-constraints) | Unity制約→VRC制約に変換 |
| [MA PhysBone Blocker](components/vrchat-specific.md#physbone-blocker) | PhysBone影響をブロック |
| [MA Global Collider](components/vrchat-specific.md#global-collider) | 他アバターとのコライダー設定 |
| [MA Platform Filter](components/vrchat-specific.md#platform-filter) | PC/Quest/iOSでの表示を制御 |
| [MA Sync Parameter Sequence](components/vrchat-specific.md#sync-param-seq) | マルチプラットフォームのパラメータ順序統一 |
| [MA Rename VRChat Collision Tags](components/vrchat-specific.md#rename-collision-tags) | Contactsの衝突タグを名前空間化（v1.13.0+） |

### エディタユーティリティ系

| コンポーネント | 概要 |
|-------------|------|
| [MA Move Independently](components/vrchat-specific.md#move-independently) | 子に影響せずオブジェクトを移動（エディタのみ） |
