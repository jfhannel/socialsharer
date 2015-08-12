class CreateAdminAccounts < ActiveRecord::Migration
  def change
    create_table :admin_accounts do |t|

      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
