# PhysBone コミュニティTips

最終更新: 2026-04-26

---

## 設定値チューニング

### ふわふわした軽い髪
```
Integration: Simplified
Pull: 0.1〜0.15
Spring: 0.4〜0.5
Gravity: 0.2〜0.4
Gravity Falloff: 0.7〜0.9
```
GravityFalloffを高くすると「静止時は自然に立ち、動くとふわっと揺れる」挙動になる。

### 硬めの前髪
```
Pull: 0.4〜0.6
Spring: 0.1〜0.2
Limits: Angle, Max 30〜45°
```

### 水着・スカート（重力無視でパンチラ防止）
```
Gravity: 0.05〜0.1（低め）
Limits: Angle, Max 20〜35°
Pull: 0.35〜0.5
```

### ツインテール・ロングヘア（根元安定＋先端ふわふわ）【実証済み】
カーブが必須。カーブなしだと根元からブランブランになるか、全体が硬くなるかの二択になる。
```
Integration Type: Advanced
Multi Child Type: Ignore     ← Averageだと板のように動く。必ずIgnore
Pull:             0.25  [C]  根元1.0 → 先端0.15
Momentum:         0.5   [C]  根元0.2 → 先端1.0
Stiffness:        0.3   [C]  根元1.0 → 先端0.0
Gravity:          0.3   [C]  根元0.3 → 先端1.0
Gravity Falloff:  0.85  [C]
Immobile:         0.3        ← 0.8は高すぎ。髪が空中で固まる
Max Angle:        90    [C]  根元0.2 → 先端1.0  ← 根元の暴れ防止の核心
Endpoint Position: (0, -0.15, 0)
```
**ポイント:**
- Max Angleカーブの根元を0.2にする = 根元は18°しか動けない = ブランブラン防止
- Immobileを0.8にすると髪が空中で固まる。0.1〜0.3が適正
- Multi Child Type=Averageは全子ボーンの平均方向に動くので板状になる

**よくある失敗パターンと対処:**
| 症状 | 原因 | 対処 |
|------|------|------|
| 髪が空中で固まる | Immobileが高すぎ（0.5以上） | 0.1〜0.3に下げる |
| 根元からブランブラン | Max Angleにカーブなし / Pullが低すぎ | Max Angleカーブ根元0.2、Pull上げる |
| 全体が板のように動く | Multi Child Type=Average | Ignoreに変更 |
| 先端が硬い | Pull/Stiffnessにカーブなし | カーブで先端を0に近づける |
| ふわっと感がない | Momentumが低い / カーブなし | Momentum上げ＋カーブで先端1.0 |

### ふんわりスカート（Hinge型）
タイトなスカートにはAngle制限、ふんわり広がるスカートにはHinge制限が適している。  
Momentumはカーブで根元は強く先端は弱くすることで、裾だけがふわっと広がる動きになる。

```
Integration Type: Advanced
Limit Type: Hinge
Pull:     0.1〜0.2   [C]  根元1.0 → 先端0.4
Momentum: 0.5〜0.7   [C]  根元0.8 → 先端0.2
Immobile: 0.5〜0.7   [C]  根元1.0 → 先端0.1
Max Angle: 60〜90°
Radius: 0.02〜0.03   [C]  根元0.5 → 先端1.0  ← 裾ほど広く（足との貫通防止）
```

**足との貫通防止コライダー配置（スカート向け）:**
| 場所 | 形状 | Radius目安 |
|------|------|-----------|
| UpperLeg_L/R | Capsule | 0.08〜0.12 |
| LowerLeg_L/R | Capsule | 0.06〜0.09 |

→ スカートのPhysBone > Colliders リストに追加する。  
→ Radiusカーブで先端を大きくすると裾が足を避けながら広がる。

出典: https://note.com/x9n_note/n/nb45abf2f9e5a, https://cgbox.jp/2023/09/01/vrchat-physbone-howto/

### 揺れない（でも掴める）アクセサリー
```
Pull: 0.95〜1.0
Spring: 0.0
Allow Grabbing: true
Grab Movement: 1.0
Snap To Hand: true
```

---

## カーブ活用Tips

### 「自然な髪」を作る最低限のカーブ
最低でもPullにカーブを入れるだけで劇的に改善する:
```
Pull: 0.2、カーブ: 根元1.0 → 先端0.2
→ 根元はしっかり、先端だけ揺れる
```
他のパラメータはカーブなし（均一）のままでもOK。

### ボーン分割が少ない時のカーブ戦略
ボーンが2〜3本しかない場合:
- Pull カーブを急勾配にする（根元1.0 → 先端0.0）
- Max Angle カーブも入れる（根元0.3 → 先端1.0）
- Endpoint Positionを追加して仮想ボーン1本分の揺れを増やす

### Collision Radius カーブで毛先の引っかかりを防止
```
Radius: 0.04、カーブ: 根元1.0 → 先端0.3
→ 根元はしっかり体に当たるが、先端はすり抜ける
→ 毛先がColliderに引っかかって不自然に止まるのを防止
```

### カーブプリセットの活用
カーブエディタ下部にプリセット（直線・S字・急降下等）がある。  
まずプリセットから選んで微調整する方が効率的。

---

## Collider配置Tips

### マシュマロPhysBone（胸揺れ）との連携
胸にColliderを付ける場合、静的なChestボーンではなく**マシュマロPhysBoneのRootボーン**（例: Breast_L/R）に付ける。
→ 胸が揺れるとColliderも一緒に動き、髪が追従する。

### 長髪の上半身Collider推奨配置
| 場所 | 形状 | Radius目安 |
|------|------|-----------|
| Head | Sphere | 0.10〜0.12 |
| Neck | Sphere | 0.06〜0.08 |
| Chest | Capsule (Height=0.25〜0.35) | 0.11〜0.14 |
| Breast_L/R（マシュマロ） | Sphere | 0.07〜0.10 |
| Shoulder_L/R | Sphere | 0.07〜0.09 |
| UpperArm_L/R（腕まで届く場合） | Sphere | 0.05〜0.07 |

### Plane Colliderで尻尾の地面貫通を防止
足元にPlane Collider（無限平面）を置いて尻尾のCollidersに登録。
→ 尻尾が地面以下に落ちなくなる。

### Bones As Sphere でパフォーマンス節約
ボーン間の接続（シリンダー）まで計算する必要がなければON。
→ 計算コストが減りパフォーマンス改善。

---

## 小技

### 複数の揺れ物を1コンポーネントにまとめる
同じパラメータで動かして良い複数ボーンはIgnore Transformsで除外しつつ、  
階層構造を工夫すれば1コンポーネントにまとめられる。  
→ PhysBone Components 数を節約してパフォーマンスランク改善。

### Endpoint Positionの調整でボーンの「重さ感」を変える
末端が長いほど慣性が大きくなる感じになる。  
実際のボーン長より少し長めに設定すると「先が重い」動きになる。

### Polarは使わない
Polar制限は重いので、Angle or Hingeで代用できる場合は避ける。  
特に頭部パーツ（耳・角）はAngleで十分なことが多い。

### PhysBoneのParameterは必要な時だけ設定
Parameterを設定すると毎フレーム値を更新するコストが発生する。  
掴みに反応しないなら設定しなくてよい。

---

## よくある間違い

| 間違い | 正しい対処 |
|-------|---------|
| 1つのGameObjectにPhysBoneとConstraintを両方つける | 親オブジェクトを作ってどちらかをそこに移す |
| HipやSpineをRoot Transformに指定してしまう | 指定しない（Humanoidボーンは禁止） |
| 単一ボーンでEndpoint Positionが (0,0,0) のまま | 非ゼロ値を入れる（例: Y=0.1） |
| 64個以上のPolar制限 | Angle制限に変更するか数を減らす |
| Pullを0にしてGravityを設定 | Pull=0だとGravityが機能しない。最低0.01以上に |
| Colliderを追加しただけで終わり | 髪のPhysBone > Colliders リストにも登録が必要 |
| Allow Collision=FalseでCollider無効と思い込む | FalseはグローバルColliderのみ無効。リスト内Colliderは有効 |

---

## パフォーマンス節約テクニック

- **Local Only**: 自分の揺れを自分だけで計算。他者に影響しない揺れものはこれ
- **Ignore Transforms**: 揺らす必要のないボーン（バックル等）は除外
- **Radius**: 衝突判定不要なら0にする（計算コスト削減）
- **Allow Collision**: 不要なら「None」に設定
