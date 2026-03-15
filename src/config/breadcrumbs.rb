# 管理画面ホーム
crumb :admin do
  link "ダッシュボード", admin_path
end

# ユーザー一覧
crumb :admin_users do
  link "ユーザー", admin_users_path
  parent :admin
end

# ユーザー新規作成
crumb :new_admin_user do
  link "新規作成", new_admin_user_path
  parent :admin_users
end

# ユーザー編集
crumb :edit_admin_user do |user|
  link user.email, edit_admin_user_path(user)
  parent :admin_users
end

# ユーザーオーダー一覧
crumb :admin_user_user_orders do |user|
  link "オーダー一覧", admin_user_user_orders_path(user)
  parent :edit_admin_user, user
end

# 商品一覧
crumb :admin_products do
  link "商品", admin_products_path
  parent :admin
end

# 商品新規作成
crumb :new_admin_product do
  link "新規作成", new_admin_product_path
  parent :admin_products
end

# 商品編集
crumb :edit_admin_product do |product|
  link product.name, edit_admin_product_path(product)
  parent :admin_products
end
