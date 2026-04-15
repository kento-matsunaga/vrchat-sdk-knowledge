# Animator Parameters

公式: https://creators.vrchat.com/avatars/animator-parameters/

VRChatがアバターのAnimatorに自動的に書き込むビルトインパラメータと、  
Expression Parametersで定義するカスタムパラメータの一覧。

---

## ビルトインパラメータ（自動更新・書き込み不要）

### 基本状態

| パラメータ名 | 型 | 値 / 範囲 | 説明 |
|------------|-----|----------|------|
| IsLocal | Bool | true/false | ローカルプレイヤーが着用しているか |
| PreviewMode | Int | 0, 1 | プレビューモード（SDKのAvatarPreview） |

### 音声・口パク

| パラメータ名 | 型 | 値 / 範囲 | 説明 |
|------------|-----|----------|------|
| Viseme | Int | 0〜14 | 現在の口形（0=sil, 1=pp, 2=ff, 3=th, 4=dd, 5=kk, 6=ch, 7=ss, 8=nn, 9=rr, 10=aa, 11=e, 12=ih, 13=oh, 14=ou） |
| Voice | Float | 0.0〜1.0 | マイク音量（Viseme Parameterモードで有効） |

### ジェスチャー

| パラメータ名 | 型 | 値 / 範囲 | 説明 |
|------------|-----|----------|------|
| GestureLeft | Int | 0〜7 | 左手のジェスチャー番号 |
| GestureRight | Int | 0〜7 | 右手のジェスチャー番号 |
| GestureLeftWeight | Float | 0.0〜1.0 | 左トリガーのアナログ値 |
| GestureRightWeight | Float | 0.0〜1.0 | 右トリガーのアナログ値 |

**Gesture番号対応表:**
| 番号 | ジェスチャー |
|------|------------|
| 0 | Neutral（何もしていない） |
| 1 | Fist（握りこぶし） |
| 2 | HandOpen（手を開く） |
| 3 | FingerPoint（指差し） |
| 4 | Victory（ピース） |
| 5 | RockNRoll（ロックンロール） |
| 6 | HandGun（銃の形） |
| 7 | ThumbsUp（いいね） |

### 移動・姿勢

| パラメータ名 | 型 | 値 / 範囲 | 説明 |
|------------|-----|----------|------|
| AngularY | Float | -ω〜ω | Y軸周りの回転速度（deg/s） |
| VelocityX | Float | - | ローカルX軸移動速度（m/s） |
| VelocityY | Float | - | ローカルY軸移動速度（m/s、上下） |
| VelocityZ | Float | - | ローカルZ軸移動速度（m/s、前後） |
| VelocityMagnitude | Float | 0.0〜 | 総合移動速度 |
| Upright | Float | 0.0〜1.0 | 姿勢の垂直度（0=水平、1=直立） |
| Grounded | Bool | true/false | 地面に接触しているか |
| Seated | Bool | true/false | 着席状態か |
| AFK | Bool | true/false | AFKモードか |

### トラッキング・モード

| パラメータ名 | 型 | 値 | 説明 |
|------------|-----|-----|------|
| TrackingType | Int | 0〜6 | トラッキング点数（下記参照） |
| VRMode | Int | 0, 1 | 1=VRモード、0=デスクトップモード |
| MuteSelf | Bool | true/false | マイクをミュートしているか |
| Earmuffs | Bool | true/false | イヤーマフ機能が有効か |

**TrackingType 対応表:**
| 値 | トラッキング状態 |
|----|---------------|
| 0 | トラッキングなし（ローカルテスト等） |
| 1 | デスクトップモード（頭のみ） |
| 2 | 未使用 |
| 3 | 3点（頭+両手） |
| 4 | 4点（頭+両手+腰） |
| 5 | 5点（頭+両手+両足） |
| 6 | 6点FBT（頭+両手+腰+両足） |

### スケーリング

| パラメータ名 | 型 | 説明 |
|------------|-----|------|
| ScaleModified | Bool | アバタースケーリングが変更されているか |
| ScaleFactor | Float | 身長の倍率 |
| ScaleFactorInverse | Float | ScaleFactorの逆数 |
| EyeHeightAsMeters | Float | 現在の目の高さ（メートル） |
| EyeHeightAsPercent | Float | スケール後の身長パーセンテージ |

---

## カスタムパラメータ（Expression Parametersで定義）

Expression Parametersアセットで自由に定義できるパラメータ。

### 型と範囲

| 型 | 同期時の範囲 | ローカル時の範囲 | ビット数 |
|----|------------|----------------|---------|
| Int | 0 〜 255 | 制限なし | 8bit |
| Float | -1.0 〜 1.0 | 制限なし | 8bit |
| Bool | true / false | true / false | 1bit |

### 設定オプション

| オプション | 説明 |
|---------|------|
| Default | パラメータの初期値 |
| Saved | trueの場合、アバター切り替え・ワールド移動後も値を保持 |
| Synced | trueの場合、他のプレイヤーにネットワーク同期される |

### 総ビット数制限
- 全パラメータの合計ビット数は **256bit** まで
  - Bool: 1bit
  - Int: 8bit
  - Float: 8bit（量子化されて同期）

### デフォルトパラメータ（VRChat標準）
| 名前 | 型 | 説明 |
|------|-----|------|
| VRCEmote | Int | デフォルトエモート番号（1〜16） |
| VRCFaceBlendH | Float | 顔ブレンドシェイプ水平 |
| VRCFaceBlendV | Float | 顔ブレンドシェイプ垂直 |

---

## Avatar Parameter Driver で操作可能な操作

| 操作 | 対応型 | 説明 |
|-----|--------|------|
| Set | Float/Int/Bool | 値を直接設定 |
| Add | Float/Int | 現在値に加算（リモートプレイヤーでは差異が生じる可能性あり） |
| Random | Float/Int/Bool | ランダム値設定。Bool時はChance、Int時はPrevent Repeats対応 |
| Copy | すべて | 別パラメータの値をコピー |

### 型変換ルール（Copyや操作時）
| 変換元→変換先 | 動作 |
|-------------|------|
| Bool → 数値 | false=0、true=1 |
| 数値 → Bool | 0=false、その他=true |
| Float → Int | 小数点以下を切り捨て |
| Int → Float | そのまま |
