class HomeController < ApplicationController

  # GET /
  # Fetches a list of articles in descending order by ID.
  def index
    @articles = Article.order('id DESC').all
    @categories = Category.all
  end
end
