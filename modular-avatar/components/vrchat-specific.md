# MA VRChat特化コンポーネント

最終更新: 2026-04-16

VRChat固有の機能に対応したModular Avatarコンポーネント群。

---

## MA Visible Head Accessory {#visible-head-accessory}

公式: https://modular-avatar.nadena.dev/docs/reference/visible-head-accessory

一人称視点（自分から見た視点）でHeadボーン以下のGameObjectを表示する。

### 問題と解決

```
問題: VRChatは一人称視点でHeadボーン以下を非表示にする（Head Chop）
     → 髪や頭部アクセサリーが一人称で見えない

解決: MA Visible Head Accessoryを追加すると一人称でも表示される
```

### 配置方法

```
アバター/Armature/Head/
  Hair_Root/
    [MA Visible Head Accessory] ← 一人称で見えるようにしたい親に追加
    Hair_Mesh/
```

### 制限事項

- **PhysBoneチェーンの直下に配置しない** → 親GameObjectに配置する
- 頭部全体（Head以下全て）に適用するのは避ける → 前髪が視界を塞ぐ
- 内部的にVRC Head Chopを使用し、重み付きプロキシボーンを生成

---

## MA World Fixed Object {#world-fixed}

公式: https://modular-avatar.nadena.dev/docs/reference/world-fixed-object

GameObjectをワールド座標に固定する（アバターが動いても動かない）。

### 使用例

```
アバター/
  FloatingObject/
    [MA World Fixed Object]
    FloatingSphere_Mesh/
    ↑ アバターが移動しても空中の一定位置に留まる
```

### 特徴

- 自動的にワールド原点固定用のGameObjectを生成
- 何個追加しても制約は1つのみ（パフォーマンス効率的）
- アニメーションでActive/Inactiveを切り替えると「設置・回収」が表現できる

---

## MA World Scale Object {#world-scale}

GameObjectのスケールをワールドスケールに固定する（アバタースケーリングを無視する）。

### 使いどころ

アバターのスケールを変更しても特定のオブジェクトだけ見た目のサイズを変えたくない場合。

### 注意

- Unity Editor上でビジュアルプレビューが表示されない

---

## MA Convert Constraints {#convert-constraints}

公式: https://modular-avatar.nadena.dev/docs/reference/convert-constraints

UnityのビルトインConstraintをVRChat Constraintに非破壊変換する。

### なぜ必要か

VRChatでは独自のConstraint（VRCPositionConstraint等）を使うことが推奨されている。  
UnityのConstraintはVRChatでも動作するが、パフォーマンスが劣る。

### 使用方法

```
アバタールートGameObject/
  [MA Convert Constraints] ← アバタールートに1つ追加するだけ
↓
ビルド時に全子オブジェクトのUnity ConstraintをVRC Constraintに自動変換
```

### 特徴

- **アバタールートに配置**（子オブジェクト全体に適用される）
- 非破壊なのでオリジナルのUnity Constraintは残る
- Modular Avatarインストール時、VRChat Auto Fixが自動追加することがある

---

## MA PhysBone Blocker {#physbone-blocker}

親オブジェクトのPhysBoneが特定の子オブジェクトに影響するのをブロックする。

### 問題と解決

```
問題: 尻尾にPhysBoneを設定 → そこに剛体的なアクセサリーを付けたい
     → アクセサリーもPhysBoneで揺れてしまう

解決: アクセサリーのGameObjectにMA PhysBone Blockerを追加
     → そのオブジェクト以下はPhysBoneの影響を受けない
```

### 配置方法

```
Tail_Root/
  [VRC PhysBone] → 尻尾全体を揺らす
  Tail_1/
    Tail_2/
      Tail_Accessory/
        [MA PhysBone Blocker] ← ここ以下は揺れない
        Accessory_Mesh/
```

### 推奨組み合わせ

MA Bone Proxy + MA PhysBone Blocker を組み合わせることで、  
PhysBoneチェーンに剛体的なアクセサリーをアタッチできる。

---

## MA Global Collider {#global-collider}

他のプレイヤーのPhysBoneと相互作用するコライダーを定義する。

### パラメータ

| パラメータ | 説明 |
|---------|------|
| Manual Remap | 特定の標準コライダーを手動で指定 |
| Low Priority | 低優先度コライダーとして設定 |

### 重要な制限

- **VRChatは最大6個のグローバルコライダー**しか認識しない
- 6個を超えると人差し指コライダーが上書きされる
- Head・Torso・Feetコライダーのみが他アバターに接触信号を送信

---

## MA Platform Filter {#platform-filter}

ビルド対象プラットフォームに応じてGameObjectを表示/非表示にする。

### 使用場面

- PC版とQuest版でポリゴン数の多いパーツを出し分ける
- Quest未対応のシェーダーを使うオブジェクトをPC限定にする

### パラメータ

| モード | 説明 |
|-------|------|
| Include | 指定プラットフォームでのみ表示 |
| Exclude | 指定プラットフォームで非表示 |

### 注意事項

- 同一GameObjectにIncludeとExcludeを混在させない

---

## MA Sync Parameter Sequence {#sync-param-seq}

PC版・Quest版・iOS版など複数プラットフォームでアップロードする場合に、  
パラメータの順序を統一してネットワーク同期を保証する。

### 使用タイミング

PC版とQuest版の両方をアップロードしてネットワーク同期させる場合は必須。

### 手順

1. PC版（主プラットフォーム）を先にアップロード
2. `MA Sync Parameter Sequence` をアバタールートに追加し、PC版として設定
3. Quest版をビルドする際にパラメータ順序が自動的に統一される

### 注意

- VRCFuryのParameter Compressorとの互換性問題の可能性あり
