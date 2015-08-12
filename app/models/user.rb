class User < ActiveRecord::Base
	has_one :user_account, dependent: :destroy
	has_one :admin_account
	after_create :make_account
	# validates :email, :presence => true, :email => true

	def self.get_n_twitter_accounts(num_shares)
		users = []
		User.all.each do |u|
			if not u[:is_master_user] and u.twitter_account
				users << u.twitter_account
			end
		end
		users = users.sort_by{|u| u.twitter_owner.last_activity}
		return users[0,num_shares]
	end

	def account=(value)
	    if self[:is_master_user]
			self.admin_account = value
		else
			self.user_account = value
		end
  	end

	def account
		if self[:is_master_user]
			return self.admin_account
		else
			return self.user_account
		end
	end

	def twitter_account=(value)
	    self.account.twitter_account = value
	    self.account.save
  	end

	def twitter_account
		return self.account.twitter_account
	end

	def linkedin_account=(value)
	    self.account.linkedin_account = value
	    self.account.save
  	end

	def linkedin_account
		return self.account.linkedin_account
	end

	def make_account
		if self[:is_master_user]
			acc = AdminAccount.new
		else
			acc = UserAccount.new
		end
	
		self.account = acc
		acc.save
	end

	def self.admin_user
		if User.exists?(is_master_user: true)
			master = User.find_by is_master_user: true
			return master
		else
			return nil
		end
	end

	def self.get_twitter_accounts
		accounts = []
		User.all.each do |u|
			if not u.twitter_account.nil?
				accounts << u.twitter_account
			end
		end
		return accounts
	end

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
