# 表情を作りたい

FX LayerとGesture LayerでBlendShapeを制御して表情を実装する手順。

---

## 表情システムの概要

| 実装方法 | 説明 | 推奨 |
|---------|------|------|
| **FX Layer + Toggle/Radial** | メニューから表情を選ぶ | ○ 現在の主流 |
| **Gesture Layer + 手形状** | 手のジェスチャーで表情を切り替え | ○ 組み合わせて使う |
| **両方組み合わせ** | ジェスチャーで基本、メニューで追加 | ◎ 最も柔軟 |

---

## ジェスチャーで表情を切り替える（Gesture Layer）

### Gesture番号と表情の対応例
| GestureLeft/Right | 手形状 | 表情例 |
|-------------------|-------|-------|
| 0 | Neutral | 通常（表情なし） |
| 1 | Fist | 怒り / 真剣 |
| 2 | HandOpen | 驚き / びっくり |
| 3 | FingerPoint | にっこり |
| 4 | Victory | ウィンク |
| 5 | RockNRoll | ニヤリ |
| 6 | HandGun | 困り顔 |
| 7 | ThumbsUp | 喜び |

### Gesture Layerの設定手順

1. FX LayerではなくGesture LayerのAnimator Controllerを開く
2. **Avatar Maskを設定**（Face部分のみ、または上半身マスク）
3. Parameterに `GestureRight` (Int) を追加
4. Neutral Stateをデフォルトに設定
5. 各ジェスチャー番号に対応するステートを作成

**Transition設定（Any State → 各ステート）:**
```
Condition: GestureRight == 1  → Angry State
Condition: GestureRight == 4  → Wink State
...
```

### 表情アニメーションクリップの作り方

Faceメッシュに対してBlendShapeをキーフレームに記録:
```
例: Smile.anim
  FaceSkinnedMeshRenderer → "Fcl_MTH_A" = 0
  FaceSkinnedMeshRenderer → "Fcl_EYE_Close_R" = 80
  FaceSkinnedMeshRenderer → "Fcl_BRW_Fun_R" = 60
```

---

## メニューで表情を選ぶ（FX Layer）

### Expression Parameters
```
Name: FaceExpression
Type: Int
Default: 0
Saved: false
Synced: true
```

### Expression Menu
```
Sub-Menu "表情"
  Toggle "通常"    → FaceExpression = 0
  Toggle "笑顔"    → FaceExpression = 1
  Toggle "怒り"    → FaceExpression = 2
  Toggle "悲しみ"  → FaceExpression = 3
  Radial "笑顔強度" → SmileBlend (Float 0〜1)
```

### FX Layer Animator
```
Layer: Expression
Weight: 1.0
Write Defaults: アバター全体に合わせる

Any State → Neutral   : FaceExpression == 0
Any State → Happy     : FaceExpression == 1
Any State → Angry     : FaceExpression == 2
Any State → Sad       : FaceExpression == 3
```

---

## 表情の優先度制御（ジェスチャー + メニューの同時使用）

ジェスチャー表情とメニュー表情を同時に使う場合:

**方法1: Layerで制御（シンプル）**
- Gesture Layer: ジェスチャー表情（Weight低め）
- FX Layer: メニュー表情（Weight高め）
- FX LayerがGesture Layerを上書き

**方法2: Bool制御（柔軟）**
- `ExpressionOverride` (Bool) パラメータを用意
- `ExpressionOverride=true` の時はメニュー表情を使用
- `ExpressionOverride=false` の時はジェスチャー表情を使用

---

## まばたきとの衝突を避ける

VRChatのViseme/Blink制御とFX Layerの表情が衝突する場合:

**解決方法:**
- Avatar DescriptorのViseme TypeをNoneに（口パクを手動制御する場合）
- Blinkは `Animator Tracking Control` の `Eyes & Eyelids` を `Animation` にすることで手動制御可能
- Gesture LayerのBlinkアニメーションを上手く設定する

---

## よくある問題

### 表情が反映されない
- FX LayerのWeightが1.0になっているか
- BlendShapeのパスが正しいか（SkinnedMeshRendererの子オブジェクトのパスを確認）
- WD設定が混在していないか

### ジェスチャー表情とメニュー表情が混在して変になる
- どちらかのLayerに Avatar Mask をかけて干渉しないようにする

### まばたきが停止する
- Avatar DescriptorのBlink BlendShapeと表情アニメーションのBlendShapeが競合している
- 表情アニメーションにBlinkのキーを含めないか、Tracking Controlで制御を分ける
