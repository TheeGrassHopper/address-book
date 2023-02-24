# frozen_string_literal: true

json.extract!(person, :id, :salutation, :first_name, :middle_name, :last_name, :ssn, :birth_date, :comment, :created_at, :updated_at)

json.emails(person.emails) do |email|
  json.extract!(email, :id, :email, :comment)
end

json.phone_numbers(person.phone_numbers) do |phone_number|
  json.extract!(phone_number, :id, :number, :comment)
end

json.addresses(person.addresses) do |address|
  json.extract!(address, :id, :street, :town, :zip_code, :state, :country)
end

json.url(person_url(person, format: :json))
