class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.string :slug
      t.timestamps
    end
  end
end
