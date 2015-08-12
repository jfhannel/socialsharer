class LinkedinShare < ActiveRecord::Base
  belongs_to :linkedin_post
  belongs_to :user_account
end
