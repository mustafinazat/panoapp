class AddPrivateToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :closed, :boolean
  end
end
