# MA Menu Installer / Menu Item / Menu Group

公式: https://modular-avatar.nadena.dev/docs/reference/menu-installer

Expression MenuをPrefab内から自動でアバターのメニューに追加するコンポーネント群。

---

## Menu Installer

アバターのExpression MenuにPrefab内のメニューを自動で追加する。

### パラメータ

| パラメータ | 型 | 説明 |
|-----------|-----|------|
| Menu to Install | Expression Menu | 追加するExpression Menuアセット |
| Install Target Menu | Expression Menu | インストール先のメニュー（省略=Root Menu） |

### 配置方法

```
ギミックPrefab
  [MA Menu Installer]
    Menu to Install: Wings_Menu（Expression Menuアセット）
    Install Target: （省略でRoot Menuに追加）
  Wings_Object/
```

ビルド時にアバターのRoot Menu（またはInstall Target）に自動でメニューが追加される。

---

## Menu Item

**Expression Menuアセットを作らずに**、Unity階層上から直接メニュー項目を定義する方法。

### コントロール種別と設定

| Type | 動作 | 必要なパラメータ設定 |
|------|------|------------------|
| Button | クリック時に値設定、約1秒後リセット | Parameter + Value |
| Toggle | ON/OFF切り替え | Parameter + Value |
| Sub Menu | 別メニューを開く | Sub Menu ソース |
| Two Axis Puppet | 2軸ジョイスティック | Horizontal + Vertical パラメータ |
| Four Axis Puppet | 4軸ジョイスティック | Up/Down/Left/Right パラメータ |
| Radial Puppet | 円形スライダー | 1つのFloatパラメータ |

### Sub Menu のソース指定方法

| 方法 | 説明 |
|------|------|
| Children | MA Menu Itemの子オブジェクトのMenu Itemをサブメニューとして使用 |
| Expression Menu Asset | 別途作ったExpression Menuアセットを参照 |
| Menu Installer | 別のMenu Installerを参照 |

### パラメータ設定オプション

| オプション | 説明 |
|---------|------|
| Automatic | MA Parametersで定義した名前を自動で使用 |
| Parameter Name | 明示的にパラメータ名を指定 |
| Save | Saved=trueとしてExpression Parametersに登録 |
| Sync | Synced=trueとしてネットワーク同期 |

---

## Menu Group

複数のMenu Itemをサブメニューにせず**フラット**にインストールする。

```
Menu Group "各種トグル"
  └─ Menu Item "Wings" → WingsEnabled
  └─ Menu Item "Halo"  → HaloEnabled
  └─ Menu Item "Tail"  → TailEnabled

→ Root Menuに直接3つのトグルが追加される（サブメニューにならない）
```

---

## 典型的なPrefab構成

### シンプルなToggle（Expression Menuアセット不要）

```
ウィングPrefab
  [MA Parameters]
    WingsEnabled: Bool, Synced, Saved
  [MA Menu Installer]
    ← Menu to Installを空のままにし、下の Menu Item を使う
  Menu/
    [MA Menu Item]  ← Menu InstallerのGameObjectの子に配置
      Type: Toggle
      Name: "翼"
      Parameter: WingsEnabled
      Value: true
  Wings_Object/
```

### Sub Menuを使った複数項目

```
衣装Prefab
  [MA Parameters]
    Outfit: Int, Synced, Saved
  [MA Menu Installer]
  OutfitMenu/                   ← これがSub Menuになる
    [MA Menu Item]
      Type: Sub Menu
      Name: "衣装"
      Sub Menu Source: Children  ← 子のMenu Itemを使う
    Default/
      [MA Menu Item]
        Type: Toggle
        Name: "デフォルト"
        Parameter: Outfit = 0
    Casual/
      [MA Menu Item]
        Type: Toggle
        Name: "カジュアル"
        Parameter: Outfit = 1
```

---

## Menu Installer と Menu Item の使い分け

| 方法 | 向いている用途 |
|------|-------------|
| Menu Installer + Expression Menuアセット | 既存のExpression Menuを流用したい |
| Menu Installer + Menu Item（階層） | 全てをPrefab内で完結させたい（推奨） |
| Menu Item単独（Menu Installerなし） | 別のMenu Installerの子として使う場合 |
