class MyRecipe < ApplicationRecord
  has_one_attached :photo
  belongs_to :user

  validates :title, :ingredients, :description, :cookingTime, presence: true
end
