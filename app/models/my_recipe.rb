class MyRecipe < ApplicationRecord
  has_one_attached :photo
  belongs_to :user

  validates :title, :ingredients, :description, :cookingTime, presence: true
  # Validations to think about later:
  # Should items be destroyed when user is deleted
end
