require 'tsort'

class Updater
  module Js
    def update_javascript_assets
      log_status 'Updating javascripts...'
      save_to = @save_to[:js]
      read_files('js/dist', melodic_js_files).each do |name, content|
        save_file("#{save_to}/#{name}", remove_source_mapping_url(content))
      end
      log_processed((melodic_js_files * ' ').to_s)

      log_status 'Updating javascript manifest'
      manifest = ''
      melodic_js_files.each do |name|
        name = name.gsub(/\.js$/, '')
        manifest << "//= require ./melodic/#{name}\n"
      end
      dist_js = read_files('dist/js', %w[melodic.js melodic.min.js])
      {
        'assets/javascripts/melodic-sprockets.js' => manifest,
        'assets/javascripts/melodic.js' => dist_js['melodic.js'],
        'assets/javascripts/melodic.min.js' => dist_js['melodic.min.js']
      }.each do |path, content|
        save_file path, remove_source_mapping_url(content)
        log_processed path
      end
    end

    def melodic_js_files
      @melodic_js_files ||= begin
        src_files = get_paths_by_type('js/src', /\.js$/) - %w[index.js]
        imports = Deps.new
        # Get the imports from the ES6 files to order requires correctly.
        read_files('js/src', src_files).each do |name, content|
          imports.add(name, *content.scan(%r{import [a-zA-Z]* from '\./(\w+)}).flatten(1).map { |f| "#{f}.js" })
        end
        imports.tsort
      end
    end

    def remove_source_mapping_url(content)
      content.sub(%r{^//# sourceMappingURL=.*\n?\z}, '')
    end

    class Deps
      include TSort

      def initialize
        @imports = {}
      end

      def add(from, *tos)
        (@imports[from] ||= []).push(*tos.sort)
      end

      def tsort_each_child(node, &block)
        @imports[node].each(&block)
      end

      def tsort_each_node(&block)
        @imports.each_key(&block)
      end
    end
  end
end
