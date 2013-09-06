class ReviewsController < ApplicationController

  before_filter :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update, :destroy] #defines also an instance var for those

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(params[:review])
    if @review.save
      redirect_to @review
      flash[:success] = "Thank you for your review"
    else
      render 'new'
    end
  end

  def index

    if params[:category] && params[:category].in?(%w[cpu gpu storage monitor motherboard])
      @reviews = Review.where(category: params[:category], approved: true).includes(:user).paginate(page: params[:page], per_page: 6)
    else
      @reviews = Review.where(approved: true).includes(:user).paginate(page: params[:page], per_page: 6)
    end

  end

  def edit
    #Instance var @review, defined at correct_user
  end

  def show
    begin
      @review = Review.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid review #{params[:id]}"
      redirect_to root_path, notice: 'Review does not exist'
    else
      @comment = @review.comments.build # Initializing @comment for the comments/form partial
      @comments = @review.comments.includes(:user)
    end
  end

  def update

    # An admin might be issuing an UPDATE
    # and in that case the @review defined in correct_user will be nil, since
    # the review doesn't belong to the current_user
    @review ||= Review.find(params[:id])

    if @review.update_attributes(params[:review])
      redirect_to @review
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


  def search
    @reviews = Review.search(params[:search])
  end


  # before filters

  def correct_user
    @review = current_user.reviews.find_by_id(params[:id]) # Check if the accessed review belongs to current user
    redirect_to root_path, notice: 'You are not authorized for that action' if @review.nil? && !current_user.admin?
  end

end
