require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rubyquest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  
    config.autoload_paths += %W(#{config.root}/lib)


    #config.api_only = true
    #config.middleware.use ActionDispatch::Cookies
    #config.middleware.use ActionDispatch::Session::CookieStore, key: '_coookie_name', expire_after: 30.days
  end
end

# これは要る
module RedisRailsSample
  class Application < Rails::Application
    # ...

    # これを追記
    config.cache_store = :redis_store, "redis://localhost:6379/0/cache", { expires_in: 90.minutes }
  end
end

