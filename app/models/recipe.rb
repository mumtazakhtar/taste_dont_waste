class Recipe < ApplicationRecord
  has_one_attached :photo
  acts_as_favoritable
  validates :title, :ingredients, :description, :cooking_time, presence: true

  # Testing scopes for diets
  # Glutenfree
  # Vegetarian - Lacto-Vegetarian - Ovo-vetegarian
  # Vegan
  # Low FODMAP
  # Paleo - Pescetarian - Primal - Ketogenic - Whole30 NOT TO BE USED

  # TO BE REMOVED IN FINAL VERSION (PLEASE LEAVE IN FOR NOW)
  # scope :next_five_tasks, ->(user) { where(user_id: user.id).where("due_date > ?", Date.today).where("category != ?", "Complete").order(:due_date).limit(5)}
  # scope :short_time, -> { where("cooking_time < 31") }
  # scope :medium_time, -> { where("cooking_time < 46") }
  # scope :long_time, -> { where("cooking_time < 61") }
  # scope :longest_time, -> { where("cooking_time > 0") }

  include PgSearch::Model

  pg_search_scope :search_by_ingredients, against: [:ingredients], using: { tsearch: { prefix: true } }
  pg_search_scope :search_by_diets, against: [:diets], using: { tsearch: { prefix: true } }
  pg_search_scope :search_by_ingredients_and_diets, against: [:ingredients, :diets], using: { tsearch: { prefix: true } }
  pg_search_scope :search_by_cookingtime, against: [:name, :cooking_time], using: { tsearch: { prefix: true } }
# end

 # Define all different search scopes for every parameter, like search by name against name, description against description
 # and name and description against name and description
 # then use search by name and description(params)

  # Search by ingredients and title for homepage and recipes index
  pg_search_scope :search_by_everything,
                  against: %i[ingredients title],
                  using: {
                    tsearch:
                    { prefix: true }
                  }

  # Search by cooking_time for recipes index
  pg_search_scope :search_by_cooking_time,
                  against: %i[cooking_time],
                  using: {
                    tsearch:
                    { prefix: true }
                  }
end
