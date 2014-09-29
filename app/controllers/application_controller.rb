class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
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
