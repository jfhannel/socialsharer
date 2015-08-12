class AddFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_master_user, :boolean, default: false
  end
end
