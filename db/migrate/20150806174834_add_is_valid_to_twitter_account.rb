class AddIsValidToTwitterAccount < ActiveRecord::Migration
  def change
  	add_column :twitter_accounts, :is_valid, :boolean, default: true
  end
end
