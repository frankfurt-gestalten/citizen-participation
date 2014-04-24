# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :antraege do
    last_updated { Time.now }
    link "http://example.com"
    verfasser "CDU"
    sequence(:docid) { |n| "OF-121-#{n}" }
    title "Title"
    kommune "MyText"
    federfuehrend "MyText"
  end
end
