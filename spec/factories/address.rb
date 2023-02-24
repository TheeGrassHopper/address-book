# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    street { Faker::Address.street_address }
    town { Faker::Address.city_prefix }
    zip_code { Faker::Number.number(digits: 5).to_s }
    state { Faker::Address.state }
    country { %w[USA Canada Mexico France Germany].sample }
    association :person, factory: :person
  end
end
