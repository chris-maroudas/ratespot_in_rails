# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  article_author  :boolean          default(FALSE)
#

require 'spec_helper'

describe User do

	before { @user = User.new(name: 'Example User', email: "user@example.com", password: "foobar", password_confirmation: "foobar") }
	subject { @user }

	it { should be_valid }
	it { should respond_to :email }
	it { should respond_to :name }
	it { should respond_to :password }
	it { should respond_to :password_confirmation }
	it { should respond_to :remember_token }
	it { should respond_to :authenticate }
	it { should respond_to :reviews }
	it { should respond_to :articles }
	it { should respond_to :comments }


	describe "when name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @user.name = 'a' * 51 }
		it { should_not be_valid }
	end


	describe "when email format is invalid" do
		before { @user.email = 'gfd@gmail,v' }
		it { should_not be_valid }
	end


	describe "when email format is valid" do
		it "should be valid" do
			@user.email = "mallibu97@gmail.com"
			@user.should be_valid
		end
	end


	describe "when email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end
		it { should_not be_valid }
	end


	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid }
	end


	describe "when password doesn't match confirmation" do
		before { @user.password_confirmation = 'mismatch' }
		it { should_not be_valid }
	end

	describe "when password is nil" do
		before { @user.password_confirmation = nil }
		it { should_not be_valid }
	end

	describe "with a password that's too short" do
		before { @user.password = @user.password_confirmation = 'v' * 5 }
		it { should_not be_valid }
	end


	# Authentication testing

	describe "return value of authenticate method" do

		before { @user.save } # need to save user to use the #authenticate method
		let(:found_user) { User.find_by_email(@user.email) }


		describe "with valid password" do
			it { should == found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }

			it { should_not == user_for_invalid_password } #current user should not be equal to the user returned by the authenticate with wrong password (false)
			specify { user_for_invalid_password.should be_false } #synonym to it. authentication returns false therefor the user should be false
		end

  end

  # Article authors tests

  describe "when email doesn't belong in authors list" do
    it { should_not be_article_author }
  end

  describe "when email belongs to authors list" do
    before do
      @user.email = "chris_maroudas@gmail.com"
      @user.save
    end
    it { should be_article_author }
  end

end
