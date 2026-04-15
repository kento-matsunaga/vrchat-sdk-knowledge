# MA Scale Adjuster / Bone Proxy / Misc

最終更新: 2026-04-16

---

## MA Scale Adjuster

公式: https://modular-avatar.nadena.dev/docs/reference/scale-adjuster

特定ボーンのスケールを子階層への影響を最小化しながら調整する。

### 何をするか

衣装がアバターと体型が合わない場合に、特定ボーンのサイズを調整して合わせる。

### パラメータ

| パラメータ | 説明 |
|---------|------|
| Scale X/Y/Z | 各軸のスケール値 |
| Adjust Child Positions | 子ボーンの位置を調整するか |

### 制限事項

- 全軸均一スケーリングには標準UnityのScaleツールを推奨
- 回転済みの子ボーンがある場合、結果が不完全になる可能性
- Move/Rotate/Scaleの複合ツールでは正常動作しない

---

## MA Bone Proxy

公式: https://modular-avatar.nadena.dev/docs/reference/bone-proxy

Prefab内のオブジェクトをアバターの既存ボーン配下に配置する。

### 何をするか

```
【問題】
  手の平に配置したいオブジェクトがある
  → Prefab内から手のボーンを参照したい

【解決】
  MA Bone Proxy を使って手のボーンを参照
  → ビルド時に手のボーン配下に自動配置
```

### パラメータ

| パラメータ | 型 | 説明 |
|-----------|-----|------|
| Target | Transform | 親にしたいアバターのボーン |
| Attachment Mode | Enum | 配置方法（下記参照） |

### Attachment Mode

| モード | 動作 |
|-------|------|
| As Child, Keep World Pose | 子として配置、ワールド位置/回転を維持 |
| As Child, Reset Local Pose | 子として配置、ローカル変換をゼロにリセット |

### 使用例

```
コンタクトPrefab
  [MA Bone Proxy]
    Target: アバター/Armature/Hips/Spine/.../Hand_R
    Mode: As Child, Keep World Pose
  ContactSender（右手に配置したいContact）
```

### 衣装 vs Bone Proxy

| 用途 | 推奨コンポーネント |
|------|-----------------|
| 衣装・ボーンが多いもの | MA Merge Armature |
| 単一オブジェクトを特定ボーンに配置 | MA Bone Proxy |

---

## MA Mesh Settings

公式: https://modular-avatar.nadena.dev/docs/reference/mesh-settings

アンカーオーバーライドとバウンズを階層的に設定する。

### 目的

アバター全体でライトプローブのアンカー（Anchor Override）とバウンズを統一する。

### Override Mode

| モード | 説明 |
|-------|------|
| Inherit | 親の設定を継承 |
| Set | このオブジェクト以下に設定を適用 |
| Don't Set | 親の設定を無視 |
| Set or Inherit | 親設定があれば使用、なければここで設定 |

### 注意

配布用Prefabには事前設定を入れない（購入者のアバターと競合する可能性）。

---

## MA Replace Object

公式: https://modular-avatar.nadena.dev/docs/reference/replace-object

アバターの既存GameObjectを別のGameObjectに完全置換する。

### 使用例

- PhysBone設定をPrefabの新しいものに置換
- ボディメッシュを別バージョンに差し替え

### パラメータ

| パラメータ | 説明 |
|---------|------|
| Original Object | 置換したいアバター側のGameObject |
| Replacement Object | 置換後のGameObject |

### 制限事項

- 1オブジェクトに1置換のみ
- コンポーネント参照はインデックスマッチング（ファジーマッチなし）
- アニメーションパスは自動更新される

---

## MA Remove Vertex Color

モデルの頂点色データを削除する。

### 用途

VRChatのモバイルシェーダーを使用時に頂点色が不要な色付けを引き起こす場合の対処。

### モード

| モード | 説明 |
|-------|------|
| Remove | 頂点色を削除 |
| Keep | 頂点色を保持 |

非破壊なのでオリジナルアセットは変更されない。
