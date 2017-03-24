FactoryGirl.define do
  factory :attachment do
    file { File.new(File.join(Rails.root, 'spec', 'files', '1.txt')) }
    task

    factory :image do
      file { File.new(File.join(Rails.root, 'spec', 'files', '1.jpg')) }
    end
  end
end
