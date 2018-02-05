class AddPrivateToVirtualtours < ActiveRecord::Migration[5.1]
  def change
    add_column :virtualtours, :closed, :boolean
  end
end
