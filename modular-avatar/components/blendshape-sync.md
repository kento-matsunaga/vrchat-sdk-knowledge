# MA Blendshape Sync

公式: https://modular-avatar.nadena.dev/docs/reference/blendshape-sync

複数のSkinnedMeshRenderer間でBlendShapeの値を同期する。

---

## 何をするコンポーネントか

アバター本体と衣装で同じBlendShapeを使いたい時に、  
本体側のBlendShapeを動かすと衣装側も連動して動くようにする。

```
例: アバターの体型調整BlendShape "スリム" を動かす
    → 衣装にも同じ補正BlendShapeが必要
    → MA Blendshape Syncで連動設定
```

---

## パラメータ

| パラメータ | 説明 |
|---------|------|
| Source Renderer | 元になるSkinnedMeshRenderer |
| Target Renderer | 同期先のSkinnedMeshRenderer |
| Source Blendshape | コピー元のBlendShape名 |
| Target Blendshape | コピー先のBlendShape名（省略時はSource名と同じ） |

---

## 制限事項（重要）

| 制限 | 内容 |
|------|------|
| 値は完全一致 | スケール変換・カーブ変換は不可 |
| チェーン不可 | A→B→C の連鎖同期はできない。A→B と A→C のみ |
| Blink非対応 | VRChat組み込みのeyelookは同期できない |
| Viseme非対応 | VRChat組み込みのvisemeは同期できない |
| ランタイム同期 | AnimatorがコントロールするBlendShapeのみ（Avatarの直接制御は除く） |

---

## 典型的な使用例

### 衣装の体型補正BlendShapeを本体と連動

```
衣装Prefab
  [MA Blendshape Sync]
    Source: アバター/Body（本体SkinnedMeshRenderer）
    Target: 衣装/Dress_Mesh
    Source Blendshape: "体型_スリム"
    Target Blendshape: "体型_スリム_補正"
```

これで本体の "体型_スリム" を動かすと衣装も追従する。

---

## MA Shape Changer との使い分け

| | MA Blendshape Sync | MA Shape Changer |
|-|-------------------|-----------------|
| 用途 | 値の連動（常時同期） | 条件トリガーで値を設定 |
| タイミング | リアルタイム同期 | Menu Item ON/OFFのタイミング |
| 向いている用途 | 体型補正の連動 | 衣装着用時のめり込み防止 |
