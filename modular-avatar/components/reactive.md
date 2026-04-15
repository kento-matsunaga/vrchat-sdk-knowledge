# MA Reactive Components

公式: https://modular-avatar.nadena.dev/docs/

GameObjectのアクティブ状態やMenu Item設定に基づいて自動的に動作するコンポーネント群。  
**Animatorを書かずに簡単なトグル・変形・マテリアル変更が実現できる。**

---

## リアクティブ系コンポーネント一覧

| コンポーネント | 機能 |
|-------------|------|
| MA Object Toggle | GameObjectのアクティブ状態を制御 |
| MA Shape Changer | BlendShapeの値を変更 |
| MA Material Setter | マテリアルを設定 |
| MA Material Swap | マテリアルを別のマテリアルと交換 |

---

## 共通の動作原理

これらのコンポーネントは**コンポーネントが置かれたGameObjectのアクティブ状態**に連動する。

```
Menu Item (Toggle) → アクティブ/非アクティブ → Reactive Componentが反応 → 効果を適用
```

- GameObject と**全ての親GameObjectがアクティブ**な時に効果が適用される
- `Invert condition` オプションで動作を反転できる

### 実行タイミングの注意
- アクティブ状態の変化時に **1フレームの遅延**がある
- A→B→C とチェーンすると遅延が累積する

---

## MA Object Toggle

他のGameObjectのアクティブ状態（表示/非表示）を制御する。

### パラメータ

| パラメータ | 説明 |
|---------|------|
| Object | 制御するGameObject |
| Active | trueにするかfalseにするか |
| Invert | 条件を反転する |

### 使用例: 翼のON/OFF

```
ウィングトグルPrefab
  [MA Menu Item]
    Type: Toggle
    Name: "翼"
  Wings_Control/
    [MA Object Toggle]
      Object: アバター/Wings_Mesh
      Active: true
    ↑ Menu ItemがONの時 Wings_Mesh を表示
```

### 優先度
同じGameObjectに複数のObject Toggleが設定されている場合、**最も深い（下位の）コンポーネントが優先**される。

---

## MA Shape Changer

SkinnedMeshRendererのBlendShape値を変更する。  
主に「衣装着用時にボディメッシュを変形する」用途で使う。

### パラメータ

| パラメータ | 説明 |
|---------|------|
| Target Renderer | 変更するSkinnedMeshRenderer |
| Blendshape | 変更するBlendShape名と値 |

### 使用例: 衣装着用時にボディを変形

```
タイトな衣装Prefab
  [MA Menu Item]
    Type: Toggle  
  Body_Adjust/
    [MA Shape Changer]
      Target: アバター/Body（SkinnedMeshRenderer）
      Blendshape: "衣装A_補正" → 100
    ↑ 衣装ONの時、ボディのBlendShapeを変形してめり込みを防ぐ
```

---

## MA Material Setter

SkinnedMeshRendererの特定スロットのマテリアルを設定する。

### パラメータ

| パラメータ | 説明 |
|---------|------|
| Target Renderer | 変更するSkinnedMeshRenderer |
| Slot Index | 変更するマテリアルスロット番号 |
| Material | 設定するマテリアル |

---

## MA Material Swap

マテリアルを別のマテリアルに置き換える。  
Material Setterとの違い：置換対象を「どのマテリアルか」で指定する。

### パラメータ

| パラメータ | 説明 |
|---------|------|
| Original Material | 置換したい元のマテリアル |
| Replacement Material | 置換後のマテリアル |

### 使用例: カラーバリエーション

```
カラー変更Prefab
  [MA Menu Item] → ColorRed (Bool)
  Color_Red/
    [MA Material Swap]
      Original: Base_Blue_Mat
      Replacement: Base_Red_Mat
```

---

## Reaction Debugger

リアクティブコンポーネントの動作が意図通りか確認するデバッグツール。

**開き方:**  
対象のGameObjectを右クリック → Modular Avatar → **Show Reaction Debugger**

条件とその結果を視覚的に確認できる。

---

## Animatorなしで実現できること（リアクティブ系の活用範囲）

| やりたいこと | 使うコンポーネント |
|-------------|-----------------|
| GameObjectをON/OFF | MA Object Toggle |
| 衣装着用時のボディ補正 | MA Shape Changer |
| マテリアルを変える | MA Material Setter / Swap |
| 以上を組み合わせた複合トグル | 複数のリアクティブを同じMenu Itemに紐付け |

**Animatorが必要なケース:**
- BlendShapeをスムーズに補間したい（Radial Puppetとの連動）
- 複雑な条件分岐
- 音を鳴らす（Animator Play Audio）
