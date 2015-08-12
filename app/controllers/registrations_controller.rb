class RegistrationsController < Devise::RegistrationsController
	skip_before_action :require_login, only: [:new, :create]

  private

  def sign_up_params
    params.require(:user).permit(:email, :is_master_user, :password, :password_confirmation)
  end

end