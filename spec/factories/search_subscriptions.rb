# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search_subscription do
    query "MyString"
    email "MyString"
  end
end
