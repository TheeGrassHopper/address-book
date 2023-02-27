# frozen_string_literal: true

module SessionHelper
  def login_user(user)
    post(login_path, params: { email: user.email, password: user.password, role: user.role })
  end
end

RSpec.configure do |config|
  config.include(SessionHelper, type: :request)
end
