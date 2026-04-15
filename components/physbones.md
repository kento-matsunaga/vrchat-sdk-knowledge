# VRC Phys Bone

最終更新: 2026-04-16  
公式: https://creators.vrchat.com/avatars/avatar-dynamics/physbones/  
参照: https://creators.vrchat.com/common-components/physbones/

ボーンチェーンに物理シミュレーション・他プレイヤーによる掴み操作を追加するコンポーネント。

---

## 禁止事項（必読）

- **Constraintと同一GameObjectに配置しない** → 親オブジェクトに配置する
- **Humanoidボーン（Hip, Spine, Chest等）をRootに設定しない** → アバター移動機能が壊れる
- **PhysBoneのプロパティをAnimationで変更しない**
- **単一ボーンのPhysBoneはEndpoint Positionを必ず非ゼロ値に設定する**

---

## カーブ（Curve）機能

公式: "Curves let you adjust the value over the length of the bone chain"

ほぼ全てのパラメータでカーブが使用可能。パラメータ横の **[C]ボタン** を押すとカーブエディタが開く。

### 軸の意味

```
横軸（X）: ボーンチェーン上の位置
  0.0 = 根元（Root側）
  1.0 = 先端（Tip側）

縦軸（Y）: パラメータ値の倍率
  0.0 = 0%（効果なし）
  1.0 = 100%（設定値そのまま）
```

### 計算方法

```
実際の値 = パラメータ設定値 × カーブの値

例: Pull = 0.2、カーブが根元1.0 → 先端0.0 の場合
  根元ボーン: 0.2 × 1.0 = 0.2（硬い）
  中間ボーン: 0.2 × 0.5 = 0.1
  先端ボーン: 0.2 × 0.0 = 0.0（完全にやわらかい）
```

### 操作方法

- ダイヤモンド型ノードをドラッグして値を調整
- カーブ上をダブルクリックで新しいノードを追加
- ノードから出る線の角度を変えて曲線を調整
- 画面下部のプリセットから選択も可能
- [X]ボタンでカーブモードを解除（均一値に戻る）

### カーブ対応パラメータ一覧

| セクション | パラメータ |
|---------|---------|
| Forces | Pull, Spring, Momentum, Stiffness, Gravity, Gravity Falloff |
| Limits | Max Angle, Pitch, Yaw |
| Collision | Radius |
| Stretch & Squish | Stretch Motion, Max Stretch, Max Squish |

### 各パラメータのカーブ活用例

#### Pull カーブ（最重要）
```
根元1.0 → 先端0.2
効果: 根元は硬く、先端ほどやわらかく揺れる
用途: 最も自然な髪の表現。これだけで劇的に改善する
```

#### Stiffness カーブ（Advanced）
```
根元1.0 → 先端0.0
効果: 根元は元の形を保ち、先端は完全に自由に動く
用途: 前髪の根元が顔にめり込まず、毛先は軽やかに
```

#### Momentum カーブ（Advanced）
```
根元0.3 → 先端1.0
効果: 先端ほどよく弾んで揺れ続ける
用途: 毛先がぴょんぴょん跳ねる表現
```

#### Gravity カーブ
```
根元0.3 → 先端1.0
効果: 毛先だけが重力で下に垂れる
用途: 根元は形を維持しつつ先端が自然に下がる
```

#### Max Angle カーブ
```
根元0.4 → 先端1.0（Max Angle=90°の場合）
効果: 根元は36°まで、先端は90°まで動ける
用途: 根元が暴れず先端は大きく動く。長い髪に最適
```

#### Collision Radius カーブ
```
根元1.0 → 先端0.3
効果: 根元は体にしっかり当たるが、先端はすり抜けやすい
用途: 毛先が体に引っかかるのを防止
```

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
| Pull | Float | 0〜1 | 静止位置への引き戻し力（高いほど硬い）。**カーブ対応** |
| Spring | Float | 0〜1 | 静止位置に戻ろうとする時のウォブル量（Simplifiedのみ）。**カーブ対応** |
| Momentum | Float | 0〜1 | 慣性の大きさ。Springと似た効果だが異なる実装（Advancedのみ）。**カーブ対応** |
| Stiffness | Float | 0〜1 | 直前の向きを保とうとする力の比率（Advancedのみ）。**カーブ対応** |
| Gravity | Float | -1〜1 | 重力影響度。静止時にボーンがどの程度回転するかの比率。正=下、負=上。**カーブ対応** |
| Gravity Falloff | Float | 0〜1 | 静止時のGravity削減率。1.0=静止時はGravityの影響を完全に無視。**カーブ対応** |
| Immobile Type | Enum | All Motion / World | 不動判定の基準 |
| Immobile | Float | 0〜1 | 不動量（0=完全追従、1=完全不動） |

**Integration Type 選択指針:**
- **Simplified**: 軽量。SpringでウォブルをコントロールMll。髪・耳・尾など通常用途
- **Advanced**: 精密。Stiffness（形状維持）とMomentum（慣性）で細かく制御。まずSimplifiedで試してからAdvancedに移行するのが推奨

**Immobile Type の違い:**
| モード | 動作 |
|-------|------|
| All Motion | あらゆる動き（歩行・回転含む）に対してImmobile値を適用 |
| World（実験的） | ワールド空間での移動のみに対してImmobile値を適用 |

**重要: Pullが0の場合、Gravityが機能しない**（公式バグ報告あり）。Gravityを使う場合はPullを最低0.01以上に設定する。

### Limits セクション（動きの制限）

| タイプ | パラメータ | 範囲 | 形状 | 用途 |
|-------|-----------|------|------|------|
| None | なし | - | 制限なし | 完全自由 |
| Angle | Max Angle | 0〜180° | コーン状 | 単軸制限（髪など）。**カーブ対応** |
| Hinge | Max Angle | 0〜180° | 扇形（蝶番） | ドア・ひざなど。**カーブ対応** |
| Polar | Pitch / Yaw | - | 球面楕円 | 複雑な3D制限。**カーブ対応** |

共通パラメータ: Rotation（X, Y, Z）で制限の軸方向を調整

> **注意:** Polar制限は64個以上使用するとパフォーマンスが著しく低下する

### Collision セクション

| パラメータ | 型 | 説明 |
|-----------|-----|------|
| Radius | Float (最大1.0m) | 各ボーン周辺のコリジョン半径（メートル単位）。掴み判定にも使用。**カーブ対応** |
| Allow Collision | Enum | 他プレイヤーの手/指との衝突設定（下記参照） |
| Colliders | List | このPhysBoneと衝突するPhysBone Colliderのリスト |

**Allow Collision 選択肢:**
| 値 | 動作 |
|----|------|
| True | 全プレイヤーの指・手のグローバルコライダーと衝突する |
| False | グローバルコライダーとは衝突しない。**Collidersリスト内のColliderとは衝突する** |
| Other | Self（自分）とOthers（他プレイヤー）を個別にON/OFF設定 |

> **重要:** Allow CollisionがFalseでも、CollidersリストにPhysBone Colliderを入れていればそれとは衝突する

### Stretch & Squish セクション

| パラメータ | 型 | 範囲 | 説明 |
|-----------|-----|------|------|
| Stretch Motion | Float | 0〜1 | 動きによる伸縮量。0=掴み・衝突時のみ伸縮。**カーブ対応** |
| Max Stretch | Float | 1.0〜 | 最大伸び倍率（元のボーン長に対する倍数）。**カーブ対応** |
| Max Squish | Float | 0〜1 | 最大縮み割合（元のボーン長に対する倍数）。**カーブ対応** |

### Grab & Pose セクション

| パラメータ | 型 | 説明 |
|-----------|-----|------|
| Allow Grabbing | Bool | 他プレイヤーが掴めるか |
| Allow Posing | Bool | 掴んだ状態でポーズを固定できるか |
| Grab Movement | Float (0〜1) | 掴まれた時の追従速度（0=物理挙動、1=手に即座追従） |
| Snap To Hand | Bool | 掴んだ時に手の位置にスナップ |

---

## VRC PhysBone Collider コンポーネント

PhysBoneとの衝突判定を提供する別コンポーネント。PhysBoneと同じGameObjectまたは任意のGameObjectに追加可能。

### 全設定項目

| パラメータ | 型 | 説明 |
|-----------|-----|------|
| Root Transform | Transform | Colliderが追従するトランスフォーム。空の場合はGameObject自身 |
| Shape Type | Enum | 衝突形状: Sphere / Capsule / Plane |
| Radius | Float (メートル) | 原点からのコライダーサイズ |
| Height | Float (メートル) | CapsuleのY軸高さ（両端の半球を含む）。Capsule時のみ |
| Position | Vector3 | Root Transformからの位置オフセット |
| Rotation | Quaternion | Root Transformからの回転オフセット |
| Inside Bounds | Bool | ONの場合ボーンをCollider内側に収める（デフォルトOFF=外側に弾く） |
| Bones As Sphere | Bool | ONの場合ボーンの衝突をカプセルではなく球として扱う |

### Shape Type 詳細

| 形状 | 説明 | 用途 |
|------|------|------|
| **Sphere** | 半径で定義される球体 | 頭・肩・胸など丸い部位 |
| **Capsule** | 半径+高さで定義されるカプセル。Y軸方向に延びる | 胴体・腕など細長い部位 |
| **Plane** | X・Z軸上の無限平面。+Y方向を向く | 地面・床との衝突。尻尾が地面を貫通しないようにする |

### Inside Bounds

| 設定 | 動作 | 用途 |
|------|------|------|
| OFF（デフォルト） | ボーンをColliderの**外側に弾く** | 髪が体を貫通しないようにする（通常用途） |
| ON | ボーンをColliderの**内側に収める** | ボーンを特定の領域内に閉じ込めたい場合（特殊用途） |

Sphere/Capsuleでのみ使用可能。Planeでは使用不可。

### Bones As Sphere

| 設定 | 動作 |
|------|------|
| OFF（デフォルト） | ボーン間のシリンダー（円柱）接続も含めてカプセル形状で衝突判定 |
| ON | 各ボーン位置の球体のみで衝突判定（シリンダーを無視。軽量） |

### Plane Collider の活用

Planeは無限平面のため、地面・床として使うのが主な用途。

```
例: 尻尾が地面を貫通しないように
  足元の位置に Plane Collider を配置
  → 尻尾の PhysBone の Colliders リストに追加
  → 尻尾が地面以下に落ちなくなる

応用: VRC Raycast と組み合わせてジャンプ時も追従する動的な床を作る
（参考: BluWizard10/dynamic-floor）
```

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
| ランク | PhysBone数 | Collision Check Count |
|-------|-----------|----------------------|
| Excellent | 4以下 | 32以下 |
| Good | 8以下 | 128以下 |
| Medium | 16以下 | 256以下 |
| Poor | 32以下 | 512以下 |

---

## 典型的な設定例

### 髪の揺れ（基本）
```
Integration Type: Simplified
Pull: 0.2
Spring: 0.3
Gravity: 0.3
Max Angle: 60° (Angle制限)
Allow Grabbing: false
```

### ゆるふわ長髪（カーブ活用）
```
Integration Type: Advanced
Pull: 0.15       カーブ: 根元1.0 → 先端0.2
Stiffness: 0.2   カーブ: 根元1.0 → 先端0.0
Momentum: 0.7    カーブ: 根元0.3 → 先端1.0
Gravity: 0.25    カーブ: 根元0.3 → 先端1.0
Max Angle: 90°   カーブ: 根元0.4 → 先端1.0
Endpoint Position: (0, -0.15, 0)
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
