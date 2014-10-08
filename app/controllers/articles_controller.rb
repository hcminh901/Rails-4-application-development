class ArticlesController < ApplicationController
  respond_to :html
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  impressionist actions: [:show]

  def index
    @articles = Article.all
    respond_with(@articles)
  end

  def show
    @clicks = @article.track_clicks_per_article
    impressionist @article, message: "A User has viewed your article"
    @url = request.fullpath.to_s
    @ip = request.remote_ip
    @country = request.location.country
    @city = request.location.city
    if user_signed_in? && (current_user.id != @article.user_id)
      @clicks = @article.track_clicks_per_article
      Click.record @url, @ip, @country, @city, @article.id, current_user.id.to_s
    elsif !user_signed_in?
      Click.record @url, @ip, @country, @city, @article.id, "anonymous"
    end
    respond_with(@article)
  end

  def new
    @article = Article.new
    respond_with(@article)
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.save
    respond_with(@article)
  end

  def update
    @article.update(article_params)
    respond_with(@article)
  end

  def destroy
    @article.destroy
    respond_with(@article)
  end

  private
    def set_article
      @article ||= Article.find params[:id]
    end

    def article_params
      params.require(:article).permit :title, :body, :_slugs, :user_id
    end
end
