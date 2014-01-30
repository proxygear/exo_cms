require 'faker'

FactoryGirl.define do
  factory :route_redirection, class: Exo::Route::Redirection do
    sequence(:slug_id)    {|n| Faker::Lorem.characters(10) }
    sequence(:path)       {|n| "/" + Faker::Lorem.characters(10).to_s }
    sequence(:to_url)    {|n| Faker::Internet.url }
  end
end


FactoryGirl.define do
  factory :route_page, class: Exo::Route::Page do
    sequence(:slug_id)    {|n| Faker::Lorem.characters(10) }
    sequence(:path)       {|n| "/" + Faker::Lorem.characters(10).to_s }
    sequence(:view_path)    {|n| "/" + Faker::Lorem.characters(10).to_s }
  end
end
