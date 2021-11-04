class Public::CartItemsController < ApplicationController

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
    flash[:notice] = "商品の削除に成功しました。"
    redirect_to cart_items_path
  end

  # カートを全部消す
  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path


  end

  private
def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
    # cart_item_params[:item_id]のパラメータを取得できる
end
end
