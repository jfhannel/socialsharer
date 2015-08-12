class TwitterAccount < ActiveRecord::Base
	belongs_to :twitter_owner, polymorphic: true

	def update_share_for_post(post)
		share = TwitterShare.new
		rate = 1
		average_days = 0.75/24.0
		days_until_publish = Math.log(1 - rand)/(-rate) * average_days
		publish_date = (DateTime.current + days_until_publish).utc
		if publish_date.in_time_zone.hour >= 23 or publish_date.in_time_zone.hour <= 3
			publish_date = publish_date - 4.5/24.0
		end
		if publish_date.in_time_zone.hour >= 4 and publish_date.in_time_zone.hour <= 6
			publish_date = publish_date + 3.5/24.0
		end
		share[:publish_after] = publish_date
		post.twitter_shares << share
		self.twitter_owner.twitter_shares << share
		share.save

		AdminAccount.delay(run_at: share[:publish_after]).do_retweets
	end
end

