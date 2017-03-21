FactoryGirl.define do
  factory :task do
    sequence(:name) { |i| "Task #{i}" }
    description Faker::Lorem.paragraph
    user
  end
end
