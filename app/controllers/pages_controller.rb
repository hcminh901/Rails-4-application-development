class PagesController < ApplicationController
  before_action :set_site, only: [:home_page, :show]
  layout "page_layout", only: [:home_page, :show]

  def home_page
    expires_in 5.minutes
    sleep 15
    @page = Page.find_by(page_type: "Home") rescue nil
    cache_client = Dalli::Client.new "localhost:11211"
    cache_client.set "Home", @page
    value = cache_client.get "Home"
    @pages = Page.all
  end

  def show
    @pages = Page.all
  end

  private
  def set_site
    @site = SiteDetail.first
  end
end
