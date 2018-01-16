class AddcolumnstoArticles < ActiveRecord::Migration[5.1]
  def change
  	add_index :articles, :slug

  	change_table :taggings do |t|
      t.belongs_to :article, foreign_key: true
    end
  end
end
