class Item < ApplicationRecord
  belongs_to :user
  validates :product, :bestByDate, :stock, presence: true
  # Validate best by date with alert?
  # Stock > 0?
end
