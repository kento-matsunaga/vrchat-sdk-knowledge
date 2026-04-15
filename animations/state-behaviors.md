# State Behaviors（7種）

公式: https://creators.vrchat.com/avatars/state-behaviors/

Animatorのステートに追加して、ステート遷移時に特定の動作を実行するコンポーネント群。

---

## 1. Animator Layer Controller

Playable Layerの特定レイヤーの重みをブレンドする。

| パラメータ | 型 | 範囲 | 説明 |
|-----------|-----|------|------|
| Playable | Enum | - | 対象のPlayable Layer（Base/Additive/Gesture/Action/FX） |
| Layer | Int | 0〜 | 対象レイヤーのインデックス（0番目は変更不可） |
| Goal Weight | Float | 0.0〜1.0 | ブレンド先の目標重み |
| Blend Duration | Float | 秒 | ブレンドにかける時間（0.02秒以上推奨） |

**動作:** ステート入場時にブレンド開始。ステート退出時は即座に目標値に設定。

---

## 2. Animator Locomotion Control

プレイヤーの移動を制御する。

| パラメータ | 型 | 説明 |
|-----------|-----|------|
| Disable Locomotion | Bool | true=移動を無効化、false=移動を有効化 |

**プラットフォーム別の動作:**
- **デスクトップ:** 水平移動と垂直回転を制限
- **VR:** コントローラーによる移動と回転を制限（IKは半身のみ制御）
- **プレイヤーカプセル:** 常に固定（変更不可）

**用途:** エモート中に移動させない、特定ステートで立ち止まらせる

---

## 3. Animator Temporary Pose Space

一時的にポーズ空間を変更する（座位・横臥のカメラ調整用）。

| パラメータ | 型 | 説明 |
|-----------|-----|------|
| Pose Space | Enum | Enter=ポーズ空間有効化 / Exit=無効化 |
| Fixed Delay | Bool | true=固定秒数、false=ステート時間の割合 |
| Delay Time | Float | 遅延時間（Fixed DelayがtrueなS、falseなら0.0〜1.0の割合） |

> **重要:** Delay Time経過前にステートが退出した場合は実行されない。  
> **アバタースケーリング中は使用禁止。**

---

## 4. Animator Tracking Control

ボーンのIKトラッキングモードを変更する。

| パラメータ | オプション | 説明 |
|-----------|----------|------|
| Tracking Control | No Change | 現在の設定を維持 |
| | Tracking | IKトラッキングに戻す（通常状態） |
| | Animation | Animatorの値を直接適用（IKを無視） |

**トラッキング対象ボーン:**
- Head（頭）
- Left Hand / Right Hand（両手）
- Hip（腰）※FBT時のみ
- Left Foot / Right Foot（両足）※FBT時のみ
- Left Fingers / Right Fingers（指）
- Eyes & Eyelids（目・瞼）
- Mouth & Jaw（口・顎）

**用途:**
- エモート中に手を`Animation`にしてアニメーション通りに動かす
- エモート終了後に`Tracking`に戻してIKに返す

---

## 5. Avatar Parameter Driver

Animatorパラメータを操作する（State Behaviorの中で最も頻繁に使用）。

| 操作 | 対応型 | 説明 |
|-----|--------|------|
| **Set** | Float/Int/Bool | 指定値を直接設定 |
| **Add** | Float/Int | 現在値に加算 |
| **Random** | Float/Int/Bool | ランダム値を設定（Bool: Chance指定 / Int: Prevent Repeats対応） |
| **Copy** | すべて | 別パラメータの値をコピー |

**数値クランプ（同期パラメータ）:**
- Int: 0〜255
- Float: -1.0〜1.0
- ローカルパラメータ: クランプなし

**型変換（Copy時）:**
| 変換 | 動作 |
|------|------|
| Bool → 数値 | false=0, true=1 |
| 数値 → Bool | 0=false, それ以外=true |
| Float → Int | 切り捨て |
| Int → Float | そのまま |

---

## 6. Playable Layer Control

Playable Layer全体の重みを変更する（Action Layer有効化に必須）。

| パラメータ | 型 | 範囲 | 説明 |
|-----------|-----|------|------|
| Layer | Enum | - | 対象のPlayable Layer |
| Goal Weight | Float | 0.0〜1.0 | 目標重み |
| Blend Duration | Float | 秒 | ブレンド時間 |

**典型的な使用:** Action Layerのエモートを再生する時
1. エモート開始ステートに `Playable Layer Control` (Action, Weight=1, Duration=0.2s)
2. エモート終了ステートに `Playable Layer Control` (Action, Weight=0, Duration=0.2s)

---

## 7. Animator Play Audio

ステート入場/退場時にAudioSourceを制御する。

| パラメータ | 型 | 範囲 | 説明 |
|-----------|-----|------|------|
| Source Path | String | - | AudioSourceへの相対パス |
| Playback Order | Enum | - | Random / Unique Random / Roundabout / Parameter |
| Clips | AudioClip[] | - | 再生するクリップ一覧 |
| Random Volume | Range | 0〜1 | ランダムボリューム範囲（デフォルト: 1〜1） |
| Random Pitch | Range | -3〜3 | ランダムピッチ範囲（デフォルト: 1〜1） |
| Loop | Bool | - | ループ再生するか |
| On Enter | Flags | Stop/Play | ステート入場時の動作 |
| On Exit | Flags | Stop/Play | ステート退場時の動作 |
| Play On Enter Delay | Float | 0〜60秒 | 入場後の遅延時間 |

**Playback Order の動作:**
| モード | 説明 |
|-------|------|
| Random | 毎回ランダム（他プレイヤーと非同期になる可能性） |
| Unique Random | 同じクリップが連続しない |
| Roundabout | 順番に再生（ループ） |
| Parameter | 指定パラメータの値でクリップを選択（同期可能） |

> **注意:** Randomモードは各プレイヤーで異なるクリップが再生される。  
> 同期を取るにはParameterモード + 同期パラメータを使用。
