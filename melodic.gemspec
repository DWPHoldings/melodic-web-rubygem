lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'melodic/version'

Gem::Specification.new do |s|
  s.name     = 'melodic'
  s.version  = Melodic::VERSION
  s.authors  = ['Twitter, Inc.',
                'Mark Otto, Jacob Thornton, and Bootstrap contributors',
                'The Avengers of Inspire']
  s.email    = 'technology@helloinspire.com'
  s.summary  = "Inspire's front-end design system for the Web, packaged as a Gem."
  s.homepage = 'https://melodic.helloinspire.com'
  s.license  = 'MIT'

  s.add_runtime_dependency 'popper_js', '>= 1.12.9', '< 2'

  s.add_runtime_dependency 'autoprefixer-rails', '>= 6.0.3'
  s.add_runtime_dependency 'sass', '>= 3.5.2'

  # Testing dependencies
  s.add_development_dependency 'minitest', '~> 5.8.0'
  s.add_development_dependency 'minitest-reporters', '~> 1.0.5'
  s.add_development_dependency 'term-ansicolor'
  # Integration testing
  s.add_development_dependency 'capybara', '>= 2.6.0'
  s.add_development_dependency 'poltergeist'
  # Style checking
  s.add_development_dependency 'rubocop', '~> 0.81'
  # Dummy Rails app dependencies
  s.add_development_dependency 'actionpack', '~> 5.2'
  s.add_development_dependency 'activesupport', '~> 5.2'
  s.add_development_dependency 'jquery-rails', '>= 3.1.0'
  s.add_development_dependency 'json', '>= 1.8.1'
  s.add_development_dependency 'slim-rails'
  s.add_development_dependency 'sprockets-rails', '>= 2.3.2'
  s.add_development_dependency 'uglifier'

  s.files      = %x(git ls-files).split("\n")
  s.test_files = %x(git ls-files -- test/*).split("\n")
end
