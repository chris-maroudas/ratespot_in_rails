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
#  article_id :integer
#

require 'spec_helper'

describe Comment do

  before { @comment = Comment.new(content: 'abc' *10, review_id: 1, article_id: 1) }
  before { @comment.user_id = 1 }
  subject { @comment }

  it { should respond_to :content }
  it { should respond_to :user }
  it { should respond_to :article }
  it { should respond_to :review }

  describe "with the default values" do
    it { should be_valid }
  end


  describe 'Content' do

    describe "when content is too small" do
      before { @comment.content = 'abc' }
      it { should_not be_valid }
    end

    describe "when content is too big" do
      before { @comment.content = 'abc' * 1000 }
      it { should_not be_valid }
    end

    describe "when content is blank" do
      before { @comment.content = ' ' }
      it { should_not be_valid }
    end

  end

  describe "when article_id & review_id both are not present" do
    before { @comment.article_id = nil }
    before { @comment.review_id = nil }
    it { should_not be_valid }
  end

end
