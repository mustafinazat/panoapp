class CreatePanoramas < ActiveRecord::Migration[5.1]
  def change
    create_table :panoramas do |t|

      t.timestamps
    end
  end
end
