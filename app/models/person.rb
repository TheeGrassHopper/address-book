# frozen_string_literal: true

class Person < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy
  has_many :emails, dependent: :destroy
  belongs_to :user

  validates :first_name, :last_name, presence: true
  validates :ssn, uniqueness: { on: %i[create update], message: 'must be unique' }, length: { maximum: 9 }
  validates :salutation, inclusion: { in: ['Mr.', 'Ms.', 'Mrs.'] }

  accepts_nested_attributes_for :addresses, :phone_numbers, :emails
end
