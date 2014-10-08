class RestaurantsController < ApplicationController
  require "csv"
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    if params[:id].present?
      @restaurants = @current_tenant.restaurants.find params[:id]
    end
    @restaurants = Restaurant.all
  end

  def show
    @menus = Menu.where restaurant_id: @restaurant.id
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit
  end

  def create
    @restaurant = Restaurant.new restaurant_params
    @restaurant.organization_id = current_user.organizations.first.id

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: "Restaurant was successfully created." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: "Restaurant was successfully updated." }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: "Restaurant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def export_menus
    @menus = Menu.where restaurant_id: params[:restaurant_id]
    respond_to do |format|
      format.html
      format.csv {render text: @menus.export_to_csv}
    end
  end

  private
    def set_restaurant
      @restaurant = Restaurant.friendly.find params[:id]
    end

    def restaurant_params
      params.require(:restaurant).permit :name, :description,
        :slug, :organization_id
    end
end
