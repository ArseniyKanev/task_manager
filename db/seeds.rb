user = User.create(email: 'user@mail.ru', password: 'password', password_confirmation: 'password')
User.create(email: 'admin@mail.ru', password: 'password', password_confirmation: 'password', role: "admin")

10.times do
  Task.create(name: Faker::Lorem.word, description: Faker::Lorem.paragraph, user: user)
end
