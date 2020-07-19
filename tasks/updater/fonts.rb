class Updater
  module Fonts
    def update_font_assets
      log_status 'Updating font assets...'
      save_to = @save_to[:fonts]
      contents = {}
      melodic_font_files = get_paths_by_type('assets/fonts', /\.(eot|woff|woff2)$/)
      read_files('assets/fonts', melodic_font_files).each do |name, file|
        contents[name] = file
        save_file("#{save_to}/#{name}", file)
      end
      log_processed((melodic_font_files * ' ').to_s)
    end
  end
end
