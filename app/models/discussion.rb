class Discussion < ApplicationRecord
  has_many :posts
  belongs_to :user, default: -> { Current.user }

  validates :title, presence: true
end
