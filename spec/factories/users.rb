# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    nutzungsbedingung true
  end
end
