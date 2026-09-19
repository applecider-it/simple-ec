# ユーザーオーダーモデル

## DB

論理削除付き

| 項目名 | 内容 | 型 | 詳細 |
|--------|--------|--------|--------|
| user_id | ユーザーID | references | [ユーザー](./user.md) |
| order_status | オーダーステータス | integer |  |
| user_address_id | ユーザーID | references | [ユーザー住所](./user_address.md) |
| payment_method | 支払い方法 | integer |  |

