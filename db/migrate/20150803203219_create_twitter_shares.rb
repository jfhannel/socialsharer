class CreateTwitterShares < ActiveRecord::Migration
  def change
    create_table :twitter_shares do |t|
      t.datetime :publish_time
      t.boolean :completed, default: false
      t.references :twitter_post, index: true, foreign_key: true
      t.references :user_account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
