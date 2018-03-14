class AddflickrtoPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :flickr_album_id, :string, :default => ""
  end
end
