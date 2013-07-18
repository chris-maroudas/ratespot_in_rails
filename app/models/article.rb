class Article < ActiveRecord::Base
  attr_accessible :content, :title, :user_id


	belongs_to :user


  validates :title, presence: true, length: { in: 8..60 }
  validates :content, presence: true, length: { minimum: 80 }
  validates :user_id, presence: true

	default_scope order: 'created_at DESC'

end
