class CreateTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|

    	t.string :access_token
    	t.string :access_token_secret
    	t.string :screen_name

    	t.references :twitter_owner, polymorphic: true
      	t.timestamps null: false
    end
  end
end
