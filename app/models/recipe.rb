class Recipe < ApplicationRecord
  has_one_attached :photo
  acts_as_favoritable
  validates :title, :ingredients, :description, :cooking_time, presence: true

  # TO BE REMOVED IN FINAL VERSION (PLEASE LEAVE IN FOR NOW)
  # scope :veggie_diets, -> { where("diets=? OR ")} ('name=? OR lastname=?', 'John', 'Smith')
  # scope :next_five_tasks, ->(user) { where(user_id: user.id).where("due_date > ?", Date.today).where("category != ?", "Complete").order(:due_date).limit(5)}
  # scope :short_time, -> { where("cooking_time < 31") }
  # scope :ingr_time, -> { where("cooking_time <= ?", params[:cooking_time]).where("ingredients ilike ?", "%#{params[:query]}%") }

  include PgSearch::Model
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
