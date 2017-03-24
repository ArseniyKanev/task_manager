FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "test#{i}@mail.com" }
    password 'password'
    password_confirmation 'password'

    factory :admin do
      role :admin
    end
  end
end
