# ユーザー住所モデル

## DB

論理削除付き

| 項目名 | 内容 | 型 | 詳細 |
|--------|--------|--------|--------|
| user_id | ユーザーID | references | [ユーザー](./user.md) |
| postal_code | 郵便番号 | string |  |
| prefecture | 都道府県 | integer |  |
| city | 市区町村 | string |  |
| address_line1 | 住所１ | string |  |
| address_line2 | 住所２ | string |  |
| phone_number | 電話番号 | string |  |

