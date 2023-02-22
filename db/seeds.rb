# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

homer = User.create!(email: 'homer@simpsons.com', role: 'Admin', password: '123456789')
marge = User.create!(email: 'marge@simpsons.com', role: 'Guest', password: '123456789'.reverse)

10.times do
  person = Person.create!(
    salutation: ['Mr.', 'Ms.', 'Mrs.'].sample,
    first_name: Faker::Name.first_name,
    middle_name: Faker::Name.middle_name,
    last_name: Faker::Name.last_name,
    birth_date: '2023-02-16',
    ssn: Faker::Number.number(digits: 9),
    comment: Faker::Quote.famous_last_words,
    user: homer
  )

  2.times do
    address = Address.new(
      street: Faker::Address.street_address,
      town: Faker::Address.city_prefix,
      zip_code: Faker::Number.number(digits: 5).to_s,
      state: Faker::Address.state,
      country: %w[USA Canada Mexico France Germany].sample,
      person: person
    )

    email = Email.new(
      email: Faker::Internet.email,
      comment: Faker::Quote.jack_handey,
      person: person
    )

    phone_number = PhoneNumber.new(
      number: Faker::PhoneNumber.phone_number,
      comment: Faker::Quote.robin,
      person: person
    )

    address.save!
    email.save!
    phone_number.save!
  end
end
