class CommentsController < ApplicationController

  before_filter :signed_in_user  # a non signed in user, cannot create a comment

  def create
    @comment = Comment.new(params[:comment])
    @comment.review_id = params[:review_id] unless params[:review_id].nil?
    @comment.article_id = params[:article_id] unless params[:article_id].nil?
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to @comment.review || @comment.article
      flash[:success] = "Comment posted"
    else
      @article = @comment.article
      @review = @comment.review
      render 'comments/_form'
    end

  end


end
