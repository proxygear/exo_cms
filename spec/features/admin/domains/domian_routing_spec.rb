describe 'Admin domain routing' do
  let(:request_host)  { Faker::Internet.domain_name }
  let(:another_host)  { Faker::Internet.domain_name }
  
  let(:admin_url) { "http://#{request_host}/admin" }

  let(:config) { nil } #nothing to do

  before(:each) { config; visit admin_url }

  subject { page }

  describe 'on an unregistred domain' do
    its(:status_code) { should == 503 }
    it { should have_selector('#unknow_host') }
    it { current_url.should == "http://#{request_host}/admin" }
  end

  describe 'on a main host domain' do
    let(:config)    { create :site, main_host: request_host, hosts: [another_host] }

    its(:status_code) { should == 200 }
    it { should have_selector('form#new_contributor') }
    it { current_url.should == "http://#{request_host}/admin/sign_in" }
  end

  context 'on a secondary host domain' do
    let(:config)    { create :site, main_host: another_host, hosts: [request_host] }

    its(:status_code) { should == 200 }
    it { should have_selector('form#new_contributor') }
    it { current_url.should ==  "http://#{another_host}/admin/sign_in" }
  end
end