class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:show, :edit, :update, :destroy, :reviews]
  # defines the @user instance var
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def new
    redirect_to root_url if signed_in?
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
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid user #{params[:id]}"
      redirect_to root_path, notice: 'User does not exist'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to root_path
      flash[:success] = 'Profile edited'
      sign_in @user
    else
      render 'edit'
    end
  end

  def destroy
    if current_user.destroy
      redirect_to root_path, notice: 'Profile deleted'
    else
      render 'show'
      flash[:error] = 'Profile failed to delete'
    end
  end

  def reviews
    @user = User.find(params[:id])
    @reviews = @user.reviews.includes(:user).paginate(page: params[:page], per_page: 6)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path, notice: "You are not authorized to do that" unless current_user?(@user)
  end

end

















