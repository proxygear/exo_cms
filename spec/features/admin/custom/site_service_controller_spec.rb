describe 'Admin custom site service controller' do
  logged_contributor! do |c|
    c.sites.push site
    c.save
  end

  let(:service_site) { create :site, slug_id: 'a_site_slug_id'}

  before(:each) do
    create :service, site: service_site, name: 'SiteCustom', path: '/admin/site_customs'
    visit site.url('/admin')
  end

  subject { page }

  context 'matching slug_id' do
    let(:site) { service_site }

    it 'grant access to customs' do
      find("a[@alt='SiteCustom']").click
      current_path.should == '/admin/site_customs'
      should have_css('h1#site_customs')
    end
  end

  context 'not matching slug_id' do
    let(:site) { create :site }

    it { should_not have_css("a[@alt='SiteCustom']") }

    describe 'forced url' do
      before(:each) { visit site.url('/admin/site_customs') }
      its(:status_code) { should == 200 }
      it { current_url.should == site.url('/admin') }
    end
  end
end