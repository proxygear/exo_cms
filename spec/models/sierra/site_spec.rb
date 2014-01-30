# describe Exo::Site do
#   subject(:site) { create :site }
# 
#   it 'has many contributors'
#   it 'validates name uniqueness'
#   it 'validates main_host uniqueness'
#   it 'validates each hosts uniqueness'
#   it 'validates hosts and main_hosts format'
# 
#   # it_behaves_like 'slug_model' do
#   #   its :slug_id_source, 'alias name'
#   # end
# 
#   describe '.scoping a model' do
#     subject(:scope) { site.scoping(Exo::Resource::Item) }
#     it 'set site_slug_id constraint'
#   end
# 
#   # its :to_url, 'returns main_host with http protocole'
#   # its :join_file, 'return a path under slug_id/'
# 
#   describe '.get_resource' do
#     context 'given an unmatching slug_id' do
#       it 'raises an Exception'
#     end
#     context 'given a matching slug_id' do
#       it 'returns the Exo::Resource'
#     end
#   end
# 
#   it 'embeds many routes'
#   it "validates routes' path uniqueness"
#   it 'embeds many resources'
#   it "validates routes' slug_id uniqueness"
#   it 'embeds many settings'
#   it "validates settings' slug_id uniqueness"
# end