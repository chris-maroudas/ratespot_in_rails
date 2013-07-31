class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper # Helpers are available in the views, but not in the controller. I need the methods from Sessions helper in both places so I have to include it specificaly

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end

end
