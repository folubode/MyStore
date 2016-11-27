class Contact < ActiveRecord::Base

	validates :name, :email, presence: true
	validates :message, presence: true, length: {maximum: 300}
	

end
