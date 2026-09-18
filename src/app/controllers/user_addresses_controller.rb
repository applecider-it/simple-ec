class UserAddressesController < ApplicationController
  before_action :set_user_address, only: %i[ show edit update destroy ]

  # GET /user_addresses or /user_addresses.json
  def index
    @user_addresses = UserAddress.all
  end

  # GET /user_addresses/1 or /user_addresses/1.json
  def show
  end

  # GET /user_addresses/new
  def new
    @user_address = UserAddress.new
  end

  # GET /user_addresses/1/edit
  def edit
  end

  # POST /user_addresses or /user_addresses.json
  def create
    @user_address = UserAddress.new(user_address_params)

    respond_to do |format|
      if @user_address.save
        format.html { redirect_to @user_address, notice: "User address was successfully created." }
        format.json { render :show, status: :created, location: @user_address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_addresses/1 or /user_addresses/1.json
  def update
    respond_to do |format|
      if @user_address.update(user_address_params)
        format.html { redirect_to @user_address, notice: "User address was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user_address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_addresses/1 or /user_addresses/1.json
  def destroy
    @user_address.destroy!

    respond_to do |format|
      format.html { redirect_to user_addresses_path, notice: "User address was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_address
      @user_address = UserAddress.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_address_params
      params.expect(user_address: [ :user_id, :postal_code, :prefecture, :city, :address_line1, :address_line2, :phone_number ])
    end
end
