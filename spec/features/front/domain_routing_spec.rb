describe 'Front domain routing' do
  let(:request_host)  { Faker::Internet.domain_name }
  let(:another_host)  { Faker::Internet.domain_name }
  
  let(:request_url) { "http://#{request_host}/some_path" }

  let(:config) { nil } #nothing to do

  before(:each) { config; visit request_url }

  subject { page }

  describe 'on an unregistred domain' do
    its(:status_code) { should == 503 }
    it { should have_selector('#unknow_host') }
    it { current_url.should == request_url }
  end

  describe 'on a main host domain' do
    let(:config)    { create :site, main_host: request_host, hosts: [another_host] }

    its(:status_code) { should == 404 }
    it { should have_selector('#unknow_path') }
    it { current_url.should == request_url }
  end

  context 'on a secondary host domain' do
    let(:config)    { create :site, main_host: another_host, hosts: [request_host] }

    its(:status_code) { should == 404 }
    it { should have_selector('#unknow_path') }
    it { current_url.should ==  "http://#{another_host}/some_path" }
  end
end