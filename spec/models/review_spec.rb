# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  rating     :integer
#  user_id    :integer
#  product    :string(255)
#  category   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_url  :string(255)
#

require 'spec_helper'

describe Review do

  content = "a simple placeholder sentence" * 60
  before { @review = Review.new(title: 'Example title' * 4, content: content, rating: 5, product: 'Intel 330 SSD series', category: 'cpu', image_url: 'http://www.randomsite.com/randomimage.jpg') }
  before { @review.user_id = 1 }
  subject { @review }


  it { should be_valid }
  it { should respond_to :title }
  it { should respond_to :content }
  it { should respond_to :rating }
  it { should respond_to :user_id }
  it { should respond_to :category }
  it { should respond_to :product }
  it { should respond_to :comments }
  it { should respond_to :tags }
  it { should respond_to :taggings }

  describe "user_id" do

    describe "when user_id is given" do
      it { should be_valid }
    end

    describe "when user_id is NOT given" do
      before { @review.user_id = nil }
      it { should_not be_valid }
    end

  end

  describe "title" do

    describe "when title is too short" do
      before { @review.title = 'title' }
      it { should_not be_valid }
    end

    describe "when title is too long" do
      before { @review.title = 'title' * 100 }
      it { should_not be_valid }
    end

    describe "when title is blank" do
      before { @review.title = " " }
      it { should_not be_valid }
    end

  end

  describe "content" do

    describe "when content is too short" do
      before { @review.content = "abc" }
      it { should_not be_valid }
    end

    describe "when content is too long" do
      before { @review.content = "abc" * 10000 }
      it { should_not be_valid }
    end

    describe "when content is blank" do
      before { @review.content = " " }
      it { should_not be_valid }
    end

    describe 'when content is valid' do
      it { should be_valid }
    end

  end

  describe "product" do

    describe "when product is too short" do
      before { @review.product = "abc" }
      it { should_not be_valid }
    end

    describe "when product is too long" do
      before { @review.product = "abc" * 100 }
      it { should_not be_valid }
    end

    describe "when product is blank" do
      before { @review.product = " " }
      it { should_not be_valid }
    end

    describe "when product is valid" do
      before { @review.product = "intel ssd 330" }
      it { should be_valid }
    end

  end

  describe "category" do

    describe "when category is blank" do
      before { @review.category = " " }
      it { should_not be_valid }
    end

    describe "when category is not included in valid categories" do
      before { @review.category = "invalid_category" }
      it { should_not be_valid }
    end

    describe "when category is included in valid categories" do
      before { @review.category = "gpu" }
      it { should be_valid }
    end

  end

  describe "rating" do

    describe "when rating is blank" do
      before { @review.rating = " " }
      it { should_not be_valid }
    end

    describe "when rating is not a number" do
      before { @review.rating = "invalid_rating" }
      it { should_not be_valid }
    end

    describe "when rating is higher than maximum" do
      before { @review.rating = 6 }
      it { should_not be_valid }
    end

    describe "when rating is lower than minimum" do
      before { @review.rating = 0 }
      it { should_not be_valid }
    end

    describe "when rating is a float" do
      before { @review.rating = 1.31432 }
      it { should_not be_valid }
    end

    describe "when rating is valid" do
      before { @review.rating = 4 }
      it { should be_valid }
    end

  end


  describe "image_url" do

    describe "when image url is blank" do
      before { @review.image_url = " " }
      it { should_not be_valid }
    end

    describe "when image url is too long" do
      before { @review.image_url = "abc" * 500 + ".jpg" }
      it { should_not be_valid }
    end

    describe "when image url doesn't end with valid file type" do
      before { @review.image_url = "http://www.invalidplace.com/invalid_image.dat" }
      it { should_not be_valid }
    end

  end

end