class Recipe < ApplicationRecord
  has_one_attached :photo
  acts_as_favoritable
  validates :title, :ingredients, :description, :cooking_time, presence: true

  scope :short_time, -> { where("cooking_time > 0 AND cooking_time < 31") }
  scope :medium_time, -> { where("cooking_time > 0 AND cooking_time < 46") }
  scope :long_time, -> { where("cooking_time > 0 AND cooking_time < 61") }

  include PgSearch::Model

  # Search by ingredients and title for homepage and recipes index
  pg_search_scope :search_by_everything,
                  against: %i[ingredients title cooking_time],
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
