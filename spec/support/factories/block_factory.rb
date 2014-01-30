require 'faker'

FactoryGirl.define do
  factory :block, class: Exo::Block do
    sequence(:slug_id) {|n| Faker::Lorem.characters(10) }
    sequence(:content) do |n|
      "<div class='replaced_content'>" + Faker::Lorem.characters(10).to_s + "</div>"
    end
  end
end