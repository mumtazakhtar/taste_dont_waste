# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "open-uri"

puts 'Cleaning database...'
Item.destroy_all
MyRecipe.destroy_all
Recipe.destroy_all
User.destroy_all
puts 'Done!'

puts 'Creating one user'
newuser = User.create(name: 'User', email: 'user@user.com', password: 'fakepassword')
puts 'Check seeds for user login info'

puts 'Creating recipes, inventory (items) and user recipes'

recipe1 = Recipe.new(
  title: "Tomato Soup",
  ingredients: "Tomatoes, Onions, Broth, Water",
  description: "Put everything together and it will become a soup if you boil long enough",
  cooking_time: 15
)

recipe2 = Recipe.new(
  title: "Pizza Funghi",
  ingredients: "Tomatoes, Cheese, Champignons, Pizza, Oregano",
  description: "Put the ingredients on the pizza, oven it for 17 minutes and voila. Or order something.",
  cooking_time: 20
)

recipe3 = Recipe.new(
  title: "Risotto",
  ingredients: "Risotto Rice, Broth, Aspergus, Peas, Butter, Zucchini",
  description: "Slowly add the risotto rice, bit by bit, to boiling water. Meanwhile bake the veggies. Add togeter.",
  cooking_time: 30
)

photo = File.open(Rails.root.join('app/assets/images/1.jpg'))
recipe1.photo.attach(io: photo, filename: "#{recipe1.title}.jpg", content_type: "image/jpg")
recipe1.save

photo = File.open(Rails.root.join('app/assets/images/2.jpg'))
recipe2.photo.attach(io: photo, filename: "#{recipe1.title}.jpg", content_type: "image/jpg")
recipe2.save

photo = File.open(Rails.root.join('app/assets/images/3.jpg'))
recipe3.photo.attach(io: photo, filename: "#{recipe1.title}.jpg", content_type: "image/jpg")
recipe3.save

my_recipe1 = MyRecipe.new(
  title: "Tomato Soup",
  ingredients: "Tomatoes, Onions, Broth, Water",
  description: "Put everything together and it will become a soup if you boil long enough",
  cooking_time: 15,
  user: newuser
)

my_recipe2 = MyRecipe.new(
  title: "Pizza Funghi",
  ingredients: "Tomatoes, Cheese, Champignons, Pizza, Oregano",
  description: "Put the ingredients on the pizza, oven it for 17 minutes and voila. Or order something.",
  cooking_time: 20,
  user: newuser
)

my_recipe3 = MyRecipe.new(
  title: "Risotto",
  ingredients: "Risotto Rice, Broth, Aspergus, Peas, Butter, Zucchini",
  description: "Slowly add the risotto rice, bit by bit, to boiling water. Meanwhile bake the veggies. Add togeter.",
  cooking_time: 30,
  user: newuser
)

photo = File.open(Rails.root.join('app/assets/images/1.jpg'))
my_recipe1.photo.attach(io: photo, filename: "#{my_recipe1.title}.jpg", content_type: "image/jpg")
my_recipe1.save

photo = File.open(Rails.root.join('app/assets/images/2.jpg'))
my_recipe2.photo.attach(io: photo, filename: "#{my_recipe1.title}.jpg", content_type: "image/jpg")
my_recipe2.save

photo = File.open(Rails.root.join('app/assets/images/3.jpg'))
my_recipe3.photo.attach(io: photo, filename: "#{my_recipe1.title}.jpg", content_type: "image/jpg")
my_recipe3.save

Item.create!(product: "Tomato", stock: 3, user: newuser)
Item.create!(product: "Mushrooms", stock: 5, user: newuser)

puts 'Done!'
