class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true # This provides a cache for the number of associated records

  validates :user_id, uniqueness: { scope: :post_id } # So that users cannot provide an infinite/multiple amount of likes on a post
end
