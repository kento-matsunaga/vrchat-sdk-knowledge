# VRC Phys Bone

公式: https://creators.vrchat.com/avatars/avatar-dynamics/physbones/

ボーンチェーンに物理シミュレーション・他プレイヤーによる掴み操作を追加するコンポーネント。

---

## 禁止事項（必読）

- **Constraintと同一GameObjectに配置しない** → 親オブジェクトに配置する
- **Humanoidボーン（Hip, Spine, Chest等）をRootに設定しない**
- **PhysBoneのプロパティをAnimationで変更しない**
- **単一ボーンのPhysBoneはEndpoint Positionを必ず非ゼロ値に設定する**

---

## パラメータ一覧

### Transforms セクション

| パラメータ | 型 | 説明 |
|-----------|-----|------|
| Root Transform | Transform | チェーン開始ボーン。空の場合は現在のGameObject |
| Ignore Transforms | List\<Transform\> | 物理の影響を受けないボーン |
| Endpoint Position | Vector3 | チェーン末端に仮想ボーンを追加（単一ボーン時は必須） |
| Multi-Child Type | Enum | ルートに複数子ボーンある時の動作 |

**Multi-Child Type 選択肢:**
| 値 | 動作 |
|----|------|
| Ignore | ルートボーン自体を動かさない（推奨） |
| First | 最初の子ボーンのみ追従 |
| Average | 全子ボーンの平均方向に追従 |

### Forces セクション

| パラメータ | 型 | 範囲 | 説明 |
|-----------|-----|------|------|
| Integration Type | Enum | Simplified / Advanced | 物理計算方式 |
| Pull | Float | 0〜1 | 静止位置への引き戻し力（高いほど硬い） |
| Spring | Float | 0〜1 | ウォブル量（Simplifiedのみ） |
| Momentum | Float | 0〜1 | 慣性の大きさ（Advancedのみ） |
| Stiffness | Float | 0〜1 | 静止位置保持比率（Advancedのみ） |
| Gravity | Float | -1〜1 | 重力影響度（正=下向き、負=上向き） |
| Gravity Falloff | Float | 0〜1 | 静止時に重力を削減する割合 |

**Integration Type 選択指針:**
- Simplified: 軽量。髪・耳・尾など通常用途
- Advanced: 精密。Stiffness/Momentumで挙動を細かく制御したい時

### Limits セクション（動きの制限）

| タイプ | パラメータ | 範囲 | 形状 | 用途 |
|-------|-----------|------|------|------|
| None | なし | - | 制限なし | 完全自由 |
| Angle | Max Angle | 0〜180° | コーン状 | 単軸制限（髪など） |
| Hinge | Max Angle | 0〜180° | 扇形（蝶番） | ドア・ひざなど |
| Polar | Pitch / Yaw | - | 球面楕円 | 複雑な3D制限 |

> **注意:** Polar制限は64個以上使用するとパフォーマンスが著しく低下する

### Collision セクション

| パラメータ | 型 | 上限 | 説明 |
|-----------|-----|------|------|
| Radius | Float | 1.0m | ボーンのコリジョン半径 |
| Allow Collision | Enum | - | グローバルコライダーとの衝突設定 |

### Stretch & Squish セクション

| パラメータ | 型 | 範囲 | 説明 |
|-----------|-----|------|------|
| Stretch Motion | Float | 0〜1 | モーション方向への伸び率 |
| Max Stretch | Float | 1.0〜 | 最大伸び倍率（1.0=変化なし） |
| Max Squish | Float | 0〜1 | 最大縮み割合（0=縮まない） |

### Grab & Pose セクション

| パラメータ | 型 | 説明 |
|-----------|-----|------|
| Allow Grabbing | Bool | 他プレイヤーが掴めるか |
| Allow Posing | Bool | 掴んだ状態でポーズを固定できるか |
| Grab Movement | Float (0〜1) | 掴まれた時の追従速度（0=物理挙動、1=手に即座追従） |
| Snap To Hand | Bool | 掴んだ時に手の位置にスナップ |

---

## アニメータパラメータ（自動生成）

PhysBoneに **Parameter** 名を設定すると以下のパラメータが自動生成される:

| パラメータ名 | 型 | 範囲 | 説明 |
|------------|-----|------|------|
| `{name}_IsGrabbed` | Bool | - | 現在掴まれているか |
| `{name}_IsPosed` | Bool | - | ポーズ固定されているか |
| `{name}_Angle` | Float | 0.0〜1.0 | 現在の回転角度（正規化） |
| `{name}_Stretch` | Float | 0.0〜1.0 | 現在の伸び量 |
| `{name}_Squish` | Float | 0.0〜1.0 | 現在の縮み量 |

---

## パフォーマンス制限

| 項目 | 制限 |
|------|------|
| 単一コンポーネントの影響トランスフォーム数 | 256個 |
| Polar制限の推奨使用数 | 64個未満 |
| バウンディングボックス | 10×10×10m以内 |

**Performanceランク基準 (PC):**
| ランク | PhysBone数 |
|-------|-----------|
| Excellent | 4以下 |
| Good | 8以下 |
| Medium | 16以下 |
| Poor | 32以下 |

---

## 典型的な設定例

### 髪の揺れ
```
Integration Type: Simplified
Pull: 0.2
Spring: 0.3
Gravity: 0.3
Max Angle: 60° (Angle制限)
Allow Grabbing: false
```

### 掴める尻尾
```
Integration Type: Simplified
Pull: 0.15
Spring: 0.4
Gravity: 0.2
Allow Grabbing: true
Snap To Hand: true
Grab Movement: 0.5
Parameter: "Tail"
```

### 衣装フリル（伸縮あり）
```
Integration Type: Simplified
Pull: 0.3
Max Stretch: 1.3
Max Squish: 0.2
Stretch Motion: 0.5
```
