# frozen_string_literal: true

class Email < ApplicationRecord
  belongs_to :person

  validates :email, presence: true, email: true
end
