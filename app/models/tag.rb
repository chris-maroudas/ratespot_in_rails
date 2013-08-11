# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  attr_accessible :name

  # validations
  validates :name, presence: true, length: { maximum: 60 }

  # associations
  has_many :taggings
  has_many :articles, through: :taggings
  has_many :reviews, through: :taggings

  # scopes
  default_scope order: 'created_at DESC'
  scope :recent, order('created_at DESC').limit(50)


  def self.search(term)
    search_condition = "%" + term + "%"
    find(:all, :conditions => ['name LIKE ?', search_condition])
  end

end
