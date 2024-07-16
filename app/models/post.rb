class Post < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  belongs_to :discussion, counter_cache: true, touch: true
  belongs_to :team, optional: true

  has_rich_text :content

  validates :content, presence: true

  def likes_count
    likes.count
  end
end
