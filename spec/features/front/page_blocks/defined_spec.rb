describe 'Front page with defined block' do
  let(:site) { create :site, theme_path: 'a_exo_theme' }

  let(:route_page) do
    build(:route_page, view_path: '/a_page_with_block').tap do |p|
      p.site = site
      p.save!
    end
  end

  let(:page_block) do
    build(
      :block,
      slug_id: 'page_block',
      content: '<div id="replaced_content">Block content</div>'
    ).tap do |b|
      b.page = route_page
      b.save!
    end
  end

  before(:each) { page_block; visit route_page.url }

  subject { page }

  its(:status_code) { should == 200 }
  it { should have_selector('#a_page') }
  it { should have_selector('#page_block.some_class #replaced_content') }
  it { current_url.should == route_page.url }
end