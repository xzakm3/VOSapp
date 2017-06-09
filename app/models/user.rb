class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token, :reset_token
	has_many :scenarios
	has_many :entry_rooms
	has_many :registration_in_suppliers
	before_create :create_activation_digest
	before_save   :downcase_email
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
						 length: { minimum: 8},
						 allow_nil: true

	def self.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  	  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end

  	def self.new_token
    	SecureRandom.urlsafe_base64
  	end

  	def remember
  		self.remember_token = User.new_token
  		update_attribute(:remember_digest, User.digest(remember_token))
  	end

  	def authenticated?(attribute, token)
  		digest = self.send("#{attribute}_digest")
		#debugger
  		return false if digest.nil?
  		BCrypt::Password.new(digest).is_password?(token)
  	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def activate
		update_attribute(:activated, true)
	end

	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	def create_reset_digest
		self.reset_token = User.new_token
		update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
		#UPDATE users SET reset_digest = ?, reset_sent_at = ? WHERE user_id = ?, (User.digest(reset_token, Time.zone.now, self.id);
	end

	def password_reset_expired?
		self.reset_sent_at < 2.hours.ago
	end

	private

		def create_activation_digest
			self.activation_token = User.new_token
			self.activation_digest = User.digest(activation_token)
		end

		def downcase_email
			self.email = email.downcase
		end

end