# 商品管理コントローラー
class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show add ]

  # 一覧画面
  def index
    list_service = ProductServices::ListService.new

    page = params[:page]
    @keyword = params[:keyword]

    @products = list_service.get_list(page, @keyword)
  end

  # 詳細画面
  def show
  end

  # カートに追加
  def add
    @add_cart_form.assign_attributes(add_cart_params)
    
    if @add_cart_form.valid?
      # エラーがないとき

      cart_service = CartServices::CartService.new(session)

      cart_service.add(@product, @add_cart_form)

      redirect_to product_path(@product), notice: "カートに追加しました"
    else
      # エラーがあるとき
      
      render :show, status: :unprocessable_entity
    end
  end

  # カレントデータの取得
  private def set_product
    edit_service = ProductServices::EditService.new
    @info = edit_service.find_product(params.expect(:id))
    @product = @info[:product]

    @add_cart_form = AddCartForm.new
  end

  private def add_cart_params
    params.expect(add_cart_form: [ :amount ])
  end
end
