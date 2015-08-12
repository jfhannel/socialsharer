class LinkedinPost < ActiveRecord::Base
  	belongs_to :admin_account
  	has_many :linkedin_shares
	default_scope { order('publish_time DESC') } 

	def self.post_from_linkedin(post)
		tp = LinkedinPost.new
		tp[:publish_time] = post.created_at
		tp[:text] = post.text
		tp[:linkedin_id] = post.id
		return tp
	end
end
