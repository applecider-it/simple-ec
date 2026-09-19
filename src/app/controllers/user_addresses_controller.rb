class UserAddressesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_user_address, only: %i[ edit update destroy ]

  # 一覧画面
  def index
    @user_addresses = current_user.user_addresses.for_user
  end

  # 新規作成画面
  def new
    @user_address = UserAddress.new
  end

  # 更新画面
  def edit
  end

  # 新規作成処理
  def create
    @user_address = UserAddress.new(user_address_params)

    @user_address.user = current_user

    if @user_address.save
      redirect_to edit_user_address_path(@user_address), notice: "作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 更新処理
  def update
    if @user_address.update(user_address_params)
      redirect_to edit_user_address_path(@user_address), notice: "更新しました。", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 削除処理
  def destroy
    @user_address.discard

    redirect_to user_addresses_path, notice: "削除しました。", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_address
      @user_address = UserAddress.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_address_params
      params.expect(user_address: [ :postal_code, :prefecture, :city, :address_line1, :address_line2, :phone_number ])
    end
end
