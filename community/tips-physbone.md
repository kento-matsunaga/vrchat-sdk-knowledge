# PhysBone コミュニティTips

最終更新: 2026-04-16

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

### 揺れない（でも掴める）アクセサリー
```
Pull: 0.95〜1.0
Spring: 0.0
Allow Grabbing: true
Grab Movement: 1.0
Snap To Hand: true
```

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

---

## パフォーマンス節約テクニック

- **Local Only**: 自分の揺れを自分だけで計算。他者に影響しない揺れものはこれ
- **Ignore Transforms**: 揺らす必要のないボーン（バックル等）は除外
- **Radius**: 衝突判定不要なら0にする（計算コスト削減）
- **Allow Collision**: 不要なら「None」に設定
