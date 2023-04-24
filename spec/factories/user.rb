FactoryBot.define do
    factory :user do
      email { "andrei@gmail.com" }
      password { 'password' }
      role { association(:role) }
    end
  end