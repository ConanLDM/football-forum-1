class Discussion < ApplicationRecord
  has_many :posts
  belongs_to :user, default: -> { Current.user }

  validates :title, presence: true

  has_many :posts, dependent: :destroy

  accepts_nested_attributes_for :posts

  after_create_commit -> { broadcast_prepend_to "discussions" }
  after_update_commit -> { broadcast_replace_to "discussions" }
  after_destroy_commit -> { broadcast_remove_to "discussions" }

  def to_param
    "#{id}-#{title.downcase.to_s[0...100]}".parameterize
  end
end
