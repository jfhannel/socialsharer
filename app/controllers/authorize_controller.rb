class AuthorizeController < ApplicationController
  def linkedin

  	oauth = LinkedIn::OAuth2.new

  	url = oauth.auth_code_url
    p 'URL'
    p url
  	redirect_to url

  end

  def twitter
  	redirect_to '/auth/twitter?use_authorize=true'

  end

  #def facebook
  #	callback_url = 'http://localhost:3000/auth/facebook'
  #	scope = 'publish_actions'
  #	oauth = Koala::Facebook::OAuth.new(ENV['facebook_api_key'], ENV['facebook_api_secret'], callback_url)
  #	url = oauth.url_for_oauth_code(:scope => scope)
  #	redirect_to url

  #end

  def linkedin_cb
  	code = params[:code]
  	oauth = LinkedIn::OAuth2.new

  	access_token = oauth.get_access_token(code)
    p 'access_token'
  	p access_token.token

  	api = LinkedIn::API.new(access_token.token)
  	my_name = api.profile(fields: ["first-name", "last-name"])
    p my_name.first_name

    li_acct = LinkedinAccount.new
    li_acct[:first_name] = my_name.first_name
    li_acct[:last_name] = my_name.last_name
    li_acct[:access_token] = access_token.token

    current_user.linkedin_account = li_acct
    li_acct.save

  	redirect_to ""
  end

  def twitter_cb

  	results = request.env['omniauth.auth']
  	access_token = results[:credentials][:token]
  	secret = results[:credentials][:secret]
  	screen_name = results[:extra][:raw_info][:screen_name]

    if current_user.twitter_account
      current_user.twitter_account[:access_token] = access_token
      current_user.twitter_account[:access_token_secret] = secret
      current_user.twitter_account[:screen_name] = screen_name
      current_user.twitter_account[:is_valid] = true

      current_user.twitter_account.save
    else
    	twit_acct = TwitterAccount.new
    	twit_acct[:access_token] = access_token
    	twit_acct[:access_token_secret] = secret
    	twit_acct[:screen_name] = screen_name

      current_user.twitter_account = twit_acct
      twit_acct.save
    end

  	redirect_to ""

  end

  #def facebook_cb

  #	oauth = LinkedIn::OAuth2.new

  #	print params[:code]
  #	pp oauth.get_access_token(code)

  #end

end
