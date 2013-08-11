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
#  image_url  :string(255)
#

class Review < ActiveRecord::Base
  attr_accessible :category, :content, :product, :rating, :title, :image_url, :tag_list

  # validations
  validates :title, presence: true, length: { in: 8..100 }
  validates :content, presence: true, length: { in: 80..6000 }
  validates :rating, presence: true, inclusion: (1..5).to_a, numericality: { only_integer: true }
  validates :user_id, presence: true
  validates :product, presence: true, length: { in: 5..80 }
  validates :category, presence: true, inclusion: ['cpu', 'gpu', 'storage', 'motherboard', 'monitor']
  validates :image_url, presence: true, length: { in: 4..200 }

  # associations
  belongs_to :user
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  # scopes
  default_scope order: 'created_at DESC'
  scope :recent, order('created_at DESC').limit(6)


  # callbacks
  before_save :prepare_data, :create_tag_list_from_product
  before_validation :check_if_image_url_is_valid

  def tag_list
    tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def create_tag_list_from_product
    tag_names = product.split(" ").collect { |s| s.strip.downcase }.uniq # Create an array with the unique, splitted and normalized product name
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by_name(name) } # Create the tags, if they don't exist
    self.tags = new_or_found_tags # and associate them with this review
  end


  private

  def check_if_image_url_is_valid
    false unless image_url.end_with?(".jpg", ".jpeg", ".png")
  end

  def prepare_data
    self.title = title.strip
    self.content = content.strip
    self.product = product.strip.downcase
  end

end
