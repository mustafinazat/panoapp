class Addcolumstopost < ActiveRecord::Migration[5.1]
  def change
  	 add_column :posts, :title, :string
  	 add_column :posts, :description, :text
  	 add_column :posts, :user_id, :integer
   end
end
