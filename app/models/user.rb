class User < ApplicationRecord
	#has_many :scenarios, :zaznam_miestnosts, :registracia_u_dodavatelas
	before_save { email.downcase! }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, uniqueness:  { case_sensitive: false }, 
					  presence: true, 
					  length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX }
	validates :address, uniqueness: true, 
						presence: true,
						length: { maximum: 50}
	has_secure_password
	validates :password, presence: true,
						 length: { minimum: 8}

	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  	  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end
end
