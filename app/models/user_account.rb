class UserAccount < ActiveRecord::Base
	has_many :twitter_shares, dependent: :destroy
	has_one :twitter_account, as: :twitter_owner, dependent: :destroy
	has_many :linkedin_shares, dependent: :destroy
	has_one :linkedin_account, as: :linkedin_owner, dependent: :destroy
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
		if not @client
			@client = self.make_twitter_client
		end
		return @client
	end

	def last_activity
		begin
			p 'publish after'
			p self[:id]
			p self.twitter_shares.order("publish_after DESC").first![:publish_after]
			return self.twitter_shares.order("publish_after DESC").first![:publish_after].to_f
		rescue
			p 'default time'
			p DateTime.current.utc - 365*10
			return (DateTime.current.utc - 365*10).to_f
		end
	end

	def retweet(twitter_post)
		if self.twitter_account[:is_valid]
			begin
				self.twitter_client.retweet(twitter_post.twitter_id)
			rescue => error
				if (error.message.downcase.include? 'forbidden' or error.message.downcase.include? 'credentials' or error.message.downcase.include? 'auth')
					self.twitter_account[:is_valid] = false
					self.twitter_account.save
					UserMailer.reauth(s.user_account.user).deliver_now
				end
				return false
			else
				return true
			end
		end
		return false
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

end
