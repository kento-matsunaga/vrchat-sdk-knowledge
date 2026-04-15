# MA Merge Animator

公式: https://modular-avatar.nadena.dev/docs/reference/merge-animator

ギミック用のAnimator ControllerをアバターのPlayable Layerに自動統合するコンポーネント。  
**ギミックのアニメーションをFX Layerに追加したい時の基本。**

---

## 何をするコンポーネントか

```
【従来の方法】
  アバターのFX Controllerを直接開く
  → 手動でLayerを追加
  → パラメータを手動で追加
  → 衝突・順序を手動管理

【MAを使う方法】
  ギミックPrefabにMA Merge Animatorを追加
  → ビルド時にFX Controllerに自動でLayerを追加
  → パラメータも自動追加（MA Parametersと連携）
```

---

## 配置方法

1. ギミックPrefabのGameObjectに `MA Merge Animator` を追加
2. `Animator` に追加したいAnimator Controllerを指定
3. `Layer Type` で統合先のPlayable Layerを指定

```
ギミックPrefab
  [MA Merge Animator]
    Animator: MyGimmick_FX.controller
    Layer Type: FX
  [ギミックのメッシュや処理オブジェクト等]
```

---

## パラメータ

| パラメータ | 型 | 説明 |
|-----------|-----|------|
| Animator | AnimatorController | 統合するAnimator Controller |
| Layer Type | Enum | 統合先のPlayable Layer |
| Delete Attached Animator | Bool | 統合後にAnimatorコンポーネントを削除するか |
| Path Mode | Enum | アニメーションパスの解釈方法 |
| Match Avatar Write Defaults | Bool | アバター全体のWrite Defaults設定に合わせる（推奨ON） |
| Relative Path Root | Transform | 相対パスの起点（Path Mode: Relativeの時） |

### Layer Type 選択肢

| 値 | 統合先 |
|----|--------|
| Base | Base Layer |
| Additive | Additive Layer |
| Gesture | Gesture Layer |
| Action | Action Layer |
| FX | FX Layer（最もよく使う） |

### Path Mode

| モード | 動作 |
|-------|------|
| Relative | ギミックPrefabのルートからの相対パス |
| Absolute | アバタールートからの絶対パス |
| Strip | パスを変換しない |
| Resolve Object | オブジェクト参照で自動解決（推奨） |

---

## Match Avatar Write Defaults

**ON（推奨）にすることで:**
- アバター全体のWrite Defaults設定（ONまたはOFF）に自動的に合わせる
- 手動でWD設定を揃える必要がなくなる
- 混在によるバグを防止

---

## 制限事項

- `VRCAnimatorLayerControl` の参照は**同一Animator内のLayerのみ**対応
  - 別のMAで追加したLayerを参照することはできない

---

## 典型的な使用パターン

### 基本的なギミック追加

```
ウィングギミックPrefab
  [MA Merge Animator]
    Animator: Wings_FX.controller   ← Wings ON/OFFのステートマシン
    Layer Type: FX
    Match Avatar WD: true
  [MA Parameters]
    WingsEnabled (Bool, Synced, Saved)
  [MA Menu Item]
    Toggle "Wings" → WingsEnabled
  Wings_Object（GameObjectのメッシュ等）
```

### Gesture Layer への追加

```
ハンドサインPrefab
  [MA Merge Animator]
    Animator: HandSign_Gesture.controller
    Layer Type: Gesture
    Match Avatar WD: true
```

### 複数のAnimatorを一つのPrefabで

```
複合ギミックPrefab
  FX部分/
    [MA Merge Animator] → FX Controller
  Action部分/
    [MA Merge Animator] → Action Controller
```
