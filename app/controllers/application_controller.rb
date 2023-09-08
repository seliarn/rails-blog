class ApplicationController < ActionController::Base

  # GET /
  # Fetches a list of articles in descending order by ID.
  def index
    @articles = Article.order('id DESC').all
    @categories = Category.all
  end

end
