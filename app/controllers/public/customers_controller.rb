class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
   if @customer.update(customer_params)
      flash[:notice] = '会員情報を変更しました。'
      redirect_to customers_path(current_customer)
   else
      render :edit
   end
  end

  def unsubscribe
     @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_active: false)# //is_deletedをtrueへ

    reset_session # ログアウトさせる
    flash[:notice] = "ありがとうございました。又のご利用を心よりお待ちしております。"
    redirect_to root_path
  end

   private

   def customer_params
     	params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
   end
end
