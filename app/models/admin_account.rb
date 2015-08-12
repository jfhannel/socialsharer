class AdminAccount < ActiveRecord::Base
	has_many :twitter_posts
	has_one :twitter_account, as: :twitter_owner
	has_many :linkedin_posts
	has_one :linkedin_account, as: :linkedin_owner
	belongs_to :user

	def make_twitter_client
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV["twitter_api_key"]
		  config.consumer_secret     = ENV["twitter_api_secret"]
		  config.access_token        = self.twitter_account[:access_token]
		  config.access_token_secret = self.twitter_account[:access_token_secret]
		end
		return client
	end

	def twitter_client
		if not @twitter_client
			@twitter_client = self.make_twitter_client
		end
		return @twitter_client
	end

	def make_linkedin_client
		client = LinkedIn::API.new(self.linkedin_account[:access_token])
		return client
	end

	def linkedin_client
		if not @linkedin_client
			@linkedin_client = self.make_linkedin_client
		end
		return @linkedin_client
	end

	def self.refresh_posts
		p 'self gather'
		admin = AdminAccount.admin_account		
		if admin
			admin.refresh_posts
		end
	end

	def refresh_posts
		self.gather_twitter_posts
		TwitterShare.all.each do |s|
			if not s.completed and DateTime.current.utc >= s[:publish_after]
				if not s.share
					UserMailer.reauth(s.user_account.user).deliver_now
					p 'FAAAIILLLL'
					p s.user_account.user[:email]
				end
			end
		end
	end

	def self.do_retweets
		TwitterShare.all.each do |s|
			if not s.completed and DateTime.current.utc >= s[:publish_after]
				s.share
			end
		end
	end

	def gather_twitter_posts
		last_post = TwitterPost.first
		if last_post
			tweets = self.twitter_client.user_timeline(self.twitter_account[:screen_name], options={ since_id: last_post[:twitter_id] })
		else
			tweets = self.twitter_client.user_timeline(self.twitter_account[:screen_name], options={ count: 1 })
		end
		tweets.each do |t|
			t_post = TwitterPost.post_from_tweet(t)
			self.twitter_posts << t_post
			t_post.save
		end
	end

	def gather_linkedin_posts
		p 'PROFIEL'
		#last_post = LinkedinPost.first
		#if last_post
		#	tweets = self.twitter_client.user_timeline(self.twitter_account[:screen_name], options={ since_id: last_post[:twitter_id] })
		#else
		#	tweets = self.twitter_client.user_timeline(self.twitter_account[:screen_name], options={ count: 1 })
		#end
		#tweets.each do |t|
		#	t_post = TwitterPost.post_from_tweet(t)
		#	self.twitter_posts << t_post
		#	t_post.save
		#end
	end

	def self.admin_account
		admin_user = User.find_by email: ENV['admin_user_email']
		if admin_user
			return admin_user.account
		else
			return nil
		end
	end

	def update_shares_for_twitter_post(twitter_post, num_shares)
		User.get_n_twitter_accounts(num_shares).each do |t|
			if not TwitterShare.find_by twitter_post_id: twitter_post[:id], user_account_id: t.twitter_owner[:id]
				p 'updating shares for user!'
				p 'sharing post!'
				t.update_share_for_post(twitter_post)
			end
		end
		twitter_post[:shares_created] = true
		twitter_post.save
	end

end
