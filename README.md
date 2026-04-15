# VRChat SDK アバター ナレッジベース

最終更新: 2026-04-16  
対象SDK: VRChat Avatars 3.0 + Modular Avatar  
対象Unity: 2022.3以降

公式ドキュメント: https://creators.vrchat.com/avatars/  
MA公式: https://modular-avatar.nadena.dev/

---

## まず読むべき：全体像

**→ [VRChat SDK × Modular Avatar 全体構造マップ](vrchat-sdk-vs-ma.md)**  
SDKとMAの立ち位置・使い分け・ビルドパイプラインを図解で解説。

---

## クイックリファレンス

### 「〜したい」ユースケース

| やりたいこと | 使うもの | ファイル |
|-------------|---------|---------|
| 髪・尻尾・衣装を揺らしたい | VRC PhysBone | [howto/hair-physics.md](howto/hair-physics.md) |
| 表情を作りたい | FX Layer Animator | [howto/expressions.md](howto/expressions.md) |
| アイテムのON/OFFを作りたい | FX Layer / MA Object Toggle | [howto/toggle-items.md](howto/toggle-items.md) |
| つかめるオブジェクトを作りたい | VRC PhysBone + Contact | [howto/grab-interaction.md](howto/grab-interaction.md) |
| **衣装をアバターに着せたい** | **MA Merge Armature** | [modular-avatar/howto/add-outfit.md](modular-avatar/howto/add-outfit.md) |
| **ギミックを非破壊で追加したい** | **MA Merge Animator** | [modular-avatar/howto/add-gimmick.md](modular-avatar/howto/add-gimmick.md) |

---

## Modular Avatar → modular-avatar/

| トピック | ファイル |
|---------|---------|
| 概要・コンポーネント一覧・NDMF | [modular-avatar/overview.md](modular-avatar/overview.md) |
| **MA Merge Armature**（衣装統合の基本） | [modular-avatar/components/merge-armature.md](modular-avatar/components/merge-armature.md) |
| **MA Merge Animator**（Animator統合） | [modular-avatar/components/merge-animator.md](modular-avatar/components/merge-animator.md) |
| **MA Parameters**（パラメータ・競合解決） | [modular-avatar/components/parameters.md](modular-avatar/components/parameters.md) |
| **MA Menu Installer / Item**（メニュー自動追加） | [modular-avatar/components/menu-installer.md](modular-avatar/components/menu-installer.md) |
| MA Reactive Components（Toggle/Shape/Material） | [modular-avatar/components/reactive.md](modular-avatar/components/reactive.md) |
| MA Blendshape Sync | [modular-avatar/components/blendshape-sync.md](modular-avatar/components/blendshape-sync.md) |
| MA Scale Adjuster / Bone Proxy / Misc | [modular-avatar/components/scale-adjuster.md](modular-avatar/components/scale-adjuster.md) |
| MA VRChat特化（Head Accessory / Convert Constraints等） | [modular-avatar/components/vrchat-specific.md](modular-avatar/components/vrchat-specific.md) |

---

## VRChat SDK コンポーネント一覧 → components/

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

## コミュニティTips → community/

| トピック | ファイル |
|---------|---------|
| PhysBone チューニングTips | [community/tips-physbone.md](community/tips-physbone.md) |
| Animator / FX Layer Tips | [community/tips-animator-fx.md](community/tips-animator-fx.md) |
| 便利ツール・アセット情報 | [community/tips-tools.md](community/tips-tools.md) |

週次（毎週日曜9:00 JST）で自動更新。

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
