require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Lists
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(
      #{config.root}/app/controllers/physical
      #{config.root}/app/controllers/physical/admin
      #{config.root}/app/controllers/service
      #{config.root}/app/helpers/physical
      #{config.root}/app/models/physical
      #{config.root}/app/models/logical
      #{config.root}/app/models/utility
      #{config.root}/app/models/physical/admins
      #{config.root}/app/models/physical/users
      #{config.root}/app/models/physical/businesses
      #{config.root}/app/models/physical/lists
      #{config.root}/app/models/physical/geo
      #{config.root}/app/models/physical/campaigns
    )

    # handle situation where certain gems make AppConf load too late
    if defined?(AppConf).nil?
      require "#{Rails.root.to_s}/vendor/plugins/app_config/init.rb"
    end

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = ::AppConf.server_time_zone
    Time.zone = ::AppConf.server_time_zone

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.action_view.javascript_expansions[:prototype] = %w(prototype effects controls dragdrop cropper)
    config.action_view.javascript_expansions[:jquery] = %w(jquery rails-jquery)
    # JavaScript files you want as :defaults (application.js is always included).
    config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.autoload_paths << Rails.root.join("app", "validation")
  end
  # reload!;ActiveRecord::Base.logger = Logger.new(STDOUT);ActionController::Base.logger = Logger.new(STDOUT);
end

