# VRChat SDK アバター ナレッジベース

最終更新: 2026-04-16  
対象SDK: VRChat Avatars 3.0  
対象Unity: 2022.3以降

公式ドキュメント: https://creators.vrchat.com/avatars/

---

## クイックリファレンス

### 「〜したい」ユースケース → howto/

| やりたいこと | ファイル |
|-------------|---------|
| 髪・尻尾・衣装を揺らしたい | [howto/hair-physics.md](howto/hair-physics.md) |
| 表情を作りたい | [howto/expressions.md](howto/expressions.md) |
| アイテムのON/OFFを作りたい | [howto/toggle-items.md](howto/toggle-items.md) |
| つかめるオブジェクトを作りたい | [howto/grab-interaction.md](howto/grab-interaction.md) |

---

## コンポーネント一覧 → components/

| コンポーネント | 概要 | ファイル |
|--------------|------|---------|
| VRC Avatar Descriptor | アバタールートに必須。全設定の起点 | [components/avatar-descriptor.md](components/avatar-descriptor.md) |
| VRC Phys Bone | ボーンに物理シミュレーション・掴み機能を追加 | [components/physbones.md](components/physbones.md) |
| VRC Contact Sender/Receiver | 衝突・接触検出。アニメーションをトリガー | [components/contacts.md](components/contacts.md) |
| VRC *Constraint (6種) | ボーンの位置・回転・スケールを別オブジェクトに追従 | [components/constraints.md](components/constraints.md) |
| VRC Head Chop | 一人称視点でのボーン表示/非表示制御 | [components/head-chop.md](components/head-chop.md) |

---

## アニメーション → animations/

| トピック | ファイル |
|---------|---------|
| Playable Layers (5層構造) | [animations/playable-layers.md](animations/playable-layers.md) |
| Animator Parameters (ビルトイン全一覧) | [animations/animator-parameters.md](animations/animator-parameters.md) |
| State Behaviors (7種) | [animations/state-behaviors.md](animations/state-behaviors.md) |
| Write Defaults 注意事項 | [animations/write-defaults.md](animations/write-defaults.md) |

---

## メニュー → menus/

| トピック | ファイル |
|---------|---------|
| Expression Menu & Controls (6種) | [menus/expression-menu.md](menus/expression-menu.md) |
| Expression Parameters (型・制限) | [menus/expression-parameters.md](menus/expression-parameters.md) |

---

## パフォーマンス → performance/

| トピック | ファイル |
|---------|---------|
| Performance Ranking System (PC/Mobile) | [performance/ranking-system.md](performance/ranking-system.md) |

---

## 重要な禁止事項（よくある間違い）

1. **PhysBone と Constraint を同一オブジェクトに配置しない** → 親オブジェクトに配置する
2. **Humanoidボーン（Hip, Spine等）をPhysBoneのRootに設定しない**
3. **PhysBoneのプロパティをアニメーションで変更しない**
4. **Write Defaults をアバター内で混在させない** → 全ON または全OFFで統一
5. **単一ボーンのPhysBoneにはEndpoint Positionを必ず設定する**

---

## パラメータ型・範囲 早見表

| 型 | 同期時の範囲 | ローカル時の範囲 |
|----|------------|----------------|
| Int | 0 〜 255 | 制限なし |
| Float | -1.0 〜 1.0 | 制限なし |
| Bool | true / false | true / false |
