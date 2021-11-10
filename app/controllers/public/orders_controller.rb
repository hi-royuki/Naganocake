class Public::OrdersController < ApplicationController
 before_action :authenticate_customer!
 before_action  :check_cart, only: [:new]



  def new
    @addresses = Address.all
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if params[:order][:address_id] == "1"
       @order.postal_code = current_customer.postal_code
       @order.address = current_customer.address
       @order.name = current_customer.first_name + current_customer.last_name


    elsif params[:order][:address_id] == "2"
      @order.postal_code = Address.find(params[:order][:address_select_id]).postal_code
      @order.address = Address.find(params[:order][:address_select_id]).address
      @order.name = Address.find(params[:order][:address_select_id]).name
    end

    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price } # 商品合計cart_itemsコントローラと一緒

  end

  def complete

  end

  def create
    @cart_items = current_customer.cart_items
    @order = current_customer.orders.new(order_params)

    @order.save

    @cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item_id
      order_detail.tax_price = cart_item.subtotal.floor
      order_detail.amount = cart_item.amount
      order_detail.order_id = @order.id
      order_detail.save
    end


     @cart_items.destroy_all
     redirect_to  complete_orders_path

  end

  def index
    @orders = current_customer.orders
  end

  def show
     @order = Order.find(params[:id])
     @order_details = @order.order_details
  end

  private
def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :customer_id, :shipping_cost, :total_payment)
end

 def check_cart
    if current_customer.cart_items.blank?
      redirect_to cart_items_path
    end
 end
end
