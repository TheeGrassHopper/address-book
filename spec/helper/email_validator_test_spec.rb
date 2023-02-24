# frozen_string_literal: true

require 'spec_helper'

class EmailValidatorTest < ActiveSupport::TestCase
  test 'valid email address' do
    validator = EmailValidator.new
    record = Object.new
    record.errors[:email] = []
    validator.validate_each(record, :email, 'test@example.com')
    assert_empty record.errors[:email]
  end

  test 'invalid email address' do
    validator = EmailValidator.new
    record = Object.new
    record.errors[:email] = []
    validator.validate_each(record, :email, 'test@example')
    assert_equal 'is not a valid email address', record.errors[:email].first
  end

  test 'invalid email address with special characters' do
    validator = EmailValidator.new
    record = Object.new
    record.errors[:email] = []
    validator.validate_each(record, :email, 'test@example.com!')
    assert_equal 'is not a valid email address', record.errors[:email].first
  end

  test 'invalid email address with spaces' do
    validator = EmailValidator.new
    record = Object.new
    record.errors[:email] = []
    validator.validate_each(record, :email, 'test @example.com')
    assert_equal 'is not a valid email address', record.errors[:email].first
  end
end
