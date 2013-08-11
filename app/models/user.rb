# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  article_author  :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :article_author

  has_secure_password

  # callbacks
  before_validation :prepare_email, :check_if_article_author
  before_save :create_remember_token

  after_save :send_register_email
  after_update :send_update_email

  # globals
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  ARTICLE_AUTHORS = %w[chris_maroudas@gmail.com grigoria_pont@gmail.com]   # users that are allowed to post articles

  # validations
  validates :name, presence: true, length: { maximum: 40 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  # associations
  has_many :reviews, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy


  private

  def check_if_article_author
      self.article_author = true if ARTICLE_AUTHORS.include?(email)
  end

  def prepare_email
    self.email = email.strip.downcase if email
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
