FactoryBot.define do
  factory :email do
    email { Faker::Internet.email }
    comment { Faker::Quote.jack_handey }
    association :person, factory: :person
  end
end