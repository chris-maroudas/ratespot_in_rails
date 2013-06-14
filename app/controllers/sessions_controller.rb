class SessionsController < ApplicationController
  def new
  end

  def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to root_url
			flash[:success] = "Signed in"
		else
			flash.now[:error] = "Wrong email/password combination"
			render 'new'
		end
  end

  def destroy
		sign_out
  end
end
