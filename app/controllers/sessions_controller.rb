class SessionsController < Devise::SessionsController
	skip_before_action :require_login, only: [:new]
end