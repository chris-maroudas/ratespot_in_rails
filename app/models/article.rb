# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ActiveRecord::Base
  attr_accessible :content, :title, :user_id

	#validations
  validates :title, presence: true, length: { in: 8..60 }
  validates :content, presence: true, length: { minimum: 80 }
  validates :user_id, presence: true

  # scopes
	default_scope order: 'created_at DESC'
  scope :recent, order('created_at DESC').limit(10)

  #associations
  belongs_to :user

end
