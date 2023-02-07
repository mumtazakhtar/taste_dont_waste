class Recipe < ApplicationRecord
  has_one_attached :photo
  acts_as_favoritable
  validates :title, :ingredients, :description, :cookingTime, presence: true

  scope :short_time, -> { where("cookingTime < 46") }
  scope :medium_time, -> { where("cookingTime > 0 AND cookingTime < 46") }
  scope :long_time, -> { where("cookingTime > 0 AND cookingTime < 61") }

  include PgSearch::Model

  # Search by ingredients and title for homepage and recipes index
  pg_search_scope :search_by_everything,
                  against: %i[ingredients title cookingTime],
                  using: {
                    tsearch:
                    { prefix: true }
                  }

  # Search by cookingtime for recipes index
  pg_search_scope :search_by_cookingtime,
                  against: %i[cookingTime],
                  using: {
                    tsearch:
                    { prefix: true }
                  }
end
