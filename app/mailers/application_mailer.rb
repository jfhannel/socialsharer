class ApplicationMailer < ActionMailer::Base
  default from: ENV['admin_user_email']
  layout 'mailer'
end
