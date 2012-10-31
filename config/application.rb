require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
require 'bcrypt'

if defined?(Bundler)
  Bundler.require(*Rails.groups(assets: %w(development test)))
end

module Risk2210
  class Application < Rails::Application
    config.autoload_paths += %W(#{Rails.root}/lib)

    config.after_initialize do
      Dir.glob("#{Rails.root}/app/extensions/**/*.rb").each { |extension| require extension }
    end

    config.encoding = "utf-8"
    config.filter_parameters += [:password]

    config.assets.enabled = true
    config.assets.version = '1.0'

    config.generators do |generator|
      generator.test_framework :rspec, fixture: false
      generator.stylesheets false
      generator.javascripts false
      generator.helper      false
    end

    ActionMailer::Base.prepend_view_path "#{Rails.root}/app/mailer_views"
    ActionMailer::Base.smtp_settings = {
      address:        "smtp.sendgrid.net",
      port:           "25",
      authentication: :plain,
      user_name:      ENV['SENDGRID_USERNAME'],
      password:       ENV['SENDGRID_PASSWORD'],
      domain:         ENV['SENDGRID_DOMAIN']
    }

    config.password_cost = BCrypt::Engine::DEFAULT_COST

  end
end
