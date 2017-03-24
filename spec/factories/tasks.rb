FactoryGirl.define do
  factory :task do
    sequence(:name) { |i| "Task #{i}" }
    description Faker::Lorem.paragraph
    user

    factory :with_attachment do
      after :create do |task, evaluator|
        FactoryGirl.create_list(:attachment, evaluator.count_attachments, task_id: task.id)
      end
    end
  end
end
