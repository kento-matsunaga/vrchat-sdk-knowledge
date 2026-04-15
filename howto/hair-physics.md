# 髪・尻尾・衣装フリルを揺らしたい

VRC PhysBoneを使って揺れものを実装する手順。

---

## 基本手順

1. 揺らしたいボーンの**親GameObjectにVRC PhysBoneを追加**
   - ※揺らしたいボーン自体ではなく、その親に追加する点に注意
2. Root Transform に揺らしたいボーンを指定
3. 用途に合わせてパラメータを調整

---

## 髪の毛の設定例

```
Root Transform: 髪の根元ボーン（例: Hair_Root）
Multi-Child Type: Ignore

Integration Type: Simplified
Pull: 0.2        ← 低いほどふわふわ、高いほど硬い
Spring: 0.3      ← ウォブルの量
Gravity: 0.3     ← 下に垂れる量（0だと無重力）
Gravity Falloff: 0.7  ← 静止時に重力を7割無視（自然な立ち上がりを維持）

Limits Type: Angle
Max Angle: 60    ← 根元から最大60度まで動く

Radius: 0.03     ← 細い髪の毛

Allow Grabbing: false
```

---

## 尻尾の設定例（掴み対応）

```
Root Transform: Tail_Root

Integration Type: Simplified
Pull: 0.15
Spring: 0.4
Gravity: 0.2
Gravity Falloff: 0.5

Limits Type: None  ← 自由に動く

Radius: 0.05

Allow Grabbing: true
Snap To Hand: true
Grab Movement: 0.5  ← 物理と手追従の中間

Parameter: "Tail"   ← IsGrabbed/Angle等が自動生成される
```

---

## 衣装フリル（伸縮あり）

```
Root Transform: Skirt_Root
Multi-Child Type: Ignore

Integration Type: Simplified
Pull: 0.3
Spring: 0.25
Gravity: 0.1

Max Stretch: 1.3    ← 最大1.3倍まで伸びる
Max Squish: 0.2     ← 最大0.2倍まで縮む
Stretch Motion: 0.5 ← 動きに応じて伸縮する量

Limits Type: Angle
Max Angle: 45
```

---

## 耳（うさ耳・猫耳）

```
Root Transform: Ear_L_Root / Ear_R_Root

Integration Type: Simplified
Pull: 0.4          ← 硬め（耳はあまりぶれない）
Spring: 0.15
Gravity: -0.1      ← 少し上向きに（立ち耳の場合）
Gravity Falloff: 0.8

Limits Type: Angle
Max Angle: 45

Allow Grabbing: false
```

---

## トラブルシューティング

### 揺れがおかしい / 暴れる
- `Pull` の値を上げる（0.1〜0.3程度から始める）
- `Limits` を設定して角度を制限する
- `Endpoint Position` が未設定の場合、単一ボーンは設定必須

### ボーンが一切動かない
- Root Transform の指定を確認（空の場合は現在のGameObjectが使われる）
- Humanoid ボーン（Hip, Spine等）をRootに指定していないか確認
- PhysBone と Constraint が同じオブジェクトについていないか確認

### パフォーマンスランクが落ちた
- PhysBone Components 数を確認（PC Good=8以下）
- `Affected Transforms` 数を確認（PC Good=64以下）
- 影響の少ない箇所のPhysBoneを削除または統合する

### 他プレイヤーの手に反応させたい
- VRC PhysBoneの設定はデフォルトで他プレイヤーの手（Handタグ）に反応する
- `Allow Collision` を確認（Allが推奨）
- `Radius` が小さすぎると当たり判定が取れないので0.03〜0.1m程度に

---

## PhysBone が起動する自動パラメータ（Parameter設定時）

髪や尻尾に `Parameter: "Hair"` と設定した場合:
- `Hair_IsGrabbed` (Bool) - 誰かに掴まれているか
- `Hair_IsPosed` (Bool) - ポーズ固定されているか
- `Hair_Angle` (Float 0〜1) - 現在の曲がり角度
- `Hair_Stretch` (Float 0〜1) - 現在の伸び量

→ これらをAnimatorで参照して、掴まれた時に表情を変えるなどの表現が可能
