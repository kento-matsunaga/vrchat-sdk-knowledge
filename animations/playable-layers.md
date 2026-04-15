# Playable Layers（5層アニメーションシステム）

公式: https://creators.vrchat.com/avatars/playable-layers/

VRChatアバターのアニメーションは5つのPlayable Layerで管理される。  
後の層が前の層を上書きする（FXが最優先）。

---

## Layer 一覧と役割

| 順序 | Layer名 | 用途 | アニメーション可能な対象 |
|------|--------|------|----------------------|
| 1 | **Base** | ロコモーション（歩行・走行・ジャンプ・落下） | Transform のみ |
| 2 | **Additive** | Baseに加算合成するアニメーション（呼吸など） | Transform のみ |
| 3 | **Gesture** | 手・指・顔パーツの部分的なアニメーション | Transform のみ |
| 4 | **Action** | エモート等の全身アニメーション（デフォルト重み0） | Transform のみ |
| 5 | **FX** | 表情・マテリアル・ブレンドシェイプ・GameObject制御 | **Transform以外すべて** |

**重要:** FXレイヤーでもTransformを動かすことは**できるが推奨されない**。  
ブレンドシェイプ・マテリアル切り替え・GameObject.SetActive はすべてFXで行う。

---

## 適用順序（後が優先）

```
Base → Additive → Gesture → Action → FX
```

Gestureは上半身マスクをかけることで手・腕のみに適用するのが一般的。

---

## Generic Avatar（非Humanoid）の場合

| Layer | 利用可能 |
|-------|---------|
| Base | ○ |
| Additive | ✗ |
| Gesture | ✗ |
| Action | ○ |
| FX | ○ |

---

## Action Layer の注意事項

- **デフォルト重みが0** → エモートを再生するには `Playable Layer Control` State Behaviorで重みを1にする必要がある
- `Avatar Parameter Driver` で `VRCEmote` パラメータを設定するとデフォルトエモートが再生可能

---

## 各Layerの典型的な使い方

### Base Layer
- VRChat提供のデフォルトLocomotion Controllerを使用
- カスタムしない場合はデフォルトのままでOK

### Additive Layer
- 呼吸アニメーション（胸部ボーンを微妙に動かす）
- 常時適用したい微細な揺れ

### Gesture Layer
- 手の形（グー・パー・チョキ）を `GestureLeft / GestureRight` パラメータで制御
- **上半身または手部分にアバターマスクをかける**（下半身Baseに干渉しないように）
- 顔表情もGestureに入れることがあるが、現在はFXが推奨

### Action Layer
- エモート再生
- Playable Layer Controlで重み0→1にブレンドして再生
- 全身が制御されるのでBaseと競合する → Tracking ControlでAnimationに切り替える

### FX Layer
- 表情ブレンドシェイプ制御（最重要）
- ToggleしたいオブジェクトのActiveON/OFF
- マテリアルプロパティ変更
- ParticleSystemの再生

---

## よくある間違い

| 間違い | 正しい方法 |
|-------|----------|
| FXでTransformを動かそうとしている | GestureまたはBaseで行う |
| GestureにマスクをかけていないのでBaseと干渉する | Avatar Maskを設定して上半身のみに限定 |
| Action Layerが動かない | Playable Layer Controlで重みを1にしていない |
| Write Defaultsが混在している | 全Layer通じてONまたはOFFで統一する |
