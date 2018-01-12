class Addthumbcoltopanoramas < ActiveRecord::Migration[5.1]
  def change
  	 add_column :panoramas, :image_file_name_thumb, :string
  end
end
