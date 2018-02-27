class Addcolltopanoramas < ActiveRecord::Migration[5.1]
  def change
    add_column :panoramas, :testcol, :string
  end
end
