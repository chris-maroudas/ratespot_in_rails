class UserMailer < ActionMailer::Base
  default from: "ratespot@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.registered_user.subject
  #
  def registered_user(user)
	  @user = user
	  @greeting = "Hi, #{@user.name}"
    mail to: @user.email, subject: 'Thanks for registering to Ratespot'
  end

	def updated_user(user)
		@user = user
		@greeting = "Hi, #{@user.name}"
		mail to: @user.email, subject: 'Your profile details were updated'
	end

end
