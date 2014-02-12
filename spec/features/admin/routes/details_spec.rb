describe 'Admin route details' do
  let(:site) { create :site }
  logged_contributor! do |c|
    c.sites = [site]
    c.save
  end

  # it_behaves_like "paginated table" do
  #   let(:create_unic_item) do
  #     lambda {
  #     
  #     }
  #   end
  # 
  #   before(:each) do
  #     
  #   end
  # end
  # 
  # describe 'table line' do
  #   before(:each) do
  #   end
  # end
end
