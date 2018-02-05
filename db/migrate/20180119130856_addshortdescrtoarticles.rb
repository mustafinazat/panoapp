class Addshortdescrtoarticles < ActiveRecord::Migration[5.1]
  def change
    change_table :articles do |t|
      t.text :shortdesc
      end
  end
end
