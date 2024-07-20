class Post < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  belongs_to :discussion, counter_cache: true, touch: true
  belongs_to :team, optional: true

  has_rich_text :content

  validates :content, presence: true

  after_create_commit -> { broadcast_append_to discussion, partial: "discussions/posts/post", locals: { post: self }}
  

  def likes_count
    likes.count
  end
end
