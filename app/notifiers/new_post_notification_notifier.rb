# To deliver this notification:
#
# NewPostNotificationNotifier.with(record: @post, message: "New post").deliver(User.all)

class NewPostNotificationNotifier < ApplicationNotifier
  # Add your delivery methods
  #
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end

  deliver_by :database
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  required_param :post

  def message
    "New post in #{params[:post].discussion.name}"
  end

  def url
    discussion_path(params[:post].discussion)
  end
end
