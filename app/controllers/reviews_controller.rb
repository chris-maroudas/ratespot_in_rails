class ReviewsController < ApplicationController

	before_filter :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
	before_filter :correct_user, only: [:edit, :update, :destroy] #defines also an instance var for those

	def new
		@review = Review.new
	end

	def create
		@review = current_user.reviews.build(params[:review])
		if @review.save
			redirect_to root_path
			flash[:success] = "Thank you for your review"
		else
			render 'new'
		end
	end

	def index
		@reviews = Review.includes(:user).paginate(page: params[:page], per_page: 4) # avoid N+1 query
	end

	def edit
	end

	def update
		if @review.update_attributes(params[:review])
			redirect_to root_path
			flash[:success] = "Edit successful"
		else
			render 'edit'
		end
	end

	def destroy
		@review.destroy
		redirect_to root_path
		flash[:notice] = 'Review deleted'
	end

	def category
		@reviews = Review.includes(:user).where(category: params[:category]).paginate(page: params[:page], per_page: 1)
	end


	def correct_user
		@review = current_user.reviews.find_by_id(params[:id]) # Check if the accessed review belongs to current user
		redirect_to root_path, notice: 'You are not authorized for that action' if @review.nil?
	end

end

