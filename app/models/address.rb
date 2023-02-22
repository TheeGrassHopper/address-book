# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :person

  validates :town, :zip_code, :street, presence: true
  validates :country, inclusion: { in: %w[USA Canada Mexico France Germany] }
  validates :zip_code, length: { maximum: 5 }
end
