class AddDiscussionIdToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :discussion_id, :integer
  end
end
