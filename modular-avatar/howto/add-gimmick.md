# MAでギミックを追加したい

Modular Avatarを使ってアニメーション付きギミック（翼・エフェクト等）を追加する手順。

---

## 基本構成パターン

```
ギミックPrefab/
  [MA Merge Armature]    ← ボーンが必要な場合
  [MA Parameters]        ← パラメータ定義
  [MA Merge Animator]    ← Animatorを統合
  [MA Menu Installer]    ← メニューに追加
  Menu/
    [MA Menu Item]       ← トグル等
  GimmickObject/         ← 実際のメッシュや処理
```

---

## ウィングギミックの例

### Prefab構成

```
WingGimmick/
  [MA Parameters]
    WingsEnabled: Bool, Default=false, Saved=true, Synced=true
  [MA Merge Animator]
    Animator: Wings_FX.controller
    Layer Type: FX
    Match Avatar WD: true
  [MA Menu Installer]
  Menu/
    [MA Menu Item]
      Type: Toggle
      Name: "翼"
      Parameter: WingsEnabled
  Wings/
    [MA Merge Armature]
      Merge Target: アバター/Armature
    Armature/
      Hip/Spine/.../Wing_L_Root/
        Wing_L_1/
          [VRC PhysBone]
    Wings_Mesh/
```

### Wings_FX.controller の内容

```
Layer: Wings Toggle
  Write Defaults: MAが自動調整

  State "Wings OFF" [Default]
    Animation: Wings_OFF.anim
      Wings_Mesh → m_IsActive = 0

  State "Wings ON"
    Animation: Wings_ON.anim
      Wings_Mesh → m_IsActive = 1
      Wings_ParticleEffect → m_IsActive = 1

  Any State → Wings ON: WingsEnabled == true
  Any State → Wings OFF: WingsEnabled == false
```

---

## Contact連動ギミック（頭を触られたら反応）

```
HeadPatGimmick/
  [MA Parameters]
    HeadPat: Bool, Synced=false (ローカルのみ)
  [MA Merge Animator]
    Animator: HeadPat_FX.controller
    Layer Type: FX
  [MA Bone Proxy]       ← 頭部に配置するContactを頭ボーンに追従
    Target: アバター/.../Head
  HeadContactReceiver/
    [VRC Contact Receiver]
      Tags: ["hand"]
      Type: Constant
      Parameter: HeadPat
      Allow Others: true
      Allow Self: false
```

---

## AudioギミックEmoteの例（音付きエモート）

```
AudioEmotePrefab/
  [MA Parameters]
    PlayEmote1: Bool, Default=false, Synced=true
  [MA Merge Animator]
    Animator: Emote_Action.controller
    Layer Type: Action
  [MA Merge Animator]
    Animator: EmoteControl_FX.controller
    Layer Type: FX
  [MA Menu Installer]
  Menu/
    [MA Menu Item]
      Type: Button
      Name: "エモート1"
      Parameter: PlayEmote1
  AudioSource/    ← Animator Play Audio の音源
    AudioSource Component
```

---

## ポイント

### Match Avatar Write Defaultsを必ずONに

`MA Merge Animator` の `Match Avatar Write Defaults` をONにすることで  
アバター既存のWD設定に自動追従。WD混在バグを防ぐ最重要設定。

### パラメータ名は一意になるように

```
悪い例: パラメータ名 "Toggle"（他のギミックと衝突しやすい）
良い例: パラメータ名 "Wings_Toggle" または "GimmickName/Toggle"
```

MAの自動リネーム機能もあるが、明確な名前をつけておく方が管理しやすい。

### PrefabのままアップロードOK

MAコンポーネントがついたままPrefabをUnpackしなくてOK。  
ビルド時にMAが全て処理する。
