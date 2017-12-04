class Addimagestopanoramas < ActiveRecord::Migration[5.1]
  def self.up
    change_table :panoramas do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :panoramas, :image
   end
end
