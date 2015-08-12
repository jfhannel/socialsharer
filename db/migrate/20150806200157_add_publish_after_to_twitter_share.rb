class AddPublishAfterToTwitterShare < ActiveRecord::Migration
  def change
  	add_column :twitter_shares, :publish_after, :datetime
  end
end
