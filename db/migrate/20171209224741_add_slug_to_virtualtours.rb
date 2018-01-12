class AddSlugToVirtualtours < ActiveRecord::Migration[5.1]
  def change
  	  	add_column :virtualtours, :slug, :string
    add_index :virtualtours, :slug
  end
end
