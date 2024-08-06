class NewPostNotifier < Noticed::Base
  required_param :post

  def deliver(recipient)
    deliver_by :database
  end
end
