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
#  image_url  :string(255)
#

require 'spec_helper'

describe Article do

  content = "a simple placeholder sentence" * 60
  before { @article = Article.new(title: 'Example title' * 4, content: content, image_url: 'http://www.randomsite.com/randomimage.jpg') }
  before { @article.user_id = 1 }
  subject { @article }


  it { should be_valid }
  it { should respond_to :title }
  it { should respond_to :content }
  it { should respond_to :user_id }
  it { should respond_to :comments }
  it { should respond_to :tags }
  it { should respond_to :taggings }

  describe "user_id" do

    describe "when user_id is given" do
      it { should be_valid }
    end

    describe "when user_id is NOT given" do
      before { @article.user_id = nil }
      it { should_not be_valid }
    end

  end

  describe "title" do

    describe "when title is too short" do
      before { @article.title = 'title' }
      it { should_not be_valid }
    end

    describe "when title is too long" do
      before { @article.title = 'title' * 100 }
      it { should_not be_valid }
    end

    describe "when title is blank" do
      before { @article.title = " " }
      it { should_not be_valid }
    end

  end

  describe "content" do

    describe "when content is too short" do
      before { @article.content = "abc" }
      it { should_not be_valid }
    end

    describe "when content is too long" do
      before { @article.content = "abc" * 10000 }
      it { should_not be_valid }
    end

    describe "when content is blank" do
      before { @article.content = " " }
      it { should_not be_valid }
    end

    describe 'when content is valid' do
      it { should be_valid }
    end

  end


  describe "image_url" do

    describe "when image url is blank" do
      before { @article.image_url = " " }
      it { should_not be_valid }
    end

    describe "when image url is too long" do
      before { @article.image_url = "abc" * 500 + ".jpg" }
      it { should_not be_valid }
    end

    describe "when image url doesn't end with valid file type" do
      before { @article.image_url = "http://www.invalidplace.com/invalid_image.dat" }
      it { should_not be_valid }
    end

  end

end