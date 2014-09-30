class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :food_preferences, :food_types, :cuisines

  def food_preferences
    FoodPreference.all
  end

  def food_types
    FoodType.all
  end

  def cuisines
    Cuisine.all
  end
end
