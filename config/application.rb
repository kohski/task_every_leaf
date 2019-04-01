require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module TaskEveryLeaf
  class Application < Rails::Application
    config.load_defaults 5.2
    # config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'
    config.generators do |g|
      g.assets false
      # g.helper false
      g.jbuilder false
    end
    config.assets.initialize_on_precompile = false
  end
end
