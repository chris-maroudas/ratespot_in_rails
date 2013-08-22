class AdminController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user

  def index
    if params[:approved] && params[:approved].in?(%w[false])
      @reviews = Review.where(approved: false).includes(:user).paginate(page: params[:page], per_page: 6)
    else
      @reviews = Review.where(approved: true).includes(:user).paginate(page: params[:page], per_page: 6)
    end
  end

  def admin_user
    redirect_to root_path, notice: "You're not authorized for that" unless current_user.admin?
  end

end
