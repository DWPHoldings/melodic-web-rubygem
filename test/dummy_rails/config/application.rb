require File.expand_path('boot', __dir__)

require 'rails'

%w[
  action_controller
  action_view
  sprockets
].each do |framework|
  require "#{framework}/railtie"
end

require 'autoprefixer-rails'
require 'slim-rails'
require 'uglifier'

require 'melodic'
require 'jquery-rails'

module Dummy
  class Application < Rails::Application
    config.assets.enabled = true if config.assets.respond_to?(:enabled)
    if Rails::VERSION::MAJOR > 4
      # Rails 4 precompiles application.css|js by default, but future version of Rails do not.
      config.assets.precompile += %w[application.css application.js]
    end
    config.to_prepare do
      if ENV['VERBOSE']
        Kernel.warn "Loaded Rails #{Rails::VERSION::STRING}, Sprockets #{Sprockets::VERSION}",
          "Asset paths: #{Rails.application.config.assets.paths}"
      end
    end
  end
end
