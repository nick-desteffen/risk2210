Risk2210::Application.configure do
  config.cache_classes = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = false
  config.assets.compress = true
  config.assets.digest = true
  config.assets.compile = false
  config.assets.precompile += %w( risk_tracker.js )
  #config.assets.precompile += %w( mobile.js mobile.css )

  config.action_mailer.default_url_options = { host: 'http://risk2210.net' }
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify

  config.middleware.use ExceptionNotifier, sender_address: 'nick.desteffen@gmail.com', exception_recipients: 'nick.desteffen@gmail.com'  
end
