class CreateLinkedinShares < ActiveRecord::Migration
  def change
    create_table :linkedin_shares do |t|
      t.datetime :publish_time
      t.boolean :completed
      t.references :linkedin_post, index: true, foreign_key: true
      t.references :user_account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
