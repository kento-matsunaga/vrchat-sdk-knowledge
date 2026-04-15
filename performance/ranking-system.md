# Performance Ranking System

公式: https://creators.vrchat.com/avatars/avatar-performance-ranking-system/

アバターのパフォーマンス影響度を5段階でランク付けするシステム。

---

## ランク一覧

| ランク | 目安 |
|-------|------|
| **Excellent** | 非常に軽量。推奨 |
| **Good** | 良好。一般的な目標 |
| **Medium** | 許容範囲。問題なし |
| **Poor** | 改善が必要 |
| **Very Poor** | 深刻なパフォーマンス問題 |

---

## PC ランク基準値

| カテゴリ | Excellent | Good | Medium | Poor |
|---------|-----------|------|--------|------|
| **Triangles** | 32,000 | 70,000 | 70,000 | 70,000 |
| **Skinned Meshes** | 1 | 2 | 8 | 16 |
| **Basic Meshes** | 4 | 8 | 16 | 32 |
| **Material Slots** | 4 | 8 | 16 | 32 |
| **Dynamic Bone Components** | 0 | 4 | 16 | 32 |
| **Dynamic Bone Colliders** | 0 | 8 | 16 | 32 |
| **PhysBone Components** | 4 | 8 | 16 | 32 |
| **PhysBone Affected Transforms** | 16 | 64 | 128 | 256 |
| **PhysBone Colliders** | 4 | 8 | 16 | 32 |
| **PhysBone Collision Check Count** | 32 | 128 | 256 | 512 |
| **Avatar Dynamics (Contact)** | 2 | 8 | 16 | 32 |
| **Animators** | 1 | 4 | 16 | 32 |
| **Bones** | 75 | 150 | 256 | 400 |
| **Lights** | 0 | 0 | 1 | 2 |
| **Particle Systems** | 0 | 4 | 8 | 16 |
| **Total Particles Active** | 0 | 300 | 1,000 | 2,500 |
| **Mesh Particle Active Polys** | 0 | 1,000 | 2,000 | 5,000 |
| **Particle Trails** | false | false | false | true |
| **Particle Collision** | false | false | false | true |
| **Audio Sources** | 1 | 4 | 8 | 8 |
| **Constraint Sources** | 0 | 16 | 32 | 64 |
| **Constraint Count** | 0 | 16 | 32 | 64 |

**全カテゴリで最も悪いランクがアバター全体のランクになる**

---

## Mobile（Quest/Android）ランク基準値

Mobileはより厳しい制限があり、一部は**ハードリミット（超えると非表示強制）**。

| カテゴリ | Excellent | Good | Medium | Poor |
|---------|-----------|------|--------|------|
| **Triangles** | 7,500 | 10,000 | 15,000 | 20,000 |
| **Skinned Meshes** | 1 | 1 | 2 | 2 |
| **Material Slots** | 1 | 2 | 4 | 4 |
| **Bones** | 75 | 90 | 150 | 150 |
| **PhysBone Components** | 0 | 4 | 6 | 8 |
| **PhysBone Affected Transforms** | 0 | 16 | 32 | 64 |

---

## デフォルト表示ポリシー

| プラットフォーム | デフォルト表示閾値 |
|--------------|----------------|
| PC | Very Poor まで表示（全て表示） |
| Mobile | Medium まで表示 |

ユーザーは個別に "Show Avatar" で強制表示、または設定で閾値変更が可能。

---

## パフォーマンス改善の優先順位

### 高効果な改善
1. **Skinnedメッシュの統合** → Skinned Meshesを1〜2に削減
2. **ポリゴン削減** → 不要なポリゴンをデシメーション
3. **マテリアルのアトラス化** → Material Slotsを削減
4. **PhysBoneの削減・最適化** → 影響Transformsを減らす

### よくある問題
| 問題 | 対策 |
|------|------|
| Skinned Meshesが多い | FBXをマージ / LOD設定 |
| PhysBoneが多い | 揺れが目立たない箇所は削除 |
| ポリゴンが多い | 裏面メッシュの削除、不可視部分の削除 |
| Material Slotsが多い | Texture Atlasで統合 |

---

## ランクに影響しない要素

- Constraintは `Constraint Count / Constraint Depth` でランク評価される
- Contact Sender/Receiver は `Avatar Dynamics` カテゴリに含まれる
- **Local Only設定のContactはランク計算に含まれない**（パフォーマンスランク低下を回避できる）
