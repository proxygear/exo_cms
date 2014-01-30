require 'faker'

FactoryGirl.define do
  factory :contributor, class: Exo::Contributor do
    sequence(:email) {|n| Faker::Internet.email }
    sequence(:password) {|n| Faker::Lorem.characters 10 }
  end
end
