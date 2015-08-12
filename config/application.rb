require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SocialSharer
  class Application < Rails::Application
    config.time_zone = 'Pacific Time (US & Canada)'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    LinkedIn.configure do |config|
      config.client_id     = ENV["linkedin_api_key"]
      config.client_secret = ENV["linkedin_api_secret"]

      config.scope = 'r_basicprofile w_share'

      # This must exactly match the redirect URI you set on your application's
      # settings page. If your redirect_uri is dynamic, pass it into
      # `auth_code_url` instead.
      config.redirect_uri  = "http://localhost:3000/auth/linkedin"
    end
  end
end
