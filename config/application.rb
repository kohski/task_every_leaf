require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module TaskEveryLeaf
  class Application < Rails::Application
    config.load_defaults 5.2
    config.time_zone = 'Tokyo'
    config.generators do |g|
      g.assets false
      # g.helper false
      g.jbuilder false
      g.test_framework :rspec,
      view_specs: false,
      helper_specs: false,
      routing_specs: false,
      controller_specs: false,
      request_specs: false
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end
    config.assets.initialize_on_precompile = false
  end
end
