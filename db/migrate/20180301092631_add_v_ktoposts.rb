class AddVKtoposts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :vk_owner_id, :string, :default => ""
    add_column :posts, :vk_album_id, :string, :default => ""
  end
end
