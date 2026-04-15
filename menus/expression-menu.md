# Expression Menu & Controls

公式: https://creators.vrchat.com/avatars/expression-menu-and-controls/

アクションメニュー（円形メニュー）に表示されるUIコントロールを定義するアセット。

---

## 作成方法

```
Project ウィンドウ右クリック
→ Create > VRChat > Avatars > Expressions Menu
```

Avatar Descriptor の Expressions > Menu に割り当てる。

---

## メニューの制限

- **1メニューあたり最大8コントロール**
- Sub-Menuを使えば階層化して実質無制限に増やせる

---

## コントロール種別（6種）

### 1. Button
| 項目 | 説明 |
|------|------|
| 動作 | クリックした間だけパラメータに値を設定、約1秒後に自動でリセット |
| 用途 | エモート発動、単発エフェクト |
| パラメータ型 | Float / Int / Bool |

```
例: エモート1番を再生
  Parameter: VRCEmote
  Value: 1
```

### 2. Toggle
| 項目 | 説明 |
|------|------|
| 動作 | ON/OFFを切り替える（状態を保持） |
| 用途 | アイテム表示切り替え、衣装変更、エフェクト常時ON |
| パラメータ型 | Bool（ON時true） / Float / Int |

```
例: 翼をON/OFF
  Parameter: WingsEnabled (Bool)
  Value: true（ON時）
```

### 3. Sub-Menu
| 項目 | 説明 |
|------|------|
| 動作 | 別のExpression Menuを開く |
| 用途 | メニューの階層化、カテゴリ分け |

```
例: "衣装" サブメニュー
  → 衣装A Toggle
  → 衣装B Toggle
  → アクセサリー Sub-Menu
```

### 4. Two-Axis Puppet
| 項目 | 説明 |
|------|------|
| 動作 | ジョイスティックで2軸制御 |
| 用途 | 目線制御、体の傾き、2次元的な動き |
| パラメータ | Horizontal / Vertical それぞれFloat |
| 値範囲 | -1.0〜1.0（中央が0） |
| 同期方式 | **IK Sync（連続更新）** |

### 5. Four-Axis Puppet
| 項目 | 説明 |
|------|------|
| 動作 | ジョイスティックで4方向を制御 |
| 用途 | 4方向それぞれに独立した動き |
| パラメータ | Up / Right / Down / Left それぞれFloat |
| 値範囲 | 0.0〜1.0（中央が0、各方向が1.0） |
| 同期方式 | **IK Sync（連続更新）** |

### 6. Radial Puppet
| 項目 | 説明 |
|------|------|
| 動作 | 円形スライダーで1軸制御（プログレスバー形式） |
| 用途 | 音量、明るさ、単一パラメータのスムーズな調整 |
| パラメータ | Float × 1 |
| 値範囲 | 0.0〜1.0 |
| 同期方式 | **IK Sync（連続更新）** |

---

## 同期方式の違い

| コントロール | 同期方式 | 特徴 |
|------------|---------|------|
| Button / Toggle | Playable Sync（オンデマンド） | 変更時のみ送信。遅延あり |
| Puppet系（2/4軸/Radial） | IK Sync（連続） | 毎フレーム送信。ラグ少ない |

Puppetを開いている間は常にIK Syncで送信されるため、他のパラメータ更新が遅くなる可能性がある。

---

## コントロールの共通設定

| 設定 | 説明 |
|------|------|
| Name | メニューに表示されるラベル |
| Icon | メニューに表示されるアイコン（Texture2D） |
| Parameter | 制御するAnimatorパラメータ名 |
| Value | パラメータに設定する値 |
| Style | コントロールのアイコンスタイル |

---

## 典型的なメニュー構成例

```
Root Menu
├── Emote        [Sub-Menu]
│   ├── Emote1   [Button] → VRCEmote = 1
│   ├── Emote2   [Button] → VRCEmote = 2
│   └── Emote3   [Button] → VRCEmote = 3
├── Outfit       [Sub-Menu]
│   ├── Default  [Toggle] → Outfit = 0
│   ├── Casual   [Toggle] → Outfit = 1
│   └── Formal   [Toggle] → Outfit = 2
├── Wings        [Toggle] → WingsEnabled = true
├── Face         [Radial Puppet] → FaceBlend (Float)
└── Look Dir     [Two-Axis Puppet] → LookH / LookV
```
