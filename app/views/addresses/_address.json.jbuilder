# frozen_string_literal: true

json.extract!(address, :id, :street, :town, :zip_code, :state, :country, :person_id, :created_at, :updated_at)
json.url(address_url(address, format: :json))
