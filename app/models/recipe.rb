class Recipe < ActiveRecord::Base
  DIFFICULTY = %w(Easy Medium Hard)

  belongs_to :cuisine
  belongs_to :food_preference
  belongs_to :food_type
end
