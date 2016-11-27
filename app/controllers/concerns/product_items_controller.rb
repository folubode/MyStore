class ProductItemsController < ApplicationController

	include CurrentCart
	before_action :set_cart, only: [:create]
	before_action :set_product_item, only: [:show, :destroy]

	# add product or increment product items in the cart
	def create
		product = Product.find(params[:product_id])
		@product_item = @cart.add_product(product.id)
		if @product_item.save
			redirect_to shop_url, notice: 'Product Added to Cart'
		else
			render :new
		end
	end

	private
	def set_product_item
		@product_item = ProudctItem.find(prarams[:id])
	end

	def product_item_params
		params.require(:product_item).permit(:product_id)
	end

end