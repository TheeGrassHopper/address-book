# frozen_string_literal: true

json.extract!(phone_number, :id, :number, :comment, :person_id, :created_at, :updated_at)
json.url(phone_number_url(phone_number, format: :json))
