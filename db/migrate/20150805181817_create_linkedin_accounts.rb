class CreateLinkedinAccounts < ActiveRecord::Migration
  def change
    create_table :linkedin_accounts do |t|
      t.string :access_token
      t.string :first_name
      t.string :last_name

      t.references :linkedin_owner, polymorphic: true
      t.timestamps null: false
    end
  end
end
