# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  review_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :content, :review_id

	# validations
  validates :user_id, presence: true
  validates :review_id, presence:  true
  validates :content, presence: true, length: { minimum: 6 }

  # associations
  belongs_to :user
  belongs_to :review

	#scopes
  default_scope order: 'created_at DESC'

end
