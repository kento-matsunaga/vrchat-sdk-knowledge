# MA Parameters

公式: https://modular-avatar.nadena.dev/docs/reference/parameters

ギミックが使うAnimatorパラメータを定義し、名前衝突を自動解決するコンポーネント。

---

## 何をするコンポーネントか

複数のギミックPrefabが同じパラメータ名を使っていても、MAが自動でリネームして衝突を防ぐ。  
VRChatのExpression Parametersへの登録も自動で行う。

```
ギミックA → "Toggle" パラメータ使用
ギミックB → "Toggle" パラメータ使用（同名！）

→ MAが自動でリネーム:
   ギミックA → "GimmickA/Toggle"
   ギミックB → "GimmickB/Toggle"
→ 衝突なし
```

---

## パラメータ

| 設定項目 | 型 | 説明 |
|---------|-----|------|
| Name | String | パラメータ名（Animatorと一致させる） |
| Type | Enum | Bool / Int / Float / Animator Only / PB Prefix |
| Default Value | - | 初期値 |
| Saved | Bool | アバター切り替え後も値を保持するか |
| Synced | Bool | 他プレイヤーにネットワーク同期するか |
| Remapped Name | String | 別名でExpression Parametersに登録（省略可） |

### Type の選択肢

| 型 | 説明 |
|----|------|
| Bool | true/false。1bit |
| Int | 0〜255。8bit |
| Float | -1.0〜1.0（同期時）。8bit |
| **Animator Only** | Animatorには存在するがExpression Parametersには登録しない（内部処理用） |
| **PB Prefix** | PhysBoneの自動生成パラメータのプレフィックス（例: `Tail` → `Tail_IsGrabbed`等を自動管理） |

---

## Animator Only の使いどころ

Expression Parametersのビット数を消費せずにアニメーションを制御したい場合:
```
例: ローカルのみのエフェクト
  Type: Animator Only
  Synced: false
  → Expression Parametersにカウントされない
  → ビット数節約
```

---

## 名前の自動解決

MA Parametersで定義したパラメータ名は、同じPrefab内のAnimatorで使われている名前と自動的にマッチングされる。

```
MA Parameters: "WingsEnabled" を定義
↓
MA Merge Animator のFX Controllerで "WingsEnabled" を使用
↓
ビルド時: MAが両者を紐付けて整合性を保つ
```

複数のギミックに同じ名前がある場合は自動リネームで解決。

---

## 典型的な構成

```
ウィングPrefab
  [MA Parameters]
    WingsEnabled: Bool, Default=false, Saved=true, Synced=true
    WingsColor: Int, Default=0, Saved=true, Synced=true
  [MA Merge Animator]
    Wings_FX.controller
  [MA Menu Installer]
    Wings_Menu
  Wings_Object/
```

---

## ネスト対応

複数のMA Parametersを階層的に配置できる。  
子のParametersは自動的に親のスコープで管理される。
