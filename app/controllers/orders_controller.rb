class OrdersController < ApplicationController
  
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :destroy]
  
 	def index
		@orders = Order.all 
	end
	
	def new
		if @cart.product_items.empty? # this if statement prevents customer from creating a blank order
			redirect_to shop_url, notice: 'Your cart is empty'
			return
		end
		@order = Order.new
		@client_token = Braintree::ClientToken.generate
	end
	
	def create
		@order = Order.new(order_params)
		if @order.save	
			charge
			if @result.success?	
				@order.add_product_items_from_cart(@cart)
				Cart.destroy(session[:cart_id]) #if order is save, then destroy the cart from session	
				session[:cart_id] = nil
				OrderNotifier.received(@order).deliver 
				redirect_to root_url, notice: 'Thank you for your order!'
			else
			  flash[:error] = 'Check your cart'
			  redirect_to root_url, alert: @result.message
			  @order.destroy
			end
		else
		  @client_token = Braintree::ClientToken.generate
		  render :new
		end
	end
	
	def show
	end
	
	def destroy
		@order.destroy
		redirect_to root_url, notice: 'Order deleted'
	end
	
	private
	
	def set_order
		@order = Order.find(params[:id])
	end
	
	def order_params
		params.require(:order).permit(:name, :email, :address, :city, :country)
	end
	
	def charge
		@result = Braintree::Transaction.sale(
		  amount: @cart.total_price,
		  payment_method_nonce: params[:payment_method_nonce] )
	end
  	
end