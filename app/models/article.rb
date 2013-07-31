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
  attr_accessible :content, :title, :image_url,  :user_id

  # validations
  validates :title, presence: true, length: { in: 8..60 }
  validates :content, presence: true, length: { minimum: 80 }
  validates :image_url, presence: true, length: { minimum: 4 }
  validates :user_id, presence: true

  # scopes
  default_scope order: 'created_at DESC'
  scope :recent, order('created_at DESC').limit(10)
  scope :for_slider, order('created_at DESC').limit(3)

  # associations
  belongs_to :user
  has_many :comments

  # callbacks
  before_save :prepare_data


  private

  def prepare_data
    self.title = self.title.strip.downcase
    self.content = self.content.strip.downcase
  end

end
