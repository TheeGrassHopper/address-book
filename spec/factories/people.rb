# frozen_string_literal: true

FactoryBot.define do
  factory :person do
    salutation { ['Mr.', 'Ms.', 'Mrs.'].sample }
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.middle_name }
    last_name { Faker::Name.last_name }
    birth_date { '2023-02-16' }
    ssn { Faker::Number.number(digits: 9) }
    comment { Faker::Quote.famous_last_words }
    association :user, factory: :user
  end
end
