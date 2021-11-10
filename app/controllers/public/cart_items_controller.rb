class Public::CartItemsController < ApplicationController

before_action :authenticate_customer!
  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
   flash[:notice] = "数量を変更しました"
   redirect_to cart_items_path
  end


  # カートの一部を消す
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:notice] = "一部商品を削除しました"
    redirect_to cart_items_path
  end

  # カートを全部消す
  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    flash[:notice] = "カートが空になりました"
    redirect_to cart_items_path
  end

  def create
     if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      params[:cart_item][:amount] = params[:cart_item][:amount].to_i + @cart_item.amount
      @cart_item.update(cart_item_params)
      redirect_to cart_items_path
     else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
     if @cart_item.save
        redirect_to cart_items_path
     else
        @item = @cart_item.item
        flash[:error] = "個数を入力してください。"
        redirect_to item_path(@item)
    end
     end
  end

  private
def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
    # cart_item_params[:item_id]のパラメータを取得できる
end
end
