require 'faker'

FactoryGirl.define do
  factory :site, class: Exo::Site do
    sequence(:slug_id) {|n| Faker::Lorem.characters(10) }
    sequence(:main_host) {|n| Faker::Internet.domain_name }
    theme_path 'test'
  end
end
