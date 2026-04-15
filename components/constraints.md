# VRC Constraints（6種）

公式: https://creators.vrchat.com/avatars/avatar-dynamics/constraints/

ボーンの位置・回転・スケールを他のトランスフォームに追従させるコンポーネント群。  
UnityビルトインConstraintより高パフォーマンス。

---

## 禁止事項

- **PhysBoneと同一GameObjectに配置しない** → 親オブジェクトに配置する
- ランタイム中にtransform参照を変更するとパフォーマンスが低下する

---

## コンポーネント一覧

| コンポーネント | 機能 | 主な用途 |
|-------------|------|---------|
| VRCAimConstraint | ターゲットを回転させてソース方向を向かせる | 砲塔、目線追従 |
| VRCLookAtConstraint | Z軸をソースに向ける（AimConstraintの簡易版） | 目線、看板追従 |
| VRCParentConstraint | 位置と回転の両方をソースに追従 | オブジェクト連動、武器 |
| VRCPositionConstraint | 位置のみをソースに追従 | 浮遊オブジェクト |
| VRCRotationConstraint | 回転のみをソースに追従 | 向き同期 |
| VRCScaleConstraint | スケールをソースに追従 | サイズ同期 |

---

## 共通パラメータ

| パラメータ | 型 | 説明 |
|-----------|-----|------|
| Is Active | Bool | 制約の有効/無効 |
| Target Transform | Transform | 影響を受けるトランスフォーム（デフォルト: コンポーネントのGameObject） |
| Sources | List | 追従するトランスフォームとその重み (0.0〜1.0) |
| Lock | Bool | ONの時に制約適用。OFFにすると現在位置でオフセットを再計算 |
| Solve In Local Space | Bool | ワールド空間 vs ローカル空間で計算 |
| Freeze To World | Bool | ワールド空間に固定（ソースを無視） |
| Rebake Offsets When Unfrozen | Bool | Freeze解除時にオフセットを再計算 |

---

## Weights（重み）

複数ソースを設定した場合、各ソースのWeightの比率で補間される。

```
Source A: Weight=0.7
Source B: Weight=0.3
→ AとBを 70%:30% でブレンドした位置/回転に追従
```

Weights はアニメーションで変化させることが可能。

---

## AimConstraint 固有設定

| パラメータ | 説明 |
|-----------|------|
| Aim Vector | ソースへ向ける軸方向（デフォルト: Forward=Z） |
| Up Vector | 上方向の参照軸 |
| World Up Type | ワールドアップ方向の参照方法 |

---

## パフォーマンス指標

| 指標 | 説明 |
|------|------|
| Constraint Count | アバター全体のConstraint総数（無効状態も含む、UnityConstraintも含む） |
| Constraint Depth | 依存チェーンの最長長（VRChatConstraintのみで計算） |

**Constraint Depth の例:**
```
BoneA → [PositionConstraint] → BoneB → [RotationConstraint] → BoneC
Depth = 2
```

---

## 典型的なユースケース

### 瞳を特定ポイントへ向ける
```
VRCLookAtConstraint
  Target Transform: 眼球ボーン
  Source: 視線ターゲットオブジェクト (Weight=1.0)
```

### 武器を手に追従させる
```
VRCParentConstraint
  Target Transform: 武器のルートボーン
  Source: 手首ボーン (Weight=1.0)
  Lock: true
```

### 2つのボーンの中間位置に追従
```
VRCPositionConstraint
  Source A: BoneA (Weight=0.5)
  Source B: BoneB (Weight=0.5)
```

### ワールド空間に固定（空中浮遊オブジェクト）
```
VRCPositionConstraint
  Freeze To World: true
  → アバターが動いても指定位置に留まる
  → アニメーションでFreezeをtrue/falseにして設置/回収を制御
```
