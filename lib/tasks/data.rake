desc 'fake data'
task data: :environment do
  10.times do
    user = User.create(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
    10.times do
      Task.create(name: Faker::Lorem.word, description: Faker::Lorem.paragraph, user: user)
      print "*"
    end
    puts ""
  end
end
