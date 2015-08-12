class ShareController < ApplicationController

	def tweets
		current_user.account.gather_twitter_posts
		@total_twitter_users = 0
	  	User.all.each do |u|
	  		if not u[:is_master_user] and u.twitter_account
	  			@total_twitter_users += 1
	  		end
	  	end
		@completed_shares = {}
		@total_shares = {}
		TwitterPost.all.each do |p|
			shares = p.twitter_shares
			@total_shares[p[:id]] = shares.length
			completed = 0
			shares.each do |s|
				if s[:completed]
					completed += 1
				end
			end
			@completed_shares[p[:id]] = completed
		end
	end

	def retweet
		id = params[:retweet][:twitter_post_id].to_i
		num_rts = params[:retweet][:num_rts].to_i
		puts 'RETWEEEET'
		puts id.to_s
		puts num_rts.to_s
		current_user.account.update_shares_for_twitter_post(TwitterPost.find(id), num_rts)
		redirect_to '/share/tweets'
	end

	def linkedin_posts
		current_user.account.gather_linkedin_posts
	end

	def share_linkedin
		id = params[:linkedin_post_id]
		current_user.account.update_share_for_linkedin_post(LinkedinPost.find(id))
		current_user.account.share
		redirect_to '/share/linkedin_posts'
	end

end
