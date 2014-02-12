describe 'Front route page' do
  let(:site) { create :site, theme_path: TEST_THEME }

  let(:route_page) do
    build(:route_page, view_path: '/a_page').tap do |p|
      p.site = site
      p.save!
    end
  end

  before(:each) { visit route_page.url }

  subject { page }

  its(:status_code) { should == 200 }
  it { should have_selector('#a_page') }
  it { current_url.should == route_page.url }
end