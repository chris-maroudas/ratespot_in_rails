# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

	has_secure_password

  before_validation :prepare_email
  before_save :create_remember_token


  after_update :send_update_email
  after_save :send_register_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, presence: true, length: { maximum: 40 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }
	validates :password_confirmation, presence: true

  # If a user deletes himself, destroy all the associated content
  has_many :reviews, dependent: :destroy
	has_many :articles, dependent: :destroy


  private

	def prepare_email
		self.email = self.email.strip.downcase if self.email
	end

  def create_remember_token
	  self.remember_token = SecureRandom.urlsafe_base64
  end

  # Mailing

	def send_update_email
		UserMailer.updated_user(self).deliver
	end

	def send_register_email
		UserMailer.registered_user(self).deliver
	end

end
