# MAで衣装を追加したい

Modular Avatarを使ってアバターに衣装をドラッグ&ドロップで追加する手順。

---

## 最小構成（ボーンのみマージ）

### 手順

1. 衣装PrefabをアバターのGameObject配下にドラッグ
2. 衣装PrefabのルートGameObjectに `MA Merge Armature` を追加
3. `Merge Target` にアバターの `Armature` をドラッグ

```
アバター/
  [VRC Avatar Descriptor]
  Armature/          ← ここをMerge Targetに指定
    Hips/
    ...
  Body（メッシュ）
  衣装Prefab/        ← ここにドラッグ
    [MA Merge Armature]  ← 追加
      Merge Target: アバター/Armature
    Armature/
      Hips/（衣装ボーン）
    DressMesh/
```

ビルドすると衣装のボーンとアバターのボーンが自動でマージされる。

---

## メニュー付き衣装（ON/OFF切り替え）

衣装をメニューからON/OFFできるようにする。

```
衣装Prefab/
  [MA Merge Armature]
    Merge Target: アバター/Armature
  [MA Parameters]
    DressEnabled: Bool, Default=true, Saved=true, Synced=true
  [MA Menu Installer]
  Menu/
    [MA Menu Item]
      Type: Toggle
      Name: "ドレス"
      Parameter: DressEnabled
  [MA Object Toggle]
    ← DressEnabledがfalseの時、衣装メッシュを非表示にする
  DressMesh/
```

---

## ボディのめり込み補正付き衣装

タイトな衣装でボディがめり込む場合の対処。

```
衣装Prefab/
  [MA Merge Armature]
  [MA Parameters]
    DressEnabled: Bool
  [MA Menu Installer]
  ...
  BodyAdjust/
    [MA Shape Changer]        ← 衣装ONの時だけボディ形状を変える
      Target: アバター/Body
      Blendshape: "BodyFit_Dress" → 100
```

`MA Shape Changer` は `MA Menu Item` と同じGameObjectかその子に配置することで、  
Toggle ONの時だけBlendShapeを適用する。

---

## 複数衣装の切り替え（Int版）

```
衣装システムPrefab/
  [MA Parameters]
    Outfit: Int, Default=0, Saved=true, Synced=true
  [MA Menu Installer]
  OutfitMenu/
    [MA Menu Item]
      Type: Sub Menu
      Name: "衣装"
      Sub Menu: Children
    Default/
      [MA Menu Item]
        Type: Toggle
        Name: "デフォルト"
        Parameter: Outfit = 0
      Default_Mesh/
        [MA Object Toggle]
          Object: DefaultDress_Mesh
          Active: true（Outfit=0のGameObjectがアクティブな時）
    Casual/
      [MA Menu Item]
        Type: Toggle
        Name: "カジュアル"
        Parameter: Outfit = 1
      Casual_Mesh/
        [MA Object Toggle]
          Object: CasualDress_Mesh
          Active: true
```

---

## 衣装を配布・購入した場合（既製品Prefabの使い方）

MA対応の衣装はPrefabをドラッグするだけで動作するものが多い。

**手順:**
1. 衣装PrefabをUnityに Import
2. アバターのGameObjectの子にドラッグ
3. Play Mode または Build でプレビュー確認
4. 必要に応じてPosition/Rotationを調整

**確認ポイント:**
- Prefabに `MA Merge Armature` が含まれているか
- ボーン構造がアバターと一致しているか（体型が大きく違う場合は調整が必要）
- PhysBone等が正しく動作しているか

---

## トラブルシューティング

### メッシュがボーンについてこない
- `Merge Target` が正しいArmatureを指しているか確認
- 衣装とアバターのボーン名が一致しているか確認

### 衣装が体にめり込む
- `MA Shape Changer` でボディのBlendShapeを調整
- Unityの通常のTransform調整で衣装の位置を微調整

### トグルが機能しない
- `MA Parameters` でパラメータを定義しているか確認
- `MA Menu Item` のパラメータ名が `MA Parameters` と一致しているか確認
