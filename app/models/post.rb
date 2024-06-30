class Post < ApplicationRecord
  belongs_to :user
  belongs_to :team, optional: true

  validates :content, presence: true

  def likes_count
    likes.count
  end
end
