# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :neuigkeiten do
    title "MyString"
    content "MyText"
    user_id 1
    datum "2013-07-01 16:45:16"
  end
end
