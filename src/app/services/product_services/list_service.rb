# 商品一覧関連管理
class ProductServices::ListService
  # 一覧取得
  def get_list(page, keyword)
    Product
      .includes([:image_attachment])
      .order(id: :desc)
      .search_by_keyword(keyword)
      .kept
      .page(page)
      .per(10)
  end
end
