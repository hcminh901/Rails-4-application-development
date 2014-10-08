class SiteDetailsController < ApplicationController
  respond_to :html
  before_action :set_site_detail, only: [:show, :edit, :update, :destroy]

  def index
    @site_details = SiteDetail.all
    respond_with(@site_details)
  end

  def show
    respond_with(@site_detail)
  end

  def new
    @site_detail = SiteDetail.new
    respond_with(@site_detail)
  end

  def edit
  end

  def create
    @site_detail = SiteDetail.new(site_detail_params)
    @site_detail.save
    respond_with(@site_detail)
  end

  def update
    @site_detail.update(site_detail_params)
    respond_with(@site_detail)
  end

  def destroy
    @site_detail.destroy
    respond_with(@site_detail)
  end

  private
    def set_site_detail
      @site_detail = SiteDetail.find(params[:id])
    end

    def site_detail_params
      params.require(:site_detail).permit(:title, :organization, :address, :facebook, :twitter, :google_plus, :skype, :linkedin, :google_analytics, :telephone)
    end
end
