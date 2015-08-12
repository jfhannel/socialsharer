class TwitterPost < ActiveRecord::Base
	belongs_to :admin_account
	has_many :twitter_shares
	default_scope { order('publish_time DESC') } 

	def self.post_from_tweet(tweet)
		tp = TwitterPost.new
		tp[:publish_time] = tweet.created_at
		tp[:text] = tweet.text
		tp[:twitter_id] = tweet.id
		return tp
	end
end
