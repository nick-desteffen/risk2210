Risk2210::Application.configure do
  config.cache_classes = true
  config.eager_load = false
  config.assets.digest = false
  config.serve_static_files = true
  config.static_cache_control = "public, max-age=3600"
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection    = false
  config.action_mailer.delivery_method = :test
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.active_support.deprecation = :stderr
  config.password_cost = BCrypt::Engine::MIN_COST
end
