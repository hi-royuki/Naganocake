class Public::AddressesController < ApplicationController

def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @addresses = Address.all
    if @address.save
      flash[:success] = "You have created books successfully. "
     redirect_to addresses_path
    else
     render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path(@address.id)
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

    private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end


end