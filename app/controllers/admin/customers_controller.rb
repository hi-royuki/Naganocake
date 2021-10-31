class Admin::CustomersController < ApplicationController
  
 before_action :authenticate_admin!
# 管理者ページの顧客のコントローラ

  def index
    @customers = Customer.all
  end

  def show
    # 顧客の詳細
    @customer = Customer.find(params[:id])
  end

  def edit
    # 顧客の会員情報編集
    @customer = Customer.find(params[:id])
  end

  def update
  end

  private

  private

  def customer_params
  	params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana, :postal_code,:address, :phone_number, :is_active)
  end


end
