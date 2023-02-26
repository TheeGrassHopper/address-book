# frozen_string_literal: true

class User < ApplicationRecord
  # include BCrypt
  has_secure_password

  has_many :people, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  # def password
  #   @password ||= Password.new(password_digest)
  # end

  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   self.password_digest = @password
  # end

  # def authenticate(password)
  #   self.password == password
  # end
end
