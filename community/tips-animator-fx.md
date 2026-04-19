# Animator / FX Layer コミュニティTips

最終更新: 2026-04-19

---

## Write Defaults まとめ

### WD OFF が主流になった理由（コミュニティ知見）
- VRChatのデフォルトコントローラーはWD ONだが、カスタムLayerを追加するとWD混在になりやすい
- WD混在時の症状: 表情が0に戻る / トグルが反映されない / 他のレイヤーに干渉する
- 現在の主流: **全Layer全State WD OFF** で統一してアニメーションを明示的に制御

### WD OFF 実装の鉄則
1. 全Stateに明示的なアニメーションクリップを割り当てる
2. ON状態とOFF状態の両方のクリップを用意する
3. BlendTreeを使う場合、各MotionにWD OFFが適用されていることを確認

### ツールで一括対処
- **Modular Avatar**: WD整合性を自動管理
- **VRCFury**: WD設定を自動化
- **Av3 Creator**: WD一括チェック・修正機能あり

---

## FX Layer 実装Tips

### Any Stateを使ったトグル実装（推奨パターン）
```
Any State → Toggle_ON   : Condition MyParam == true
Any State → Toggle_OFF  : Condition MyParam == false
```
Transition Duration: 0, Has Exit Time: false にする。  
Can Transition To Self のチェックを外すと同じStateへの無駄な遷移を防げる。

### Transition の設定ミスを防ぐチェックリスト
- [ ] Has Exit Time: false（Conditionのみで遷移）
- [ ] Transition Duration: 0（即時切り替え）
- [ ] Interruption Source: Current State（意図しない割り込みを防ぐ）
- [ ] Can Transition To Self: オフ（同Stateへのループを防ぐ）

### FloatパラメータをBlendTreeで使う
Toggleではなく滑らかな変化が必要な場合:
```
BlendTree (1D)
  Parameter: MyFloat
  0.0 → Normal.anim
  1.0 → Effect.anim
```
Radial Puppetと組み合わせて使うとメニューからスムーズに制御できる。

### 表情をGesture Layerに入れる vs FX Layer に入れる
| 方式 | メリット | デメリット |
|------|---------|----------|
| Gesture Layer | 直感的なジェスチャー制御 | Avatar Maskの設定が必要 |
| FX Layer | メニューから自由に制御 | ジェスチャーとの競合管理が必要 |
| 両方 | 最も自由度が高い | 設計が複雑になる |

---

## パラメータ設計Tips

### Bool vs Int どちらを使うか
| 用途 | 推奨型 |
|------|-------|
| ON/OFF切り替え | Bool (1bit) |
| 3種以上の選択肢 | Int (8bit) |
| 滑らかな変化 | Float (8bit) |

### ビット数節約
- 8つのToggleがある場合、8個のBool(8bit) vs 1個のInt(8bit)
  → 4つ以下なら Bool、5つ以上なら Int の方がビット効率が良い

### Saved vs 非Saved の判断基準
- 「次にVRChatを起動した時もその状態を維持したい」→ Saved: true
- 「毎回デフォルトから始まってほしい」→ Saved: false（エモート等）

---

## FX Layerテンプレートのベストプラクティス（2025年末以降）

### proxy_empty を使う（VRCSDK 3.9.0+）
従来のカスタム空アニメーションクリップ（`Custom_Empty.anim` 等）は  
VRCSDK同梱の **`proxy_empty`** クリップに置き換えることが推奨されている。

- `proxy_empty` は `Assets/VRCSDK/Examples3/Animation/ProxyAnim/proxy_empty.anim` に同梱
- VRCSDK 3.9.0 以上が必要
- みみーラボ製PlayableLayersテンプレートも2025年12月リリースのver 1.11.2でこれに対応済み

出典: https://booth.pm/ja/items/4301775

### Is Animated フラグの適切な活用
FX Layer内でPhysBoneのパラメータ（掴み状態等）をアニメーションクリップで制御している場合は  
PhysBoneの `Is Animated` を **ON** にする必要がある。  
それ以外の場合は **OFF** にすることでパフォーマンスが向上する。

---

## Animator Layer の構成ベストプラクティス

```
FX Controller の Layer 構成例:

[0] Base Weight
[1] Toggle - Item A   (Weight: 1.0)
[2] Toggle - Item B   (Weight: 1.0)
[3] Toggle - Outfit   (Weight: 1.0)
[4] Expression        (Weight: 1.0)
[5] Gesture Face      (Weight: 1.0)
[6] Audio             (Weight: 1.0)
```

- 各機能を別Layerに分けることでデバッグが容易
- Layer 0のBase Weightは基本的に変更しない
- 新機能追加時は新Layerを末尾に追加（既存への影響を最小化）
