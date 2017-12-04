class AddVkalbumToPosts < ActiveRecord::Migration[5.1]
  def change
  	    add_column :posts, :vk_owner_id, :string
    add_column :posts, :vk_album_id, :string
  end
end
