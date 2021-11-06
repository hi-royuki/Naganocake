class Public::OrdersController < ApplicationController



  def new
    @addresses = Address.all
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)

    if params[:order][:address_id] == "1"
       @order.postal_code = current_customer.postal_code
       @order.address = current_customer.address
       @order.name = current_customer.last_name + current_customer.first_name


    elsif params[:order][:address_id] == "2"
      @order.postal_code = Address.find(params[:order][:address_select_id]).postal_code
      @order.address = Address.find(params[:order][:address_select_id]).address
      @order.name = Address.find(params[:order][:address_select_id]).name
    end

    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }# 商品合計cart_itemsコントローラと一緒

  end

  def complete

  end

  def create
    @cart_items = current_customer.cart_items
    @order = current_customer.orders.new(order_params)
    @cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item_id
      order_detail.tax_price = cart_item.subtotal.floor
      order_detail.amount = cart_item.amount
      order_detail.order_id = @order.id
      order_detail.save
    end
     redirect_to  complete_orders_path
     @cart_items.destroy_all
  end

  def index
    @orders = current_customer.orders
  end

  def show
  end

  private
def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :customer_id)
end
end
