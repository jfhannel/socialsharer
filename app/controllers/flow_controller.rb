class FlowController < ApplicationController
	skip_before_action :require_login, only: :home

	def home
		if user_signed_in?
			if current_user[:is_master_user]
				redirect_to "/admin/home"
			else
				redirect_to "/user/home"
			end
		end
	end

end