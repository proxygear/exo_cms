class CkeditorRailser
  RAILS_STRUCTURE = {
    rails_assets: {
      javascripts: /\.js\z/,
      stylesheets: /\.css\z/,
      images: /\.(png|jpg|jpeg)\z/,
      otheres: nil
    }
  }

  attr_accessor :base_path, :actions

  def process path=nil
    self.base_path = path || '.'
    raise "base path #{base_path} does not exist" unless Pathname.new(base_path).exist?
    init_structure
    railsing!
  end

  protected
  def init_structure
    puts " ! Init structure"
    rails_assets_path = File.join base_path, 'rails_assets'
    if Pathname.new(rails_assets_path).exist?
      puts " - #{rails_assets_path}/*"
      FileUtils.rm_rf rails_assets_path
    end
    self.actions = {}
    init_recursivly base_path, RAILS_STRUCTURE do |path, action|
      self.actions[action] = path
    end
  end

  def init_recursivly path, structure_hash, &register
    structure_hash.each do |_folder, action|
      folder = _folder.to_s
      folder_path = File.join(path, folder)
      puts " + #{folder_path}"
      Dir.mkdir folder_path
      if action.kind_of?(Hash)
        init_recursivly folder_path, action, &register
      else
        puts " > #{action} -> #{_folder}"
        register.call folder_path, action
      end
    end
  end

  def railsing!
    puts " ! Railsing"
    Dir[File.join(base_path, '**', '*')].each do |path|
      next if Pathname.new(path).directory?
      actions.each do |regexp, group_path|
        next unless regexp =~ path
        copy_file path, group_path
        break
      end
    end
  end

  def copy_file file_path, group_path
    rel_path = file_path[base_path.size..-1]
    folder_destination = group_path
    rel_path.split('/')[0..-2].each do |folder|
      folder_destination = File.join folder_destination, folder
      next if Pathname.new(folder_destination).exist?
      puts " + #{folder_destination} f"
      Dir.mkdir folder_destination
    end
    destination_path = File.join group_path, rel_path
    puts " + #{destination_path}"
    File.open(file_path, 'r') do |source|
      File.open(destination_path, 'w') do |destination|
        destination.write source.read
      end
    end
  end
end