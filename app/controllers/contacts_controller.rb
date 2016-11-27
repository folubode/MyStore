class ContactsController < ApplicationController

include CurrentCart
before_action :set_cart, only: [:new, :create]

def new
	@contact = Contact.new
end

def create
	@contact = Contact.new(contact_params)
	if @contact.save
		redirect_to root_url, notice: 'Thank you for your message'
	else
		flash[:alert] = 'Oops! Looks like you did not enter all info required'
		render :new #redirect_to new_contact_path
	end
end

private

	def contact_params
		params.require(:contact).permit(:name, :email, :message)
	end

end