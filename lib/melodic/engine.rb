require 'autoprefixer-rails'

module Melodic
  module Rails
    class Engine < ::Rails::Engine
      initializer 'melodic.assets' do |app|
        %w[fonts stylesheets javascripts].each do |sub|
          app.config.assets.paths << root.join('assets', sub).to_s
        end
      end
    end
  end
end
