class CommentsController < ApplicationController

	before_filter :signed_in_user # a non signed in user, cannot post a comment

	def create
		@comment = Comment.new(params[:comment])
		@comment.user_id = current_user.id

		if @comment.save
			redirect_to request.referer
			flash[:success] = "Comment posted"
		else
			render 'comments/_form'
		end

  end

end
