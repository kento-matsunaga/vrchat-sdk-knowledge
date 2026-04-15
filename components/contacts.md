# VRC Contact Sender / Receiver

公式: https://creators.vrchat.com/avatars/avatar-dynamics/contacts/

物体同士の接触・接近を検出してAnimatorパラメータやUdonイベントをトリガーするコンポーネント。

---

## コンポーネント概要

| コンポーネント | 役割 |
|--------------|------|
| VRCContactSender | 接触を「送信」する側（当たる側） |
| VRCContactReceiver | 接触を「受信」する側（反応する側） |

両者の Collision Tags が1つでも一致した時に接触として検出される。

---

## VRCContactSender パラメータ

| パラメータ | 型 | 上限 | 説明 |
|-----------|-----|------|------|
| Root Transform | Transform | - | コンポーネント配置位置（空=コンポーネントのGameObject） |
| Shape Type | Enum | - | Sphere / Capsule |
| Radius | Float | **3.0m** | コライダー半径 |
| Height | Float | **6.0m** | カプセルのY軸高さ（両端の球を含む） |
| Position | Vector3 | - | ルートからのオフセット位置 |
| Rotation | Quaternion | - | ルートからのオフセット回転 |
| Local Only | Bool | - | ローカルクライアントのみで処理（アバター専用） |
| Collision Tags | String[] | **16個** | 照合タグ（大文字小文字区別） |

---

## VRCContactReceiver パラメータ

| パラメータ | 型 | 上限 | 説明 |
|-----------|-----|------|------|
| Root Transform | Transform | - | 配置位置 |
| Shape Type | Enum | - | Sphere / Capsule |
| Radius | Float | **3.0m** | コライダー半径 |
| Height | Float | **6.0m** | カプセル高さ |
| Position | Vector3 | - | オフセット位置 |
| Rotation | Quaternion | - | オフセット回転 |
| Allow Self | Bool | - | 自分のSenderとの接触を検出（アバター専用） |
| Allow Others | Bool | - | 他プレイヤーのSenderとの接触を検出（アバター専用） |
| Local Only | Bool | - | ローカルのみ処理（最大256コンポーネントまで） |
| Collision Tags | String[] | **16個** | 照合タグ |
| Receiver Type | Enum | - | Constant / OnEnter / Proximity |
| Parameter | String | - | 書き込むAnimatorパラメータ名 |
| Value | Float | - | 接触時にパラメータに設定する値 |
| Min Velocity | Float | - | OnEnter時の最低検出速度 |

---

## Receiver Type 詳細

| 型 | 動作 | 戻り値の型 | 典型的な用途 |
|----|------|-----------|------------|
| **Constant** | 接触中は値を設定、離れたらリセット | Float または Bool | 継続的な接触状態の検出 |
| **OnEnter** | 接触した瞬間の1フレームだけ値設定、次フレームにリセット | 指定Value | 単発イベント（触れた瞬間に発火） |
| **Proximity** | 接触範囲内への接近度を返す（複数接触時は最小距離を採用） | Float 0.0〜1.0 | 距離に応じたアニメーション |

---

## Collision Tags のルール

- SenderとReceiverが**最低1つ共通のタグを持つ**必要がある
- **大文字小文字を区別する**（"Hand" と "hand" は別タグ）
- 最大16個まで設定可能
- 組み込みタグ（標準コライダー）: `Head`, `Torso`, `Hand`, `Foot`, `Finger`

---

## タグマッチングの例

```
Sender Tags: ["hand", "left"]
Receiver Tags: ["hand", "special"]
→ "hand" が共通 → 検出される

Sender Tags: ["grip"]
Receiver Tags: ["hand"]
→ 共通タグなし → 検出されない
```

---

## パフォーマンス注意事項

- **Local Only を有効にする**とパフォーマンスランクへの影響を回避できる
- Local Only時の上限: **256コンポーネント**
- 不要な Allow Others を無効にしておくと処理負荷を減らせる

---

## Udon コールバック（ワールド用）

```csharp
void OnContactEnter(ContactEnterInfo info)
void OnContactExit(ContactExitInfo info)
```

**ContactEnterInfo のプロパティ:**
| プロパティ | 型 | 説明 |
|-----------|-----|------|
| contactSender | ContactSenderProxy | 接触したSender |
| contactReceiver | ContactReceiverProxy | 受信したReceiver |
| enterVelocity | Vector3 | 接触時の相対速度 |
| contactPoint | Vector3 | ワールド座標での接触推定点 |
| matchingTags | string[] | 一致したタグ一覧 |

---

## 典型的なユースケース

### 頭への接触で反応
```
Sender: Shape=Sphere, Radius=0.1, Tags=["head_pat"]  → 相手の手に配置
Receiver: Shape=Sphere, Radius=0.15, Tags=["head_pat"], Type=Constant  → 頭に配置
Parameter: "PatReceived" (Bool)
Allow Others: true, Allow Self: false
```

### 足が地面に触れたときの検出
```
Sender: Shape=Sphere, Radius=0.05, Tags=["foot"]  → 足の裏に配置
Receiver: Shape=Capsule, Tags=["foot"], Type=OnEnter, Min Velocity=0.5  → 足先に配置
```

### 手との距離に応じてパラメータを変化
```
Receiver Type: Proximity
Parameter: "HandNearby" (Float)
→ 0.0=遠い, 1.0=接触
```
