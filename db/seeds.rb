# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'open-uri'
require 'json'

# Define your Spoonacular API key
api_key = ENV['API_KEY']

puts "Destroy all recipes"
Recipe.destroy_all

puts "Start creating recipes..."
recipe_ids = []
recipe_tags = ["dinner"]
# Define the URL for accessing the Spoonacular API
recipe_tags.each do |recipe_tag|
  puts "Requesting #{recipe_tag}"
  url = "https://api.spoonacular.com/recipes/random?tag=#{recipe_tag}&number=10&apiKey=#{api_key}"
  dinner_recipes_data = JSON.parse(URI.open(url).read)
  recipe_ids += dinner_recipes_data["recipes"].map { |recipe| recipe["id"] }
end
recipe_ids.uniq

# looping through the recipe id to create diffferent dinner recipes
recipe_ids.each do |recipe_id|
  url2 = "https://api.spoonacular.com/recipes/#{recipe_id}/information?includeNutrition=false&apiKey=#{api_key}"
  # Get the JSON data from the Spoonacular API
  recipe_data = JSON.parse(URI.open(url2).read)
  title = recipe_data["title"]
  ready_in_minutes = recipe_data["readyInMinutes"]
  image = recipe_data["image"]
  diets = recipe_data["diets"]
  servings = recipe_data["servings"]
  cuisines = recipe_data["cuisines"]

  puts "Diets------->#{diets}"
  puts "servings---->#{servings}"
  p "cuisines---->#{cuisines}"

    # IF STATEMENT to check if cuisnes servings and diets are present
    if !diets.empty? && servings

      # Ingredients for recipe
      url3 = "https://api.spoonacular.com/recipes/#{recipe_id}/ingredientWidget.json?apiKey=#{api_key}"

      ingredients_list = JSON.parse(URI.open(url3).read)
      ingredients = []
      ingredients << ingredients_list["ingredients"].map { |ingredient| ingredient["name"] }

      # instructions for 716429 id recipe
      url4 = "https://api.spoonacular.com/recipes/#{recipe_id}/analyzedInstructions?apiKey=#{api_key}"
      instructions_list = JSON.parse(URI.open(url4).read)

      instruction_steps = [] # steps for instructions
      instructions = instructions_list[0]['steps']
      instructions.map { |step| instruction_steps << step['step'] }

      # set image through cloudinary
      file = URI.open(image)

      # create a new recipe and fill it with the api data
      recipe = Recipe.new(
            title: title,
            ingredients: ingredients,
            description: instruction_steps,
            cooking_time: ready_in_minutes,
            servings: servings,
            diets: diets,
            cuisines: cuisines
          )

      recipe.photo.attach(io: file, filename: "#{title}.jpg", content_type: "image/jpg")
      recipe.save
      puts "Created recipe ##{recipe_id}: #{title}."

      # ELSE if cuisnes diets servings are not present
    else
      puts "Servings cuisines diets are not present"
    end
  #END the loop
end
recipe_amount = Recipe.count
puts "Finished creating recipes! You have a total of #{recipe_amount}"
