# Help to generate views
# * application layout
# * route page views
module Exo::ViewGenerator
  def self.ensure_page_view page, &content_delegate
    file_path = join_views_path page.site.theme_path, "#{page.view_path}.html.haml"

    ensure_folder_chain file_path
    
    file_path = nil if File.exists? file_path

    if file_path
      content = nil
      if content_delegate
        content = content_delegate.call
      else
        content = template_content 'page.html.haml'
        content = content.gsub 'SLUG_ID', page.slug_id if content
      end
      File.open(file_path, 'w') {|f| f.write content}
    end
    file_path
  end
  
  def self.ensure_site_layout site, &content_delegate
    folder_path = join_views_path 'layouts', site.theme_path
    Dir.mkdir folder_path unless File.exists? folder_path

    file_path = File.join folder_path, "application.html.haml"

    file_path = nil if File.exists? file_path

    if file_path
      content = nil
      if content_delegate
        content = content_delegate.call
      else
        content = template_content 'application.html.haml'
      end
      File.open(file_path, 'w') {|f| f.write content}
    end
    file_path
  end

  protected
  def self.template_content *path
    exo_gem_root = Gem::Specification.find_by_name('exo_cms').gem_dir
    
    path = File.join([exo_gem_root, 'app', 'resources', 'templates'] + path)
    content = nil
    
    if File.exists? path
      File.open(path, 'r') do |f|
        content = f.read
      end
    end
    content
  end

  def self.ensure_folder_chain path
    current_path = File.join Rails.root, 'app', 'views'
    folders = path[current_path.to_s.size..-1].split(File::SEPARATOR)[0..-2]
    folders.each do |folder|
      current_path = File.join current_path, folder
      unless File.exists? current_path
        Dir.mkdir current_path
      end
    end
  end

  def self.join_views_path *path
    File.join([Rails.root, 'app', 'views'] + path)
  end
end