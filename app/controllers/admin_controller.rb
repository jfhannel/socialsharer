class AdminController < ApplicationController

  def home
  	@twitter_users = []
  	User.all.each do |u|
  		if not u[:is_master_user] and u.twitter_account
  			@twitter_users << u
  		end
  	end
  	@linkedin_users = []
  	User.all.each do |u|
  		if not u[:is_master_user] and u.linkedin_account
  			@linkedin_users << u
  		end
  	end
  end

end
