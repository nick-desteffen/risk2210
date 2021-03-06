Risk2210::Application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.log_level = :info

  config.serve_static_files = false

  config.assets.compress = true
  config.assets.digest = true
  config.assets.compile = false
  config.assets.js_compressor = :uglifier

  config.action_mailer.default_url_options = { host: Rails.application.secrets.email['domain'] }
  config.action_mailer.perform_deliveries = true
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new

  config.middleware.use ExceptionNotification::Rack, email: {
    sender_address:       Rails.application.secrets.exception_notifier['sender'],
    exception_recipients: Rails.application.secrets.exception_notifier['recipients']
  }

end
