class Category < ApplicationRecord
  # # Categories can have multiple items
  # has_many :categorizations
  # has_many :items, through: :categorizations
  validates :name, presence: true, uniqueness: true
end
