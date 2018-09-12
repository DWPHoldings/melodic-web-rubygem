lib_path = File.join(File.dirname(__FILE__), 'lib')
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)

require 'English'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = false
  t.warning = false
end

desc 'Test all Gemfiles from test/*.gemfile'
task :test_all_gemfiles do
  require 'term/ansicolor'
  require 'pty'
  require 'shellwords'
  cmd      = 'bundle install --quiet && bundle exec rake --trace'
  statuses = Dir.glob('./test/gemfiles/*{[!.lock]}').map do |gemfile|
    env = {'BUNDLE_GEMFILE': gemfile}
    cmd_with_env = "  (#{env.map { |k, v| "export #{k}=#{Shellwords.escape v}" } * ' '}; #{cmd})"
    warn Term::ANSIColor.cyan("Testing\n#{cmd_with_env}")
    Bundler.with_clean_env do
      PTY.spawn(env, cmd) do |r, _w, pid|
        begin
          r.each_line { |l| puts l }
        rescue Errno::EIO
          # Errno:EIO error means that the process has finished giving output.
        ensure
          ::Process.wait pid
        end
      end
    end
    [$CHILD_STATUS.exitstatus&.zero?, cmd_with_env]
  end
  failed_cmds = statuses.reject(&:first).map { |(_status, cmd_with_env)| cmd_with_env }
  if failed_cmds.empty?
    warn Term::ANSIColor.green('Tests pass with all gemfiles')
  else
    warn Term::ANSIColor.red("Failing (#{failed_cmds.size} / #{statuses.size})\n#{failed_cmds * "\n"}")
    exit 1
  end
end

desc 'Dumps output to a CSS file for testing'
task :debug do
  require 'sass'
  require './lib/melodic'
  require 'term/ansicolor'
  require 'autoprefixer-rails'
  path = Melodic.stylesheets_path
  %w[_melodic _melodic-reboot _melodic-grid].each do |file|
    engine = Sass::Engine.for_file("#{path}/#{file}.scss", syntax: :scss, load_paths: [path])
    out = File.join('tmp', "#{file[1..-1]}.css")
    css = engine.render
    css = AutoprefixerRails.process(css)
    File.write(out, css)
    warn Term::ANSIColor.green "Compiled #{out}"
  end
end

desc 'Update melodic from upstream'
task :update, :branch do |_t, args|
  require './tasks/updater'
  Updater.new(branch: args[:branch]).update_melodic
end

desc 'Start a dummy Rails app server'
task :rails_server do
  require 'rack'
  require 'term/ansicolor'
  port = ENV['PORT'] || 9002
  puts %(Starting on #{Term::ANSIColor.cyan "http://localhost:#{port}"})
  Rack::Server.start(config: 'test/dummy_rails/config.ru', Port: port)
end

task default: :test
