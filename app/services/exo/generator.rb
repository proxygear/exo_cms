require 'yaml'

class Exo::Generator
  APP_FOLDER_EXCLUDED = ['assets', 'helpers']

  attr_accessor :slug, :options

  def initialize slug, options=nil
    self.slug = slug
    self.options = options || {}
  end

  def generates_config
    exo_config_path = File.join root_path, 'config', 'exo', "#{slug}.yml"

    dir = File.dirname exo_config_path
    FileUtils.mkdir_p dir unless File.directory? dir
    unless File.exists?(exo_config_path)
      puts " + #{exo_config_path}"
      yaml = {
        'theme'         => slug,
        'main_host'     => "#{slug}.com",
        'hosts'         => nil,
        'contributors'  => nil,
        'resources'     => nil,
        'routes'        => nil
      }.to_yaml
      File.open(exo_config_path, 'w') {|f| f.write yaml }
    end
  end

  def generates_folders
    app_folder = File.join root_path, 'app'

    generates_slug_subfolder_of app_folder
    generates_slug_subfolder_of File.join app_folder, 'assets'
  end

  protected
  def generates_slug_subfolder_of folder_path
    Dir[File.join(folder_path, '**')].each do |sub_path|
      item_name = sub_path.split('/').last

      next if item_name == '.' or item_name == '..'
      next unless File.directory? sub_path
      next if APP_FOLDER_EXCLUDED.include? item_name
      
      slug_path = File.join sub_path, slug
      next if File.exists?(slug_path)
      puts " + #{slug_path}"

      FileUtils.mkdir slug_path
    end
  end

  def root_path
    @root_path ||= Rails.root
  end
end