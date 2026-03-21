# ユーザーオーダー詳細モデル

## DB

| 項目名 | 内容 | 型 | 詳細 |
|--------|--------|--------|--------|
| user_order_id | ユーザーオーダーID | references | [ユーザーオーダー](./user_order.md) |
| product_id | 商品ID | references | [商品](./product.md) |
| amount | 数量 | integer |  |
| price | 価格 | integer |  |

