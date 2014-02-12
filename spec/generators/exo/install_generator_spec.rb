describe 'exo:install' do
  let(:route_indentation) { "\n  "}
  let(:generators_path) { File.join ENGINE_RAILS_ROOT, 'lib', 'generators', 'exo'}
  within_source_root do
    FileUtils.touch 'Gemfile'
    FileUtils.mkdir_p "config"
    File.open('config/routes.rb', 'w') do |destination|
      File.open(File.join(SPEC_TEMPLATES_PATH, 'fake_routes.rb'), 'r') do |source|
        destination.write source
      end
    end
    FileUtils.mkdir_p "config/initializers"
  end

  it 'add exo_cms to Gemfile' do
    gems_path = File.join generators_path, 'templates', 'gems.rb'
    
    File.open(gems_path, 'r') do |f|
      subject.should append_file('Gemfile', f.read.to_s)
    end
  end

  it 'generates exo initializer' do
    subject.should generate('config/initializers/exo.rb')
  end

  it 'append engine mounting on "/" to config/routes.rb' do
    engine_route_path = File.join generators_path, 'templates', 'engine_routes.rb'

    mounting = ''
    File.open(engine_route_path, 'r') {|f| mounting = f.read }
    
    subject.should inject_into_file 'config/routes.rb', (route_indentation + mounting)
    
    within_source_root do
      File.open(File.join('config', 'routes.rb'), 'r') do |routes|
        routes.read.should match /draw do.*#previous stuff.*#{mounting}.*end/
      end
    end
  end
end