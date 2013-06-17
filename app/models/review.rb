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
  attr_accessible :category, :content, :product, :rating, :title

  validates :title, presence: true, length: { in: 8..60 }
  validates :content, presence: true, length: { minimum: 80 }
	validates :rating, presence: true, inclusion: (1..5).to_a, numericality: { only_integer: true }
	validates :user_id, presence: true
	validates :product, presence: true, length: { in: 5..80 }
  validates :category, presence: true, inclusion: ['cpu', 'gpu', 'storage', 'motherboard', 'monitor']



	belongs_to :user

  default_scope order: 'created_at DESC'


  before_save :prepare_data


	def prepare_data
		self.title = self.title.strip.downcase
		self.content = self.content.strip.downcase
		self.product = self.product.strip.downcase
	end
end
