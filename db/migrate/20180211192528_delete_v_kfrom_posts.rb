class DeleteVKfromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :vk_owner_id
    remove_column :posts, :vk_album_id
  end
end
