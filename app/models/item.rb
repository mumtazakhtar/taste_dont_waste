class Item < ApplicationRecord
  belongs_to :user
  validates :product, :stock, presence: true

  def days
    days = bestByDate - Date.today
    return days.to_i
  end


  # validates :product, :bestByDate, :stock, presence: true

  # Validations to think about later:
  # Validate best by date with alert?
  # Stock > 0?
  # Should items be destroyed when user is deleted
end
