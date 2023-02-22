# frozen_string_literal: true

json.extract!(email, :id, :email, :comment, :person_id, :created_at, :updated_at)
json.url(email_url(email, format: :json))
