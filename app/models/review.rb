# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  rating     :integer
#  user_id    :integer
#  product    :string(255)
#  category   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Review < ActiveRecord::Base
  attr_accessible :category, :content, :product, :rating, :title, :image_url

  # validations
  validates :title, presence: true, length: { in: 8..100 }
  validates :content, presence: true, length: { minimum: 80 }
  validates :rating, presence: true, inclusion: (1..5).to_a, numericality: { only_integer: true }
  validates :user_id, presence: true
  validates :product, presence: true, length: { in: 5..80 }
  validates :category, presence: true, inclusion: ['cpu', 'gpu', 'storage', 'motherboard', 'monitor']


  # associations
  belongs_to :user
  has_many :comments

  # scopes
  default_scope order: 'created_at DESC'
  scope :recent, order('created_at DESC').limit(6)


  # callbacks
  before_save :prepare_data


  private

  def prepare_data
    self.title = self.title.strip.downcase
    self.content = self.content.strip
    self.product = self.product.strip.downcase
  end

  def self.search(term)
    search_condition = "%" + term + "%"
    find(:all, :conditions => ['title LIKE ? OR product LIKE?', search_condition, search_condition])
  end

end