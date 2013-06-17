class UsersController < ApplicationController

	before_filter :signed_in_user, only: [:show, :edit, :update, :destroy, :reviews]
	before_filter :correct_user, only: [:edit, :update, :destroy] #defines also an instance var for those

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:success] = 'Thank you for signing up'
			redirect_to root_path
		else
			render 'new'
		end
	end

	def index

	end

	def show
		@user = User.find(params[:id])
	end

	def edit
	end

	def update
		if @user.update_attributes(params[:user])
			redirect_to root_path
			flash[:success] = 'Profile edited'
		else
			render 'edit'
		end
	end

	def destroy

	end

	def reviews
		@user = User.find(params[:id])
		@reviews = @user.reviews.paginate(page: params[:page], per_page: 1)
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to root_path, notice: "You are not authorized to do that" unless current_user?(@user)
	end
end
