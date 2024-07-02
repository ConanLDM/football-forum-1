class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_post.subject
  #
  def new_post
    @greeting = "Hi"

    mail to: params[:user].email
  end
end
