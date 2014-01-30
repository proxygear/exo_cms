FactoryGirl.define do
  factory :service, class: Exo::Service do
    sequence(:name) {|n| Faker::Lorem.characters(10) }
    sequence(:path) {|n| '/'+Faker::Lorem.characters(10) }
  end
end