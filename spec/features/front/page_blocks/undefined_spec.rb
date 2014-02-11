describe 'Front page with undefined block' do
  let(:site) { create :site, theme_path: TEST_THEME }

  let(:route_page) do
    build(:route_page, view_path: '/a_page_with_block').tap do |p|
      p.site = site
      p.save!
    end
  end

  before(:each) { visit route_page.url }

  subject { page }

  its(:status_code) { should == 200 }
  it { should have_selector('#a_page') }
  it { should have_selector('#page_block.some_class #default_content') }
  it { current_url.should == route_page.url }
end