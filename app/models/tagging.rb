# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  article_id :integer
#  review_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tagging < ActiveRecord::Base
  attr_accessible :article_id,:review_id, :tag_id

  # associations
  belongs_to :article
  belongs_to :tag
  belongs_to :review

end
