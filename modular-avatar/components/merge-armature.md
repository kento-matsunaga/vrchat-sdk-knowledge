# MA Merge Armature

公式: https://modular-avatar.nadena.dev/docs/reference/merge-armature

衣装・アクセサリーのボーン構造をアバターのアーマチュアに統合する最重要コンポーネント。  
**衣装をアバターに着せる時の基本。**

---

## 何をするコンポーネントか

```
【統合前（Sceneの状態）】
  アバター/
    Armature/
      Hips/ ← アバター本来のボーン
        Spine/
  衣装Prefab/           ← アバターとは別の階層
    Armature/
      Hips/ ← 衣装のボーン（同名）
        Spine/

【統合後（ビルド後）】
  アバター/
    Armature/
      Hips/ ← アバターのHipsに衣装のHipsがマージされる
        Spine/
      [衣装固有のボーンも追加される]
```

衣装のボーンがアバターのボーンに自動的に紐付けられる。  
**PhysBoneやAnimatorへの参照も自動更新される。**

---

## 配置方法

1. 衣装PrefabのルートGameObjectに `MA Merge Armature` を追加
2. `Merge Target` に アバターの `Armature` ルートを指定
3. ビルド時に自動統合される

```
衣装Prefab
  └─ [MA Merge Armature] ← ここに追加
       Merge Target: アバター/Armature
  └─ Armature/
       └─ Hips/（衣装のボーン群）
```

---

## パラメータ

| パラメータ | 型 | 説明 |
|-----------|-----|------|
| Merge Target | Transform | 統合先のアーマチュア（アバターのArmature） |
| Lock Mode | Enum | 位置同期の方式（下記参照） |
| Prefix/Suffix | String | 衣装ボーン名に付ける接頭/接尾辞（重複回避） |

### Lock Mode

| モード | 説明 | 使いどころ |
|-------|------|----------|
| Not Locked | 制限なし（通常） | 通常の衣装 |
| Base Path | 1方向同期 | 特殊な場合 |
| Both Paths | 双方向同期 | 複雑な依存関係 |

---

## 重要な動作仕様

### ボーン名マッチング
- 衣装とアバターで**同名のボーン**が自動的にマージされる
- 異なる名前のボーンはアバター階層に新規追加される

### 自動更新される参照
- **PhysBone の Root/Ignore Transform**
- **Animator のボーン参照**
- **Blendshape Sync の参照**
- **アニメーションクリップのパス**

### ネスト対応（v1.7.0+）
複数のMerge Armatureを入れ子にすることができる。

---

## 典型的な使用例

### 衣装Prefabに適用する基本構成

```
衣装（例: ドレス）
  [MA Merge Armature]
    Merge Target: アバター/Armature
  Armature/
    Hips/
      Spine/
        Chest/
          [衣装メッシュのTransform]
  Dress_Mesh（SkinnedMeshRenderer）
```

### PhysBone付き衣装（スカートなど）

```
スカート衣装
  [MA Merge Armature]
  Armature/
    Hips/
      SkirtBone_Root/    ← 衣装固有のボーン
        SkirtBone_1/
          ...
  [PhysBoneは衣装Prefab内に設定 → 統合後も自動更新]
```

---

## 注意事項

- **ボーンが静止していることを前提**とする。FK/IKが異なるアバターへの適用は困難
- 衣装のメッシュがアバターと大きく異なる体型の場合、マージ後に崩れることがある
- `Prefix/Suffix` を使うとボーン名重複を防げる（同じボーン名でも別として扱う場合）
