class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]

  def index
    @pins = Pin.order_by_created_at.page(params[:page])
  end

  def show
  end

  def new
    @pin = Pin.new
  end

  def edit
  end

  def create
    @pin = Pin.new(pin_params)

    respond_to do |format|
      if @pin.save
        format.html { redirect_to @pin, notice: 'Pin was successfully created.' }
        format.json { render :show, status: :created, location: @pin }
      else
        format.html { render :new }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @pin.update(pin_params)
        format.html { redirect_to @pin, notice: 'Pin was successfully updated.' }
        format.json { render :show, status: :ok, location: @pin }
      else
        format.html { render :edit }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pin.destroy
    respond_to do |format|
      format.html { redirect_to pins_url, notice: 'Pin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def pin_post
    @current_pin = Pin.friendly.find params[:id]
    @pin = @current_pin.repin_post params[:board_id]
    respond_to do |format|
      if @pin.save
        format.js {render layout: false}
      else
        format.js
      end
    end
  end

  private
    def set_pin
      @pin = Pin.friendly.find(params[:id])
    end

    def pin_params
      params.require(:pin).permit(:name, :image, :board_id, :image_cache)
    end
end
