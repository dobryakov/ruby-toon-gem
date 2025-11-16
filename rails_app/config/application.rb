require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups) if defined?(Bundler)

module RailsApp
  class Application < Rails::Application
    config.load_defaults 7.1
  end
end


