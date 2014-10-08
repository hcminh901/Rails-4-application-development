class ApplicationController < ActionController::Base
  include Url
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :enable_tenant, if: :signed_in?
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

  protected
  def enable_tenant
    @current_tenant ||= Tenant.new current_user
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit :name, :organization_name, :email, :password, :password_confirmation,
        :plan_id, :active, :first_name, :last_name, :domain_name
    end
  end
end