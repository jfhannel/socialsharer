class TwitterShare < ActiveRecord::Base
  belongs_to :twitter_post
  belongs_to :user_account
  default_scope { order('publish_after DESC') }

  def share
  	success = self.user_account.retweet(self.twitter_post)
  	p 'tried retweet'
  	p success
    self.completed = true
    self.save
  	if success
      self.publish_time = DateTime.current.utc
      p self.publish_time
      self.save
  	end
  end
end
