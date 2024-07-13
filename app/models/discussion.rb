class Discussion < ApplicationRecord
  has_many :posts
  belongs_to :user, default: -> { Current.user }

  validates :title, presence: true

  def to_param
    "#{id}-#{title.downcase.to_s[0...100]}".parameterize
  end
end
