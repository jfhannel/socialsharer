class LinkedinAccount < ActiveRecord::Base
	belongs_to :linkedin_owner, polymorphic: true

	def update_share_for_post(post)
		share = LinkedinShare.new
		post.linkedin_shares << share
		self.linkedin_owner.linkedin_shares << share
		share.save
	end
end
