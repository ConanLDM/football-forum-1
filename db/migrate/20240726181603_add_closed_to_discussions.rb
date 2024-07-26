class AddClosedToDiscussions < ActiveRecord::Migration[7.1]
  def change
    add_column :discussions, :closed, :boolean, default: false
  end
end
