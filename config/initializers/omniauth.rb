Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
           Rails.configuration.settings.facebook.application_key,
           Rails.configuration.settings.facebook.application_secret,
           scope: 'publish_stream,offline_access,email,user_location,user_about_me'
end

OmniAuth.config.logger = Rails.logger

if Rails.env.test?
  OmniAuth.config.test_mode = true
end
