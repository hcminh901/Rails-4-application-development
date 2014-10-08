class HomeController < ApplicationController
  def search
    if params[:search].blank?
      flash[:notice] = "Please Supply a Search term"
    else
      @board = Board.search_board params[:search]
      @pin = Pin.search_pin params[:search]
      if @board.blank? && @pin.blank?
        flash[:notice] = "No Results Found matching your query"
        @search = []
      else
        flash[:notice] = "Following are the search results"
        @search = @board + @pin
      end
    end
  end

  def index
    @plans = Plan.all.to_a
  end
end
