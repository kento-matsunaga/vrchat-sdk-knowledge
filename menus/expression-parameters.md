# Expression Parameters

公式: https://creators.vrchat.com/avatars/expression-menu-and-controls/

アバターで使用するカスタムパラメータを定義するアセット。

---

## 作成方法

```
Project ウィンドウ右クリック
→ Create > VRChat > Avatars > Expression Parameters
```

Avatar Descriptor の Expressions > Parameters に割り当てる。

---

## パラメータ定義

| 項目 | 説明 |
|------|------|
| Name | Animatorと一致する名前（大文字小文字区別） |
| Type | Int / Float / Bool |
| Default | 初期値 |
| Saved | アバター切り替え後も値を保持するか |
| Synced | 他プレイヤーにネットワーク同期するか |

---

## 型と範囲

| 型 | ネットワーク同期時の範囲 | ローカル時の範囲 | 使用ビット |
|----|----------------------|----------------|---------|
| Bool | true / false | true / false | 1 bit |
| Int | 0 〜 255 | 制限なし | 8 bit |
| Float | -1.0 〜 1.0 | 制限なし | 8 bit（量子化） |

**Float の量子化について:**  
Floatは8bitで量子化して送信されるため、約0.008の精度誤差がある。  
精密な値が必要な場合はローカルパラメータ（Synced=false）を使用する。

---

## ビット数制限

全パラメータの合計ビット数: **最大256bit**

```
例:
  Bool × 8  = 8 bit
  Int  × 4  = 32 bit
  Float× 4  = 32 bit
  合計      = 72 bit（問題なし）
```

ビット数が超えると追加できない。不要なパラメータは削除する。

---

## Saved オプション

| 設定 | 動作 |
|------|------|
| true | アバター切り替え・ワールド移動後も値を保持 |
| false | ログイン/アバター切り替え時にDefaultにリセット |

**Saved=trueにすべきもの:**
- 衣装の状態（着替えた状態を維持したい）
- 常時ON/OFFしたいトグル

**Saved=falseにすべきもの:**
- エモート（毎回デフォルトで始まるべき）
- 一時的な状態

---

## Synced オプション

| 設定 | 動作 |
|------|------|
| true | 他のプレイヤーに現在値を送信、互いに同期 |
| false | 自分のクライアントのみ。他プレイヤーには見えない |

**Synced=falseの用途:**
- ローカルエフェクト（自分にしか見えないもの）
- ビット節約（他人に見せる必要のないもの）
- AnimationCurveの精密制御（ローカルのFloatはクランプなし）

---

## デフォルトで存在するパラメータ

| 名前 | 型 | 説明 |
|------|-----|------|
| VRCEmote | Int | デフォルトエモート番号（1〜16） |
| VRCFaceBlendH | Float | 水平方向のフェイスブレンド |
| VRCFaceBlendV | Float | 垂直方向のフェイスブレンド |

---

## よくある設計パターン

### トグル（Bool）
```
Name: WingsEnabled
Type: Bool
Default: false
Saved: true
Synced: true
```

### 衣装選択（Int）
```
Name: Outfit
Type: Int
Default: 0   (0=デフォルト衣装)
Saved: true
Synced: true
```
→ Animatorで Outfit == 0, 1, 2 で条件分岐

### 表情強度（Float）
```
Name: SmileIntensity
Type: Float
Default: 0
Saved: false
Synced: true
```
→ Radial Puppetで -1.0〜1.0 を制御
