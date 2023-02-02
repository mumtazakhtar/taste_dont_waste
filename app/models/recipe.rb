class Recipe < ApplicationRecord
  has_one_attached :photo
  acts_as_favoritable
  validates :title, :ingredients, :description, :cookingTime, presence: true

  include PgSearch::Model

  # Now we search by title ingredients description cookingtime
  # Can be less or more later in the process
  pg_search_scope :search_by_everything,
                  against: %i[title ingredients description cookingTime],
                  using: {
                    tsearch:
                    { prefix: true }
                  }
end
