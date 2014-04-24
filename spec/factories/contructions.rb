FactoryGirl.define do
  factory :construction do
    title     { Faker::Lorem.words.join ' ' }
    content   { Faker::Lorem.sentences.join ' ' }
  end
end
