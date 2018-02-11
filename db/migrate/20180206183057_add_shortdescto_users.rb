class AddShortdesctoUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.text :shortdesc
    end
  end
end
