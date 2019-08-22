User.create!(name:  "Example Admin",
             email: "example@gmail.com",
             password:              "adminuser",
             password_confirmation: "adminuser",
             admin: true)

User.create!(name:  "Another Admin",
             email: "sample@gmail.com",
             password:              "sampleadmin",
             password_confirmation: "sampleadmin",
             admin: true)

9.times do |n|
  name  = Faker::Name.name
  email = "sample#{n+1}@gmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

Category.create!(name:  "Car")
Category.create!(name:  "Television")
Category.create!(name:  "Air Conditioner")
Category.create!(name:  "Book")
Category.create!(name:  "Camera")

20.times do |n|
  name  = Faker::Restaurant.name
  category = Category.all.sample
  description = Faker::Company.catch_phrase
  user = User.all.sample
  phone = Faker::Number.number(digits: 10)
  city = Faker::Address.city
  approved_by = ([1,2]).to_a.sample if n%2==0
  Post.create!(name:  name,
               category_id: category.id,
               description: description,
               user_id: user.id,
               phone_number: phone,
               city: city,
               approved_id: approved_by)
end

@images = Dir.glob("app/assets/images/sample/*.jpg")
@images.each do |n|
  post = Post.all.sample
  Asset.create!(
    post_id: post.id,
    image: File.new(Rails.root.join(n))
  )
end

50.times do |n|
  user = User.all.sample
  post = Post.approved.sample
  approved_by = ([1,2]).to_a.sample if n%2==0
  Review.create!(post_id: post.id,
                 user_id: user.id,
                 approved_id: approved_by,
                 heading: Faker::Space.agency,
                 content: Faker::Restaurant.review,
                 rating: (1..5).to_a.sample)
end
