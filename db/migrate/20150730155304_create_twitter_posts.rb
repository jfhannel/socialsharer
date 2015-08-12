class CreateTwitterPosts < ActiveRecord::Migration
  def change
    create_table :twitter_posts do |t|
      t.datetime :publish_time
      t.string :text
      t.string :twitter_id
      t.boolean :shares_created, default: false
      t.references :admin_account

      t.timestamps null: false
    end
  end
end
