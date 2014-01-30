describe 'Admin custom sidebar services' do
  let(:site) { create :site }
  
  logged_contributor! do |c|
    c.sites.push site
    c.save
  end

  before(:each) do
    #Setup Exo and Site services
    Exo.config do |s|
      s.register_services('A' => '/a', 'B' => '/b')
    end

    create :service, site: site, name: 'B', path: '/overrided'
    create :service, site: site, name: 'C', path: '/c'

    #Add model

    visit site.url('/admin')
  end

  it 'contains services with site overriding app config' do
    current_path.should == '/admin'
    {'A' => '/a', 'B' => '/b', 'C' => '/c'}.each do |name, path|
      find("a[@href='#{path}'] span").text == name
    end
  end
end