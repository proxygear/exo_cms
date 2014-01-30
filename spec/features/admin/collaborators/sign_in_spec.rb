describe 'Admin sign in' do
  let(:password) { Faker::Lorem.characters 10 }
  let(:contributor) { create :contributor, password: password }
  let(:site) { create :site, contributor_ids: [contributor.id.to_s] }
  
  before(:each) do
    visit site.url('/admin/sign_in')
    fill_in 'contributor_email', :with => contributor.email
    fill_in 'contributor_password', :with => password
    click_button 'Sign in'
  end

  subject { page }

  its(:status_code) { should == 200 }
  it { current_url.should == site.url('/admin') }
end