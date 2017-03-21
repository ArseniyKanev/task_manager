FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "test#{i}@mail.com" }
    password 'password'
    password_confirmation 'password'
  end
end
