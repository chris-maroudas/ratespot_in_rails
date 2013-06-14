class ReviewsController < ApplicationController

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

	end
end

