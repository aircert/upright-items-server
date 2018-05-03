class Item < ApplicationRecord
	belongs_to :user
 	belongs_to :category

	# has_many :categorizations
 	#  has_many :categories, through: :categorizations 
 	#  # Future proof incase items have more than one category. 
 	#  # Don't know if this will ever happen, but necessary for my implementation

	validates :title, presence: true, uniqueness: true, length: { minimum: 1, maximum: 255 }
  validates :description, presence: true, length: { minimum: 1, maximum: 5000 }
  validates :category_id, presence: true, inclusion: 1..100 # This may not be used if we use a category model
end
