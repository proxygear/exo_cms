describe 'Admin custom global service controller' do
  let(:site) { create :site }

  logged_contributor! do |c|
    c.sites.push site
    c.save
  end

  before(:each) do
    Exo.config do |s|
      s.register_services('Custom' => '/admin/customs')
    end

    visit site.url('/admin')
  end

  it 'grant access to customs' do
    find("a[@alt='Custom']").click
    current_path.should == '/admin/customs'
    page.should have_css('h1#customs_index')
  end
end