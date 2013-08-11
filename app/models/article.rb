# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  image_url  :string(255)
#  user_id    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ActiveRecord::Base
  attr_accessible :content, :title, :image_url,  :user_id, :tag_list

  # validations
  validates :title, presence: true, length: { in: 8..60 }
  validates :content, presence: true, length: { in: 80..6000 }
  validates :image_url, presence: true, length: { minimum: 4 }
  validates :user_id, presence: true

  # scopes
  default_scope order: 'created_at DESC'
  scope :recent, order('created_at DESC').limit(10)
  scope :for_slider, order('created_at DESC').limit(3)

  # associations
  belongs_to :user
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  # callbacks
  before_save :prepare_data
  before_validation :check_if_image_url_is_valid

  def tag_list
    tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq # Create an array with the unique, normalized tags received
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by_name(name) } # Create the tags, if they don't exist
    self.tags = new_or_found_tags # and associate them with this article
  end


  private

  def check_if_image_url_is_valid
    return false unless image_url.end_with?(".jpg", ".jpeg", ".png")
  end

  def prepare_data
    self.title = title.strip
    self.content = content.strip
  end

end
