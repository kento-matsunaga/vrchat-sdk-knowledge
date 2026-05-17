# MA Floor Adjuster

最終更新: 2026-05-17  
公式: https://modular-avatar.nadena.dev/docs/reference/floor-adjuster  
追加バージョン: v1.17.0

アバターの垂直位置を自動調整し、靴の底がワールドの床と一致するようにするコンポーネント。

---

## 機能

靴をアバターに装着した際、靴底が床に埋まる問題を自動的に解消する。  
アバター全体の垂直オフセットをビルド時に計算して適用する。

---

## 使い方

1. 新しいGameObjectを作成（例: `FloorAdjuster`）
2. `MA Floor Adjuster` コンポーネントを追加
3. GameObjectを靴底の垂直位置に合わせて配置する

**ヒント**: シーンビューを側面図（Side View）または等角投影（Isometric）に切り替えると位置合わせがしやすい。

---

## 注意事項

| 注意点 | 詳細 |
|-------|------|
| 複数配置は非対応 | 同一アバターに複数のFloor Adjusterがある場合、調整は行われない |
| 動的な身長変化は非対応 | VRChatでは動的な身長調整ができないため、複数の靴で床高さが異なる場合は対応不可 |
| 実行順序 | TexTransToolなど他のNDMFプラグインの後に実行される（v1.17.1で修正） |

---

## 出典

- https://modular-avatar.nadena.dev/docs/reference/floor-adjuster
- https://modular-avatar.nadena.dev/docs/changelog
