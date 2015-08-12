class UserMailer < ApplicationMailer
	def reauth(user)
	    @recipient = user[:email]
	    mail(to: @recipient,
	         subject: "[ThoughtSpot Retweeter] Please Re-authenticate")
	end
end
