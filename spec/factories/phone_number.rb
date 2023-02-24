# frozen_string_literal: true

FactoryBot.define do
  factory :phone_number do
    number { Faker::PhoneNumber.phone_number }
    comment { Faker::Quote.robin }
    association :person, factory: :person
  end
end
