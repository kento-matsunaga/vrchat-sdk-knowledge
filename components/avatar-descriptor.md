# VRC Avatar Descriptor

公式: https://creators.vrchat.com/avatars/avatar-descriptor/

アバターのルートGameObjectに必ず追加する必須コンポーネント。  
全ての設定（IK・表情・メニュー・Playable Layers）の起点となる。

---

## 設定項目

### View Position
- アバターの一人称視点カメラ位置（目の位置に合わせる）
- Scene上で球体アイコンをドラッグして調整

### Lip Sync
| 設定値 | 動作 |
|-------|------|
| Default | VRChatが自動設定 |
| Jaw Flap Bone | 顎ボーンを音声で動かす |
| Viseme Blend Shape | ブレンドシェイプで口パク（推奨） |
| Viseme Parameter Only | パラメータのみ使用（カスタム制御向け） |

**Viseme ブレンドシェイプ一覧（Viseme Blend Shape使用時）:**  
sil, pp, ff, th, dd, kk, ch, ss, nn, rr, aa, e, ih, oh, ou  
（計15個 = Visemeパラメータ 0〜14 に対応）

### Eye Look
- 目のボーンを指定することで視線IKを有効化
- Calm to Excited: 瞬き頻度（0=穏やか、高値=活発）
- Shy to Confident: 他プレイヤーへの視線応答

### Eyelid Type
- None / Blendshapes / Bones から選択

### Playable Layers
5つのLayerにAnimator Controllerを割り当てる:

| Layer | 用途 | アニメーション対象 |
|-------|------|------------------|
| Base | 歩行・走行・ジャンプ等のロコモーション | Transform のみ |
| Additive | Baseに加算合成するアニメーション | Transform のみ |
| Gesture | 手・顔パーツ等の部分アニメーション | Transform のみ |
| Action | エモート等の全身アニメーション | Transform のみ |
| FX | 表情・マテリアル・ブレンドシェイプ・GameObject制御 | Transform以外すべて |

### Expressions
- **Expressions Menu**: Expression Menuアセットを割り当て
- **Parameters**: Expression Parametersアセットを割り当て

### Colliders（標準コライダー）
自動定義される組み込みボディパートタグ:
- Head, Torso, Hands L/R, Feet L/R, Fingers L/R

### Pipeline Manager
- Avatar IDの管理（アップロード時に自動付与）

---

## Generic Avatar の注意事項

非Humanoidアバターの場合:
- FBX Import設定を **Generic** rig typeにする
- Animatorコンポーネント内に **Avatar object referenceを必ず設定**

---

## Locomotion Options

| 設定 | デフォルト | 説明 |
|------|-----------|------|
| Use Auto Footstep | ON | 自動足踏みIK |
| Force Locomotion Animations | ON | ロコモーションアニメーション強制 |
