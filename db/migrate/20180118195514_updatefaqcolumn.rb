class Updatefaqcolumn < ActiveRecord::Migration[5.1]
  def change
    change_table :faqs do |t|
      t.change :answer, :text

    end
  end
end
