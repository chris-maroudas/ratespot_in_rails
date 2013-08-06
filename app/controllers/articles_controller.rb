class ArticlesController < ApplicationController

  before_filter :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update, :destroy] #defines also an instance var for those
  before_filter :allowed_to_post, only: [:new, :edit, :update, :destroy, :create]

  def index
    @articles = Article.includes(:user).paginate(page: params[:page], per_page: 4)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(params[:article])
    if @article.save
      flash[:success] = 'Article posted!'
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
    @comment = @article.comments.build # Initializing @comment for the comments/form partial
  end


  def edit
  end

  def update
    if @article.update_attributes(params[:article])
      redirect_to root_path
      flash[:success] = "Successful edit"
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      redirect_to root_path
    else
      flash[:error] = 'Failed to delete the article'
      redirect_to root_path
    end
  end


  # callbacks

  def correct_user
    @article = current_user.articles.find_by_id(params[:id]) # Check if the accessed review belongs to current user
    redirect_to root_path, notice: 'You are not authorized for that action' if @article.nil?
  end

  def allowed_to_post
    redirect_to root_path, notice: 'You are not authorized for that action' unless current_user.article_author?
  end

end
