# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  article_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  review_id  :integer
#

require 'spec_helper'

describe Tagging do
  pending "add some examples to (or delete) #{__FILE__}"
end
