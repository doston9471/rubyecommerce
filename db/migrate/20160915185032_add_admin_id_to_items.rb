class AddAdminIdToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :admin_id, :integer
  end
end
