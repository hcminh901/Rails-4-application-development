class Admin::DashboardController < ApplicationController
  def index
    @articles = Article.all
    @click_data = Click.get_click_data
    @impression_data = Article.get_impression_data
    @demographics = Click.get_click_by_country_data
  end
end
