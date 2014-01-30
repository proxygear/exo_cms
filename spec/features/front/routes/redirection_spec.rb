describe 'Front route redirection' do
  let(:site) { create :site }
  let(:redirection_url) { "#{site.url}/test" }

  let(:route_redirection) do
    build(:route_redirection, to_url: redirection_url).tap do |r|
      r.site = site
      r.save!
    end
  end

  before(:each) { visit route_redirection.url }

  subject { page }

  its(:status_code) { should == 404 }
  it { should have_selector('#unknow_path') }
  it { current_url.should == route_redirection.to_url }
end