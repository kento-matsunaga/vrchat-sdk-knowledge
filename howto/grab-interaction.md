# 掴めるオブジェクト・接触インタラクションを作りたい

PhysBoneのGrab機能とContactを組み合わせてインタラクティブな要素を作る手順。

---

## 掴めるオブジェクト（PhysBone Grab）

### 最小設定

```
VRC PhysBone を追加
  Root Transform: 掴ませたいオブジェクトのルートボーン
  Allow Grabbing: true        ← 必須
  Allow Posing: true          ← ポーズ固定させたい場合
  Snap To Hand: true          ← 手にくっつける場合
  Grab Movement: 0.5〜1.0     ← 1.0で即座に手に追従
  Parameter: "Ball"           ← 自動パラメータ生成用
```

### 生成されるパラメータ
- `Ball_IsGrabbed` (Bool) - 現在掴まれているか
- `Ball_IsPosed` (Bool) - ポーズ固定されているか

### 掴んだ時にエフェクトを出す例

```
FX Layer に Layer "Ball Grab" を追加
Parameter: Ball_IsGrabbed (Bool)

ステート "Normal" → ステート "Grabbed":
  Condition: Ball_IsGrabbed == true

Grabbed ステートのアニメーション:
  → パーティクルSystemを有効化
  → 光エフェクトのマテリアルを変更
```

---

## 頭を撫でてもらうインタラクション（Contact）

### 設置場所の考え方

```
相手の手 → VRCContactSender (Tag: "hand_pat")
自分の頭 → VRCContactReceiver (Tag: "hand_pat", Type: Constant)
```

VRChatの標準Senderは手に `Hand` タグが設定されている。  
ただし**カスタムタグ**を使った方が誤検出を防げる。

### 実装例（頭を撫でられたら表情が変わる）

**Step 1: VRCContactReceiverを頭部に追加**
```
Shape Type: Sphere
Radius: 0.2
Position: (0, 0.15, 0)  ← 頭の少し上
Allow Self: false
Allow Others: true
Collision Tags: ["hand"]   ← VRChatの組み込みHandタグ
Receiver Type: Constant
Parameter: "HeadPat"
```

**Step 2: Expression ParametersにHeadPatを追加**
```
Name: HeadPat
Type: Bool
Saved: false
Synced: false  ← ローカルで処理（パフォーマンス節約）
```

**Step 3: FX LayerでHeadPatを使って表情制御**
```
HeadPat == true → 嬉しそうな表情アニメーション
HeadPat == false → 通常表情
```

---

## 接触した時に音を鳴らす（Contact + Play Audio）

**Step 1: VRCContactReceiverを追加**
```
Receiver Type: OnEnter
Parameter: "Hit"
Min Velocity: 0.3  ← ある程度の速度で当たった時のみ
```

**Step 2: Animator にパラメータ追加**
```
Hit (Bool)
```

**Step 3: FX Layer にステートとPlay Audioを追加**
```
ステート "HitSound":
  Transition: Hit == true → このステート (Has Exit Time: false)
  State Behavior: Animator Play Audio
    Source Path: "SFX/ImpactAudio"
    Clips: [hit1.wav, hit2.wav]
    Playback Order: Unique Random
    On Enter: Play
    On Exit: Stop
  Transition out: 0.5秒後にNormalへ戻る
```

---

## 近づいてきた人に反応するインタラクション（Proximity）

### 他プレイヤーが近づいたら恥ずかしそうにする例

**VRCContactReceiver:**
```
Shape Type: Sphere
Radius: 1.5        ← 1.5m以内に人が来たら反応
Allow Self: false
Allow Others: true
Collision Tags: ["Head"]   ← 相手の頭タグ
Receiver Type: Proximity
Parameter: "NearbyPerson"  (Float)
```

**FX Layer:**
```
NearbyPerson パラメータ (Float) をBlendTreeで使用
  → 0.0: 通常表情
  → 1.0: 赤面・恥ずかしそうな表情

BlendTree:
  Type: 1D
  Parameter: NearbyPerson
  0.0 → Normal.anim
  1.0 → Embarrassed.anim
```

---

## よくある問題

### 掴めない
- `Allow Grabbing: true` になっているか確認
- PhysBone の Radius が 0 になっていないか確認（細すぎると掴めない）

### 自分で触れた時にも反応してしまう
- Contact Receiver の `Allow Self: false` になっているか確認

### 反応しない（Contactが動かない）
- Collision Tags が Sender と Receiver で1つ以上一致しているか確認
- タグは大文字小文字区別（"Hand" ≠ "hand"）

### パフォーマンスランクが落ちた
- `Local Only: true` にすることでランクへの影響を回避
- 処理はローカルのみになるが、他プレイヤーのSenderに反応することはできなくなる
