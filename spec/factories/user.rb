# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email { 'homer@simpsons.com' }
    role { 'Admin' }
    password { '123456789' }
  end
end
