# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  review_id  :integer
#  article_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :content, :review_id, :article_id

  # callbacks
  before_validation :review_or_article_id_present?

  # validations
  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 6 }

  # associations
  belongs_to :user
  belongs_to :review
  belongs_to :article

  #scopes
  default_scope order: 'created_at DESC'

  private

  def review_or_article_id_present?
    false if review_id.nil? && article_id.nil?
  end

  def prepare_content
    self.content = content.strip.downcase
  end

end
