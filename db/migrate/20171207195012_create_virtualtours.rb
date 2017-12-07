class CreateVirtualtours < ActiveRecord::Migration[5.1]
  def change
    create_table :virtualtours do |t|
      t.string :title
      t.text :description
      t.string :connections
      t.integer :user_id
      t.timestamps
    end
  end
end
