# frozen_string_literal: true

class Customers::SessionsController < Devise::SessionsController
  before_action :reject_customer, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end


  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected
  def reject_customer
    @customer = Customer.find_by(email: params[:customer][:email].downcase)
    if @customer
     if (@customer.valid_password?(params[:customer][:password]) && !@customer.is_active)
      flash[:error] = "退会済みです。新たにアカウントを作成してください。"
      redirect_to customers_sign_up_path
     else
      flash[:error] = "必須項目を入力してください。"
     end
    end
  end
end


