class CreateLinkedinPosts < ActiveRecord::Migration
  def change
    create_table :linkedin_posts do |t|
      t.datetime :publish_time
      t.string :text
      t.string :linkedin_id
      t.boolean :shares_created
      t.references :admin_account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
