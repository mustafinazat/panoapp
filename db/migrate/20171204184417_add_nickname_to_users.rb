class AddNicknameToUsers < ActiveRecord::Migration[5.1]
  def change
      add_column :users, :nickname, :string
      add_column :users, :description, :text
     end
end
