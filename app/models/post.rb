class Post < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  belongs_to :discussion, counter_cache: true, touch: true
  belongs_to :team, optional: true
  has_rich_text :content

  has_noticed_notifications


  validates :content, presence: true

  after_create_commit -> { broadcast_append_to discussion, partial: "discussions/posts/post", locals: { post: self }}
  after_update_commit -> { broadcast_replace_to discussion, partial: "discussions/posts/post", locals: { post: self }}
  after_destroy_commit -> { broadcast_remove_to discussion }


  def likes_count
    likes.count
  end
end
