# frozen_string_literal: true

class PhoneNumber < ApplicationRecord
  belongs_to :person

  validates :number, presence: true
end
