class AddParentlinkToPanoramas < ActiveRecord::Migration[5.1]
  def change
  	 add_column :panoramas, :parentlink_type, :string
  	 add_column :panoramas, :parentlink_id, :integer
  	 add_index :panoramas, [:parentlink_type, :parentlink_id]
  end
end
