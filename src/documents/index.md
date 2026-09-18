
# シンプルなEC

- [設計](./design.md)

## 実装内容

- [カート](./features/cart.md)

## モデル

`id`, `created_at`, `updated_at`, `discarded_at`の説明は省略しています。

- [ユーザー](./models/user.md)
  - [ユーザーオーダー](./models/user_order.md)
    - [ユーザーオーダー詳細](./models/user_order_detail.md)
  - [ユーザー住所](./models/user_address.md)
- [管理者](./models/admin_user.md)
- [商品](./models/product.md)

## 追加した要素

- devise
- vite
- tailwind
- discard
