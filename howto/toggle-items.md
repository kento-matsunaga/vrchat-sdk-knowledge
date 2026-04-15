# アイテムのON/OFFを作りたい

メニューから衣装・アクセサリー・エフェクトをトグルする実装手順。

---

## 必要なもの

- Expression Parameters（Boolパラメータを定義）
- Expression Menu（ToggleコントロールでBoolを操作）
- FX Layer Animator Controller（パラメータに応じてGameObjectを切り替え）

---

## 基本実装手順

### Step 1: Expression Parametersにパラメータを追加

```
Name: WingsEnabled
Type: Bool
Default: false
Saved: true    ← ログアウト後も状態保持
Synced: true   ← 他プレイヤーにも見える
```

### Step 2: Expression MenuにToggleを追加

```
Control Type: Toggle
Name: "翼"
Parameter: WingsEnabled
Value: true（ON時）
```

### Step 3: FX LayerにLayer追加

FX Animatorを開いて新しいLayerを追加:
- Layer名: "Wings Toggle"
- Weight: 1.0
- **Write Defaults: アバター全体のWD設定に合わせる**

### Step 4: AnimatorにBool Parameterを追加

```
Animator > Parameters > + > Bool
名前: WingsEnabled（Expression Parametersと完全一致）
```

### Step 5: ステートを作成

**ステート: "Wings OFF"** (Default State / 黄色)
- Animation: Wings_OFF.anim（翼GameObjectのActive=false）

**ステート: "Wings ON"**
- Animation: Wings_ON.anim（翼GameObjectのActive=true）

### Step 6: Transitionを設定

**Wings OFF → Wings ON:**
- Has Exit Time: false
- Transition Duration: 0
- Condition: WingsEnabled = true

**Wings ON → Wings OFF:**
- Has Exit Time: false
- Transition Duration: 0
- Condition: WingsEnabled = false

---

## アニメーションクリップの作り方（WD OFF前提）

**Wings_OFF.anim:**
```
GameObject名/子GameObjectのパス → m_IsActive = 0（false）
```

**Wings_ON.anim:**
```
GameObject名/子GameObjectのパス → m_IsActive = 1（true）
```

> **WD OFFの場合は両方のクリップに必ずキーを打つ。**  
> Wings_OFF.animにm_IsActive=0を設定しないと、ONにした後OFFにしても表示されたままになる。

---

## 複数衣装の切り替え（Int版）

### Expression Parameters
```
Name: Outfit
Type: Int
Default: 0
Saved: true
Synced: true
```

### Expression Menu（Sub-Menuで分ける）
```
Sub-Menu "衣装"
  Toggle "デフォルト" → Outfit = 0
  Toggle "カジュアル" → Outfit = 1
  Toggle "フォーマル" → Outfit = 2
```

### Animator 条件
| ステート | 条件 |
|---------|------|
| Outfit0 | Outfit == 0 |
| Outfit1 | Outfit == 1 |
| Outfit2 | Outfit == 2 |

Any State からそれぞれのステートにTransitionを貼る方が管理しやすい。

---

## よくある問題

### OFFにしても消えない
- WD OFFの場合、OFF.animにも `m_IsActive = 0` のキーを打てているか確認
- Write Defaultsが混在していないか確認

### 他プレイヤーに見えない
- Expression Parameters の Synced が true になっているか確認
- FX LayerのWeightが1.0になっているか確認

### 切り替えがカクつく（瞬間的に消える）
- Transition Duration: 0 になっているか確認
- （なめらかにしたい場合はblendshapeを使う方が良い）

### メニューに出てこない
- Expression MenuがAvatar DescriptorのExpressionsに割り当てられているか確認
- Sub-Menuの場合、親メニューのコントロールにExpression Menuアセットが割り当てられているか確認
