# VRChat SDK × Modular Avatar 全体構造マップ

最終更新: 2026-04-16

VRChat SDKとModular Avatarは**競合しない**。  
MAはSDKの上に構築されたツールで、手作業の部分を自動化・非破壊化する。

---

## 立ち位置の整理

```
┌─────────────────────────────────────────────────────┐
│              VRChat クラウド（サーバー）               │
└────────────────────────┬────────────────────────────┘
                         ↑ アップロード
┌────────────────────────┴────────────────────────────┐
│              VRChat SDK（必須・基盤）                  │
│  ・VRC Avatar Descriptor                             │
│  ・PhysBone / Contacts / Constraints                 │
│  ・Expression Menu / Parameters                      │
│  ・Playable Layers (Animator)                        │
└────────────────────────┬────────────────────────────┘
                         ↑ ビルド前に処理
┌────────────────────────┴────────────────────────────┐
│         NDMF ビルドパイプライン（Modular Avatar基盤）   │
│  ┌─────────────────────────────────────────────┐    │
│  │  Resolving → Generating → Transforming       │    │
│  │       → Optimizing → SDK Build              │    │
│  └─────────────────────────────────────────────┘    │
│                                                      │
│  Modular Avatar が担当するフェーズ:                    │
│  ・Merge Armature（ボーン統合）                       │
│  ・Merge Animator（Animator統合）                     │
│  ・Menu Installer（メニュー自動生成）                  │
│  ・Parameters（パラメータ競合解決）                    │
│  ・Reactive Components（Toggle/Shape等）              │
└────────────────────────┬────────────────────────────┘
                         ↑ 素材
┌────────────────────────┴────────────────────────────┐
│              Unity Scene / Prefabs                   │
│  ・ベースアバター（素体）                             │
│  ・衣装 Prefab（MAコンポーネント付き）                 │
│  ・ギミック Prefab（MAコンポーネント付き）              │
└─────────────────────────────────────────────────────┘
```

---

## どちらが何を担当するか

| 機能 | 手段 | 担当 |
|------|------|------|
| アバターの基本定義 | VRC Avatar Descriptor | **VRChat SDK** |
| ボーンの物理シミュレーション | VRC PhysBone | **VRChat SDK** |
| 接触検出 | VRC Contact Sender/Receiver | **VRChat SDK** |
| ボーン追従 | VRC Constraints | **VRChat SDK** |
| アニメーション制御 | Playable Layers + Animator | **VRChat SDK** |
| メニュー定義 | Expression Menu/Parameters | **VRChat SDK**（MAが自動生成も可） |
| **衣装のボーンをアバターに合わせる** | MA Merge Armature | **Modular Avatar** |
| **複数のAnimatorをまとめる** | MA Merge Animator | **Modular Avatar** |
| **メニューを自動で追加する** | MA Menu Installer | **Modular Avatar** |
| **パラメータ名の競合を解消する** | MA Parameters | **Modular Avatar** |
| **アイテムのON/OFFを簡単に作る** | MA Object Toggle | **Modular Avatar** |
| **一人称で頭部アクセを見せる** | MA Visible Head Accessory | **Modular Avatar** |
| **UnityConstraintをVRC変換** | MA Convert Constraints | **Modular Avatar** |
| **非破壊でアバターを改変する** | NDMF + MA全般 | **Modular Avatar** |

---

## 非破壊とは何か

```
【従来の改変（破壊的）】
  アバター Prefab を直接編集
    → ボーンを手動でコピー
    → Animatorに直接レイヤーを追加
    → Expression MenuをUnityで手動編集
  
  問題: 素体を更新したら全部やり直し

【MA を使った改変（非破壊）】
  衣装 Prefab にMAコンポーネントを付けてドラッグ
    → ビルド時にMAが自動でボーンをマージ
    → ビルド時にMAが自動でAnimatorを統合
    → ビルド時にMAが自動でMenuを生成
  
  メリット: 素体を更新しても衣装Prefabをドラッグし直すだけ
           Prefabをそのまま他の人に配布できる
```

---

## ビルドパイプライン処理順序（詳細）

```
[Unity Scene に アバター + 衣装Prefab が存在]
            ↓
[NDMF: Resolving フェーズ]
  ・MA が参照を解決
  ・アニメーションコントロールをクローン
            ↓
[NDMF: Generating フェーズ]
  ・カスタムプラグインがコンポーネントを生成（MAより前に実行したい場合）
            ↓
[NDMF: Transforming フェーズ] ← 主処理
  ① MA Merge Armature  → 衣装ボーンをアバターにマージ
  ② MA Merge Animator  → Animatorを統合
  ③ MA Parameters      → パラメータ名競合を解決
  ④ MA Menu Installer  → Expression Menuを自動生成
  ⑤ MA Reactive Components → ObjectToggle等を処理
  ⑥ MA Convert Constraints → Unity制約をVRC制約に変換
  ⑦ Avatar Optimizer等 → 最適化処理
            ↓
[NDMF: Optimizing フェーズ]
  ・メッシュ最適化（AvatarOptimizer等）
  ・未使用ボーン削除
            ↓
[VRChat SDK ビルド処理]
  ・Avatar Descriptor検証
  ・最終アセット生成
            ↓
[VRChat へアップロード]
```

---

## 「これはSDK？それともMA？」判断チャート

```
やりたいこと
    │
    ├─ ボーンを揺らしたい → VRC PhysBone（SDK）
    │
    ├─ 接触に反応させたい → VRC Contact（SDK）
    │
    ├─ ボーンを別のボーンに追従させたい → VRC Constraint（SDK）
    │
    ├─ 表情アニメーションを作りたい → FX Layer Animator（SDK）
    │
    ├─ 衣装をアバターに着せたい → MA Merge Armature（MA）
    │
    ├─ ギミックのアニメーションを追加したい → MA Merge Animator（MA）
    │
    ├─ メニューにトグルを追加したい
    │       ├─ 簡単にやりたい → MA Object Toggle + MA Menu Item（MA）
    │       └─ 細かく制御したい → FX Layer + Expression Menu（SDK）
    │
    ├─ 衣装をPrefabとして配布したい → MA全般（MA）
    │
    └─ 一人称で頭が見えるようにしたい → MA Visible Head Accessory（MA）
```

---

## 参考リンク

- [VRChat SDK 公式](https://creators.vrchat.com/avatars/)
- [Modular Avatar 公式](https://modular-avatar.nadena.dev/)
- [NDMF 公式](https://ndmf.nadena.dev/)
- [Avatar Optimizer (AAO)](https://vpm.anatawa12.com/avatar-optimizer/)
